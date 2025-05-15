include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mihomo-status
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=Your Name <your@email.com>

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI support for Mihomo status
  DEPENDS:=+luci-base
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_BIN) ./luasrc/controller/mihomo_status.lua $(1)/usr/lib/lua/luci/controller/mihomo_status.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/mihomo_status
	$(INSTALL_DATA) ./luasrc/view/mihomo_status/index.htm $(1)/usr/lib/lua/luci/view/mihomo_status/index.htm
endef

define Build/Compile
    # No compilation needed
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
