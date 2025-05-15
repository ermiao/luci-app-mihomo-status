module("luci.controller.mihomo_status", package.seeall)

function index()
    entry({"admin", "status", "mihomo"}, template("mihomo_status/index"), "Mihomo 状态", 90)
end
