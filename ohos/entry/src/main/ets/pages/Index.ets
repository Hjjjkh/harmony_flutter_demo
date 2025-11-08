import hilog from '@ohos.hilog';

@Entry
@Component
struct Index {
  @State message: string = 'Hello HarmonyOS Flutter';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.message = 'Flutter 应用运行在鸿蒙平台上';
            hilog.info(0x0000, 'testTag', 'Message clicked');
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

