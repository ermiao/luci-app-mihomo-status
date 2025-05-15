
module("luci.controller.mihomo_status", package.seeall)

function index()
    entry({"admin", "status", "mihomo_status"}, template("mihomo_status/status"), _("Mihomo 状态"), 90)
end
