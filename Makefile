include $(TOPDIR)/rules.mk

PKG_NAME:=pump
PKG_VERSION:=0.0.1
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/pump-utils-$(PKG_VERSION)
PKG_SOURCE:=pump-utils-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=@SF/pump
PKG_MD5SUM:=9b7dc52656f5cbec846a7ba3299f73bd
PKG_CAT:=zcat

include $(INCLUDE_DIR)/package.mk

define Package/pump/description
	Water pump controller utilites.
endef

define Package/pump
	CATEGORY:=Pump
	SECTION:=pump
	TITLE:=Pump-controller
	DEPENDS:=@!LINUX_3_1
	URL:=file://./pump.tar
	MENU:=1
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
	$(PKG_BUILD_DIR)/version.sh $(PKG_BUILD_DIR)/
endef

target=$(firstword $(subst -, ,$(BOARD)))

MAKE_FLAGS += TARGET="$(target)"
TARGET_CFLAGS := $(TARGET_CFLAGS) -Dtarget_$(target)=1 -Wall


define Package/pump/install
	$(INSTALL_DIR) $(1)
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pump $(1)
endef

$(eval $(call BuildPackage,pump))

