#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================
#1. Modify default IP
#sed -i 's/192.168.1.1/192.168.10.100/g' openwrt/package/base-files/files/bin/config_generate

########
NET="package/base-files/luci2/bin/config_generate"
ZZZ="package/lean/default-settings/files/zzz-default-settings"

########
sed -i 's#192.168.1.1#192.168.10.100#g' $NET               # 定制默认IP
sed -i 's#LEDE#OpenWrt#g' $NET                             # 修改默认名称为OpenWrt
sed -i "s/LEDE /Seariy build /g" $ZZZ                      # 增加自己个性名称

########

cat >> $ZZZ <<-EOF
# 设置旁路由模式
uci set network.lan.gateway='192.168.10.1'                     # 旁路由设置 IPv4 网关
uci set network.lan.dns='223.5.5.5 8.8.8.8'            # 旁路由设置 DNS(多个DNS要用空格分开)
uci set dhcp.lan.ignore='1'                                  # 旁路由关闭DHCP功能
uci delete network.lan.type                                  # 旁路由桥接模式-禁用

EOF

# 修改退出命令到最后
sed -i '/exit 0/d' $ZZZ && echo "exit 0" >> $ZZZ

########

#2. Clear the login password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

#3. 指定内核（解决部分插件不兼容的问题）
#sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=6.8/g' ./target/linux/x86/Makefile

#4. 版本号里显示一个自己的名字
#sed -i "s/OpenWrt /seariy build $(TZ=UTC-8 date "+%Y.%m.%d") @ Seariy /g" openwrt/package/lean/default-settings/files/zzz-default-settings

# 修改默认主机名
#sed -i "s/hostname='OpenWrt'/hostname='OpenWrt-Seariy'/g" openwrt/package/base-files/files/bin/config_generate

# iStore插件
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
./scripts/feeds update istore
./scripts/feeds install -d y -p istore luci-app-store

# 添加订阅源
#sed -i '$a src-git istore https://github.com/linkease/istore.git;main' feeds.conf.default
