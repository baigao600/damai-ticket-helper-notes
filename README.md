# 大麦票务助手 · Windows 实机验证记录

记录基于 [Lzhimie/damai-ticket-helper v1.0.0](https://github.com/Lzhimie/damai-ticket-helper/releases/tag/v1.0.0) 的 Windows 环境搭建、手机连接排查和选票页面兼容性验证。上游项目源自 [WECENG/ticket-purchase](https://github.com/WECENG/ticket-purchase)。

## 本项目的原创贡献

本项目独立编写了 Windows / Android 诊断脚本、兼容性排查记录和回归测试。具体修复、验证方法与未验收项见[实机与回归验证记录](VERIFICATION.md)。

## 验证状态

| 项目 | 结果 |
| --- | --- |
| Windows 图形界面、配置保存和读取 | 已验证 |
| Android USB 调试、Appium 会话建立和关闭 | 已在 Mate 10 验证 |
| 大麦演出识别与预约状态判断 | 已在演出页面验证 |
| 场次与票档卡片定位 | 本地修复通过页面回放测试，待实机复验 |
| 实际下单与支付 | 尚未验证 |

本地修订版最近一次回归运行通过 41 项测试。当前仓库仅收录项目说明及独立诊断工具。上游源码和原发行包请从上游仓库获取。

## 检查手机连接

安装 Android SDK Platform-Tools 后，用数据线连接并解锁手机，在手机上开启 USB 调试并确认授权。在 PowerShell 中运行：

```powershell
.\check-adb.ps1
```

默认调用 PATH 中的 adb。也可以用 -AdbPath 指定可执行文件、用 -Port 指定调试端口。工具只输出连接状态，不显示设备序列号。

- 无设备：检查 USB 线、接口和文件传输模式。
- 尚未授权：在解锁的手机上确认 USB 调试提示。
- 多台设备：断开其他调试设备后重试。
