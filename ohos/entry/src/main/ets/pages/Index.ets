import hilog from '@ohos.hilog';
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Harmony Flutter Demo';

  build() {
    Column() {
      // 标题
      Text(this.message)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#182431')
        .margin({ top: 60, bottom: 40 })

      // 应用图标
      Text('📱')
        .fontSize(80)
        .margin({ bottom: 40 })

      // 功能列表
      Column() {
        // 倍速阅读入口
        Button('倍速阅读')
          .type(ButtonType.Capsule)
          .fontSize(18)
          .backgroundColor('#007DFF')
          .fontColor('#FFFFFF')
          .width('80%')
          .height(56)
          .onClick(() => {
            hilog.info(0x0000, 'Index', 'Navigate to SpeedReadingPage');
            router.pushUrl({
              url: 'pages/SpeedReadingPage'
            }).catch((err: Error) => {
              hilog.error(0x0000, 'Index', `Failed to navigate: ${err.message}`);
            });
          })
          .margin({ bottom: 16 })

        // 其他功能入口（预留）
        Text('更多功能即将推出...')
          .fontSize(14)
          .fontColor('#8E8E93')
          .margin({ top: 20 })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)

      // 底部信息
      Text('HarmonyOS + Flutter')
        .fontSize(12)
        .fontColor('#8E8E93')
        .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 24, right: 24 })
  }
}

