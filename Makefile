
include $(TOPDIR)/rules.mk

LUCI_TITLE:=Mihomo 状态监控
LUCI_DEPENDS:=+luci
PKG_NAME:=luci-app-mihomo-status
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=ChatGPT
PKG_LICENSE:=MIT
PKG_ARCH:=x86_64

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/luci.mk

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./root/usr/bin/mihomo_status.sh $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/mihomo_status.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/mihomo_status
	$(INSTALL_DATA) ./luasrc/view/mihomo_status/status.htm $(1)/usr/lib/lua/luci/view/mihomo_status/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
