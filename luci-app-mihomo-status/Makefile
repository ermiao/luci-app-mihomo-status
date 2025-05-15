include $(TOPDIR)/rules.mk

LUCI_TITLE:=Mihomo 状态查看器
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+curl +luci-base

PKG_NAME:=luci-app-mihomo-status
PKG_VERSION:=1.0.2
PKG_RELEASE:=1

include $(TOPDIR)/feeds/luci/luci.mk

# 仅使用 luci.mk 就足够，不需要额外 include package.mk
# $(eval $(call BuildPackage,$(PKG_NAME))) 会由 luci.mk 自动调用
