# 媒体资源目录

此目录用于存放应用的图标和图片资源。

## 需要的资源文件

1. **应用图标** (`app_icon.png`)
   - 用于应用图标显示
   - 建议尺寸: 512x512 像素
   - 格式: PNG

2. **能力图标** (`icon.png`)
   - 用于 EntryAbility 图标显示
   - 建议尺寸: 256x256 像素
   - 格式: PNG

## 配置说明

在以下配置文件中引用了这些资源：

- `ohos/AppScope/app.json5`: 引用 `$media:app_icon`
- `ohos/entry/src/main/module.json5`: 引用 `$media:icon`

## 注意事项

- 如果没有图标文件，应用可能无法正常构建
- 可以使用占位图标进行测试
- 建议使用符合鸿蒙设计规范的应用图标

## 临时解决方案

如果暂时没有图标文件，可以：
1. 从 Android 项目的 `android/app/src/main/res/mipmap-*/ic_launcher.png` 复制图标
2. 重命名为 `app_icon.png` 和 `icon.png`
3. 放置在此目录中

