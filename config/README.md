# Kernel module provider

新 recovery 不替换已验证的 boot/vendor_boot/DTBO。v4 bootloader 将现有 vendor_boot platform ramdisk 与 recovery ramdisk 合并；AOSP first_stage_init 在 recovery mode 读取 `/lib/modules/modules.load.recovery`。该文件已经位于匹配的 vendor_boot 中，config 下的副本用于审计，不再次覆盖。

450 个 .ko 和 445 行 load list 均来自目标已匹配的 vendor_boot；引用闭包无缺失。kernel-modules.json 保留每个 SHA256。Lineage 两个 load list 单独保留作为比较材料，不取代 OEM 列表。没有删 module、strip 或屏蔽错误。

现有能启动的 TWRP ramdisk 没有 .ko，支持该 provider 策略。新镜像仍须检查 first-stage/module/UFS/F2FS/dm/crypto/display/touch/USB 日志；在目标 boot/vendor_boot 改变时重新建立 baseline，不能沿用旧 hash。
