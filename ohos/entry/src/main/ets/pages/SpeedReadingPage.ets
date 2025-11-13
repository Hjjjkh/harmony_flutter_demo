import hilog from '@ohos.hilog';
import { BusinessError } from '@ohos.base';
import promptAction from '@ohos.promptAction';

const TAG = 'SpeedReadingPage';

/**
 * 倍速阅读页面
 * 支持调整阅读速度，逐字显示文本内容
 */
@Entry
@Component
struct SpeedReadingPage {
  // 当前显示的文本内容
  @State currentText: string = '';
  // 完整文本内容
  @State fullText: string = '欢迎使用倍速阅读应用！这是一个演示文本，您可以通过下方的速度控制按钮来调整阅读速度。倍速阅读可以帮助您提高阅读效率，通过控制文本显示速度来训练快速阅读能力。';
  // 当前速度倍数（1.0 = 1x, 1.5 = 1.5x, 2.0 = 2x 等）
  @State speed: number = 1.0;
  // 当前文本索引位置
  @State currentIndex: number = 0;
  // 是否正在播放
  @State isPlaying: boolean = false;
  // 是否显示文本输入对话框
  @State showTextInput: boolean = false;
  // 输入框文本
  @State inputText: string = '';
  // 定时器任务
  private timerTask: number = -1;
  // 速度选项列表
  private readonly speedOptions: number[] = [0.5, 0.75, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0];
  // 每个字符显示的基础时间（毫秒）
  private readonly baseTimePerChar: number = 200;

  aboutToAppear() {
    hilog.info(0x0000, TAG, 'SpeedReadingPage aboutToAppear');
  }

  aboutToDisappear() {
    this.stopReading();
    hilog.info(0x0000, TAG, 'SpeedReadingPage aboutToDisappear');
  }

  /**
   * 开始/暂停阅读
   */
  toggleReading() {
    if (this.isPlaying) {
      this.stopReading();
    } else {
      this.startReading();
    }
  }

  /**
   * 开始阅读
   */
  startReading() {
    if (this.currentIndex >= this.fullText.length) {
      // 如果已经读完，重新开始
      this.currentIndex = 0;
      this.currentText = '';
    }
    this.isPlaying = true;
    this.readNextChar();
  }

  /**
   * 停止阅读
   */
  stopReading() {
    this.isPlaying = false;
    if (this.timerTask !== -1) {
      clearTimeout(this.timerTask);
      this.timerTask = -1;
    }
  }

  /**
   * 重置阅读
   */
  resetReading() {
    this.stopReading();
    this.currentIndex = 0;
    this.currentText = '';
  }

  /**
   * 读取下一个字符
   */
  readNextChar() {
    if (!this.isPlaying) {
      return;
    }

    if (this.currentIndex < this.fullText.length) {
      const char = this.fullText.charAt(this.currentIndex);
      this.currentText = char;
      this.currentIndex++;

      // 计算下一个字符的延迟时间（根据速度调整）
      const delay = Math.floor(this.baseTimePerChar / this.speed);

      // 设置定时器显示下一个字符
      this.timerTask = setTimeout(() => {
        this.readNextChar();
      }, delay);
    } else {
      // 阅读完成
      this.isPlaying = false;
      hilog.info(0x0000, TAG, 'Reading completed');
    }
  }

  /**
   * 设置阅读速度
   */
  setSpeed(newSpeed: number) {
    this.speed = newSpeed;
    hilog.info(0x0000, TAG, `Speed set to ${newSpeed}x`);
  }

  /**
   * 打开文本输入对话框
   */
  openTextInputDialog() {
    promptAction.showDialog({
      title: '输入文本',
      message: '请输入要阅读的文本内容',
      buttons: [
        {
          text: '取消',
          color: '#8E8E93'
        },
        {
          text: '确定',
          color: '#007DFF'
        }
      ]
    }).then((result: promptAction.ShowDialogSuccessResponse) => {
      if (result.index === 1) {
        // 用户点击了确定，这里需要获取输入框的值
        // 由于 promptAction.showDialog 不支持输入框，我们使用自定义方式
        this.showCustomTextInput();
      }
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `Dialog error: ${err.message}`);
    });
  }

  /**
   * 显示自定义文本输入
   */
  showCustomTextInput() {
    this.showTextInput = true;
  }

  /**
   * 确认输入文本
   */
  confirmInputText() {
    if (this.inputText.trim().length > 0) {
      this.fullText = this.inputText.trim();
      this.resetReading();
      this.showTextInput = false;
      this.inputText = '';
      hilog.info(0x0000, TAG, 'Text updated');
    } else {
      promptAction.showToast({
        message: '请输入有效的文本内容',
        duration: 2000
      });
    }
  }

  /**
   * 取消输入
   */
  cancelInputText() {
    this.showTextInput = false;
    this.inputText = '';
  }

  /**
   * 格式化速度显示
   */
  formatSpeed(speed: number): string {
    return `${speed}x`;
  }

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('倍速阅读')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#182431')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F3F5')
      .padding({ left: 16, right: 16 })

      // 文本显示区域
      Column() {
        if (this.currentText.length > 0) {
          Text(this.currentText)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#182431')
            .textAlign(TextAlign.Center)
            .width('100%')
        } else {
          Text('点击开始按钮开始阅读')
            .fontSize(20)
            .fontColor('#8E8E93')
            .textAlign(TextAlign.Center)
            .width('100%')
        }

        // 进度指示
        if (this.fullText.length > 0) {
          Text(`${this.currentIndex}/${this.fullText.length}`)
            .fontSize(14)
            .fontColor('#8E8E93')
            .margin({ top: 16 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .padding({ left: 24, right: 24, top: 32, bottom: 32 })
      .backgroundColor('#FFFFFF')

      // 控制按钮区域
      Column() {
        // 速度选择按钮组
        Row() {
          ForEach(this.speedOptions, (speed: number) => {
            Button(this.formatSpeed(speed))
              .type(ButtonType.Capsule)
              .fontSize(14)
              .backgroundColor(this.speed === speed ? '#007DFF' : '#F1F3F5')
              .fontColor(this.speed === speed ? '#FFFFFF' : '#182431')
              .onClick(() => {
                this.setSpeed(speed);
              })
              .margin({ right: 8 })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 16, bottom: 16 })

        // 主要控制按钮
        Row() {
          // 重置按钮
          Button('重置')
            .type(ButtonType.Capsule)
            .fontSize(16)
            .backgroundColor('#F1F3F5')
            .fontColor('#182431')
            .onClick(() => {
              this.resetReading();
            })
            .width(100)
            .height(44)

          // 开始/暂停按钮
          Button(this.isPlaying ? '暂停' : '开始')
            .type(ButtonType.Capsule)
            .fontSize(16)
            .backgroundColor('#007DFF')
            .fontColor('#FFFFFF')
            .onClick(() => {
              this.toggleReading();
            })
            .width(200)
            .height(44)
            .margin({ left: 16, right: 16 })

          // 文本输入按钮
          Button('输入文本')
            .type(ButtonType.Capsule)
            .fontSize(16)
            .backgroundColor('#F1F3F5')
            .fontColor('#182431')
            .onClick(() => {
              this.openTextInputDialog();
            })
            .width(100)
            .height(44)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 32 })
      .backgroundColor('#F7F8FA')

      // 文本输入对话框遮罩层
      if (this.showTextInput) {
        Stack() {
          // 遮罩层
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.cancelInputText();
            })

          // 对话框内容
          Column() {
            Text('输入文本内容')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#182431')
              .margin({ bottom: 16 })

            TextArea({
              placeholder: '请输入要阅读的文本...',
              text: this.inputText
            })
              .width('100%')
              .height(200)
              .onChange((value: string) => {
                this.inputText = value;
              })
              .margin({ bottom: 16 })

            Row() {
              Button('取消')
                .type(ButtonType.Capsule)
                .fontSize(16)
                .backgroundColor('#F1F3F5')
                .fontColor('#182431')
                .onClick(() => {
                  this.cancelInputText();
                })
                .width(120)
                .height(44)

              Button('确定')
                .type(ButtonType.Capsule)
                .fontSize(16)
                .backgroundColor('#007DFF')
                .fontColor('#FFFFFF')
                .onClick(() => {
                  this.confirmInputText();
                })
                .width(120)
                .height(44)
                .margin({ left: 16 })
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }
          .width('90%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })
          .shadow({
            radius: 20,
            color: '#33000000',
            offsetX: 0,
            offsetY: 4
          })
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

