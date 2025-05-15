module("luci.controller.mihomo_status", package.seeall)

function index()
    entry({"admin", "status", "mihomo_status"}, call("action_status_page"), _("Mihomo Status"), 90)
    entry({"admin", "status", "mihomo_status", "data"}, call("action_status_data")).leaf = true
end

function action_status_page()
    luci.template.render("mihomo_status/index")
end

function action_status_data()
    local util = require("luci.util")
    local sys = require("luci.sys")
    local json = require("luci.jsonc")

    local status = {}

    local version = util.trim(util.exec("mihomo -v 2>/dev/null"))
    status.version = version ~= "" and version or "Unknown"

    local pid = util.trim(util.exec("pidof mihomo"))
    status.proxy = pid ~= "" and "Active" or "Inactive"

    local dns_check = util.trim(util.exec("netstat -tuln | grep ':53'"))
    status.dns = dns_check ~= "" and "Working" or "Not Running"

    local mem_usage = util.trim(util.exec("top -b -n1 | grep '[m]ihomo' | awk '{print $6}'"))
    status.mem = mem_usage ~= "" and mem_usage .. " KB" or "N/A"

    local cpu_usage = util.trim(util.exec("top -b -n1 | grep '[m]ihomo' | awk '{print $9}'"))
    status.cpu = cpu_usage ~= "" and cpu_usage .. "%" or "N/A"

    if pid ~= "" then
        local ticks = util.trim(util.exec("cat /proc/" .. pid .. "/stat | awk '{print $22}'"))
        local hertz = tonumber(util.trim(util.exec("getconf CLK_TCK"))) or 100
        local boot_ticks = tonumber(ticks)
        local seconds = boot_ticks and math.floor(boot_ticks / hertz) or nil
        status.uptime = seconds and string.format("%d min %d sec", math.floor(seconds / 60), seconds % 60) or "N/A"
        status.started_at = seconds and os.date("%Y-%m-%d %H:%M:%S", os.time() - seconds) or "N/A"
    else
        status.uptime = "N/A"
        status.started_at = "N/A"
    end

    luci.http.prepare_content("application/json")
    luci.http.write(json.stringify(status))
end
