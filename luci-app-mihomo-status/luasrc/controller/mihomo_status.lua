module("luci.controller.mihomo_status", package.seeall)

function index()
    entry({"admin", "status", "mihomo_status"}, call("action_status_page"), _("Mihomo 状态"), 90)
    entry({"admin", "status", "mihomo_status", "data"}, call("action_status_data")).leaf = true
end

function action_status_page()
    luci.template.render("mihomo_status/index")
end

function action_status_data()
    local util = require("luci.util")
    local json = require("luci.jsonc")

    local status = {}

    local full_version = util.trim(util.exec("mihomo -v 2>/dev/null"))
    local meta = full_version:match("Mihomo.-([%w%-]+)") or ""
    local gover = full_version:match("with (go[%d%.]+)") or ""
    status["版本"] = (meta ~= "" and gover ~= "") and ("Mihomo " .. meta .. " / " .. gover) or (full_version ~= "" and full_version or "未知")

    local pid = util.trim(util.exec("pidof mihomo"))
    status["运行状态"] = pid ~= "" and "运行中" or "未运行"

    local dns = util.trim(util.exec("netstat -tuln | grep ':53'"))
    status["DNS 状态"] = dns ~= "" and "正常" or "未运行"

    local mem_kb = util.trim(util.exec("grep VmRSS /proc/" .. pid .. "/status 2>/dev/null | awk '{print $2}'"))
    local mem_mb = mem_kb ~= "" and string.format("%.2f MB", tonumber(mem_kb) / 1024) or "N/A"
    status["内存占用"] = mem_mb

    local cpu_model = util.trim(util.exec("cat /proc/cpuinfo | grep 'model name' | head -n1 | cut -d ':' -f2"))
    status["CPU 型号"] = cpu_model ~= "" and util.trim(cpu_model) or "未知"

    local lan_ip = util.trim(util.exec("ip -4 addr show scope global | awk '/inet/ && !/127.0.0.1/ {print $2}' | cut -d'/' -f1 | head -n1"))
    status["本机 IP"] = lan_ip ~= "" and lan_ip or "未知"

    local gw_ip = util.trim(util.exec("ip route | grep default | awk '{print $3}' | head -n1"))
    status["默认网关"] = gw_ip ~= "" and gw_ip or "未知"

    if pid ~= "" then
        local stat_content = util.trim(util.exec("cat /proc/" .. pid .. "/stat"))
        local start_time_ticks = tonumber(stat_content:match("^%S+ %S+ %S+.- (%d+)"))
        local uptime_sec = tonumber(util.trim(util.exec("awk '{print $1}' /proc/uptime")))
        local hertz = tonumber(util.trim(util.exec("getconf CLK_TCK"))) or 100

        if start_time_ticks and uptime_sec then
            local process_uptime = uptime_sec - (start_time_ticks / hertz)
            local hours = math.floor(process_uptime / 3600)
            local minutes = math.floor((process_uptime % 3600) / 60)
            local seconds = math.floor(process_uptime % 60)
            status["本次已运行"] = string.format("%d 小时 %d 分 %d 秒", hours, minutes, seconds)
        else
            status["本次已运行"] = "N/A"
        end
    else
        status["本次已运行"] = "N/A"
    end

    local cn_ping = util.trim(util.exec("curl -I --connect-timeout 3 https://www.baidu.com >/dev/null 2>&1 && echo OK || echo FAIL"))
    local intl_ping = util.trim(util.exec("curl -I --connect-timeout 3 https://www.google.com >/dev/null 2>&1 && echo OK || echo FAIL"))
    status["百度连通性"] = cn_ping == "OK" and "可访问" or "无法访问"
    status["国际连通性"] = intl_ping == "OK" and "可访问" or "无法访问"

    local tun_check = util.trim(util.exec("ip link show dev utun 2>/dev/null"))
    status["TUN 模式"] = tun_check ~= "" and "启用" or "未启用"

    luci.http.prepare_content("application/json")
    luci.http.write(json.stringify(status))
end
