include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-mihomo-status
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
PKG_FLAGS := nonshared

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=LuCI for Mihomo status display
  DEPENDS:=+luci-base
endef

define Build/Compile
	# nothing to compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/mihomo_status.lua $(1)/usr/lib/lua/luci/controller/mihomo_status.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/mihomo_status
	$(INSTALL_DATA) ./luasrc/view/mihomo_status/index.htm $(1)/usr/lib/lua/luci/view/mihomo_status/index.htm
endef

$(eval $(call BuildPackage,$(PKG_NAME)))