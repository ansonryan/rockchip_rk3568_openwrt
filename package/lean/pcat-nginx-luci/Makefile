include $(TOPDIR)/rules.mk

PKG_NAME:=pcat-nginx-luci
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=
PKG_ARCH:=aarch64

include $(INCLUDE_DIR)/package.mk

define Package/pcat-nginx-luci
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Photonicat Nginx + LuCI on port 8080
  DEPENDS:=+nginx +nginx-mod-luci +uwsgi +uwsgi-luci-support +uwsgi-python3-plugin
endef

define Package/pcat-nginx-luci/description
  Configures nginx to serve LuCI on port 8080 (HTTP, not HTTPS).
  Port 80 is left for pcat-manager-web.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/pcat-nginx-luci/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/zz_nginx_luci_8080 $(1)/etc/uci-defaults/zz_nginx_luci_8080
endef

$(eval $(call BuildPackage,pcat-nginx-luci))
