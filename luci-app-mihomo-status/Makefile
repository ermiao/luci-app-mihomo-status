include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mihomo-status
PKG_VERSION:=1.0.2
PKG_RELEASE:=1
PKG_MAINTAINER:=you@example.com

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=Mihomo 状态查看器
  DEPENDS:=+curl +luci-base
endef

define Build/Compile
	# nothing to compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/mihomo_status.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/mihomo_status
	$(INSTALL_DATA) ./luasrc/view/mihomo_status/index.htm $(1)/usr/lib/lua/luci/view/mihomo_status/

	$(INSTALL_DIR) $(1)/usr/share/luci/i18n
	$(INSTALL_DATA) ./po/zh_Hans/mihomo_status.po $(1)/usr/share/luci/i18n/mihomo_status.zh_Hans.po
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
