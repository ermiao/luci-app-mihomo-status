include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for Mihomo Status
LUCI_DEPENDS:=
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

PKG_NAME:=luci-app-mihomo-status
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_BIN) ./luasrc/controller/mihomo_status.lua $(1)/usr/lib/lua/luci/controller/mihomo_status.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/mihomo_status
	$(INSTALL_BIN) ./luasrc/view/mihomo_status/index.htm $(1)/usr/lib/lua/luci/view/mihomo_status/index.htm
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
