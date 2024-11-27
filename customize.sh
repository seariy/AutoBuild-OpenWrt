#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: eSirPlayground
# Youtube Channel: https://goo.gl/fvkdwm 
#=================================================

########
NET="openwrt/package/base-files/luci2/bin/config_generate"
ZZZ="openwrt/package/lean/default-settings/files/zzz-default-settings"

########
sed -i 's#192.168.1.1#192.168.10.254#g' $NET               # 定制默认IP
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

# Clear the login password
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 添加订阅源
#sed -i '$a src-git istore https://github.com/linkease/istore.git;main' feeds.conf.default
