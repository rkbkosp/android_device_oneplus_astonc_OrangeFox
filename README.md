# OrangeFox device tree for OnePlus Ace 3

国行 OnePlus Ace 3：PJE110 / OP5CF9L1，`astonc`，SM8550 / kalama，arm64。
基于 OrangeFox `fox_16.0`（Android 16 userspace），目标为已实测的
ColorOS Android 17 移植 ROM。此仓库是独立设备树，应放在
`device/oneplus/astonc`。

设备树历史从 [astonc-orangefox](https://github.com/rkbkosp/astonc-orangefox)
的设备目录拆分，保留阶段化提交。设备配置对应通过真机验收的 build-14
以及空输出目录重编译通过的 build-15；build-15 未单独刷机测试。
这不是官方 OrangeFox 发布。

## 已验证与待验证

Build-14 通过启动/稳定性、显示/触摸/ADB、PIN 解密、metadata/DE/CE、
内部存储读写与文件管理、init_boot 备份及摘要核对、真实电量/充电标记、
日期/北京时间、状态栏、终端/键盘、息屏唤醒、主题/语言/设置持久化、
fastbootd 只读查询及返回、Sideload 连接/取消返回。
亮度、CPU 显示、手电筒和 KernelSU 模块管理有 build-10 的独立验收记录。

压缩备份引擎、Recovery 界面锁、其他 Android 锁屏类型仍未通过验收；
MTP 当前关闭，MTP/OTG 缺少测试条件；震动无效，用户接受暂缓。
SELinux 保留上游/debug 的八个 permissive domains，尚不是全域 enforcing。
刷包/刷镜像功能、擦除/格式化、恢复到真实分区及自动 root/OTA 修改
按用户要求排除测试，不标记为通过。

完整状态、原始依据与安全测试范围见主项目
[STATUS](https://github.com/rkbkosp/astonc-orangefox/blob/bringup/STATUS.md)、
[验收矩阵](https://github.com/rkbkosp/astonc-orangefox/blob/bringup/docs/FEATURE_MATRIX.md)、
[build-14 实测](https://github.com/rkbkosp/astonc-orangefox/blob/bringup/docs/tests/2026-10-02-build-14/RESULT.md)。

## 编译

设备使用独立、100 MiB、v4/LZ4、无内核的 recovery 镜像；复用已匹配
boot/vendor_boot 的 kernel ABI。A/B、dynamic partitions、F2FS、wrapped
metadata encryption 配置来自目标设备。无需完整 LineageOS device tree。

```sh
git clone --branch fox_16.0 https://github.com/rkbkosp/android_device_oneplus_astonc_OrangeFox.git device/oneplus/astonc
```

仅 clone 此仓库不足以编译。需要锁定的 OrangeFox manifest、主项目记录的
userspace 补丁，以及相同 ROM 的私有 hardware/crypto 依赖。复现 build-14/15
请使用主项目 commit `04e267d5de5af7a92187f6325e2deda71b5b8686` 的
[BUILD.md](https://github.com/rkbkosp/astonc-orangefox/blob/04e267d5de5af7a92187f6325e2deda71b5b8686/BUILD.md)，
按文档获取私有输入、应用 `patches/SERIES.json` 并核对全部哈希。
本仓库不包含 OEM 镜像、proprietary binary、设备日志或密钥。
私有导入资产的位置和 SHA256 在 `config/` 清单中。

完成源码补丁和私有资产导入后，编译入口为：

```sh
export ALLOW_MISSING_DEPENDENCIES=true
source device/oneplus/astonc/vendorsetup.sh
source build/envsetup.sh
lunch twrp_astonc-bp2a-eng
mka -j6 recoveryimage
```

产物为 `out/target/product/astonc/recovery.img`。保留常规 `twrp_astonc`
product 名称，实际构建 OrangeFox。主项目 wrapper 包含最终 CPIO、ELF、
crypto/init/policy/UI、资产和 AVB 检查，应以其验收结果作为交付依据。

## 来源与维护

OrangeFox official `fox_16.0`，实测 TWRP build-21，LineageOS astonc /
sm8550-common `lineage-23.2` 硬件参考，以及目标 stock/current 输入。
详细来源在主项目 [PORTING](https://github.com/rkbkosp/astonc-orangefox/blob/bringup/PORTING.md)
和 [CRYPTO_NOTES](https://github.com/rkbkosp/astonc-orangefox/blob/bringup/CRYPTO_NOTES.md)。
本树与已有 TWRP `rkbkosp/android_device_oneplus_astonc` 仓库分别维护。

目标 ROM、boot/vendor_boot ABI 或 security patch 改变时重新收集 baseline；
不要替换旧 blobs、删除 FBE 参数或伪造 security patch 来绕过故障。
