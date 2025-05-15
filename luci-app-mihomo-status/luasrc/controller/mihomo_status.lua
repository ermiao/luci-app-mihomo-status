module("luci.controller.mihomo_status", package.seeall)

function index()
    entry({"admin", "status", "mihomo"}, template("mihomo_status/index"), _("Mihomo Status"), 90)
end
