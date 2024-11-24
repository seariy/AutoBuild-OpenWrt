#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================
#1. Modify default IP
sed -i 's/192.168.1.1/192.168.10.100/g' openwrt/package/base-files/files/bin/config_generate

#2. Clear the login password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

#3. 指定内核（解决部分插件不兼容的问题）
sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=6.8/g' ./target/linux/x86/Makefile

#4. 版本号里显示一个自己的名字
sed -i "s/OpenWrt /seariy build $(TZ=UTC-8 date "+%Y.%m.%d") @ Seariy /g" openwrt/package/lean/default-settings/files/zzz-default-settings

#5. 修改主机名
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenWrt'' openwrt/package/lean/default-settings/files/zzz-default-settings
