include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for Mihomo Status
LUCI_DEPENDS:=+curl +luci-base
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-mihomo-status
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)/install
	$(CP) ./root/* $(1)/
	$(CP) -r ./luasrc/* $(1)/usr/lib/lua/
	$(CP) -r ./po/* $(1)/usr/share/luci/i18n/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))