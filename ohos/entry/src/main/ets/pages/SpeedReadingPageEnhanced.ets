import hilog from '@ohos.hilog';
import { BusinessError } from '@ohos.base';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import { TextProcessor } from '../utils/TextProcessor';
import { FileManager } from '../utils/FileManager';
import { ReadingProgress } from '../utils/ReadingProgress';
import { HighlightManager, HighlightInfo } from '../utils/HighlightManager';
import { WordBook, WordInfo } from '../utils/WordBook';

const TAG = 'SpeedReadingPageEnhanced';

/**
 * 阅读模式枚举
 */
enum ReadingMode {
  CHAR = 'char',    // 逐字
  WORD = 'word',    // 逐词
  SENTENCE = 'sentence' // 逐句
}

/**
 * 主题类型
 */
enum ThemeType {
  LIGHT = 'light',
  DARK = 'dark',
  SEPIA = 'sepia'
}

/**
 * 增强版倍速阅读页面
 * 集成所有功能要求
 */
@Entry
@Component
struct SpeedReadingPageEnhanced {
  // 基础状态
  @State currentText: string = '';
  @State fullText: string = '欢迎使用倍速阅读应用！这是一个演示文本，您可以通过下方的速度控制按钮来调整阅读速度。倍速阅读可以帮助您提高阅读效率，通过控制文本显示速度来训练快速阅读能力。';
  @State speed: number = 1.0;
  @State currentIndex: number = 0;
  @State isPlaying: boolean = false;
  
  // 阅读模式
  @State readingMode: ReadingMode = ReadingMode.WORD;
  @State words: string[] = []; // 分词后的数组
  @State sentences: string[] = []; // 分段后的数组
  @State currentWordIndex: number = 0;
  @State currentSentenceIndex: number = 0;
  
  // UI状态
  @State showTextInput: boolean = false;
  @State showSettings: boolean = false;
  @State showWordBook: boolean = false;
  @State showHighlights: boolean = false;
  @State inputText: string = '';
  
  // 主题和字体
  @State theme: ThemeType = ThemeType.LIGHT;
  @State fontSize: number = 48;
  @State fontFamily: string = 'sans-serif';
  
  // 高亮相关
  @State selectedText: string = '';
  @State highlightStartIndex: number = -1;
  @State highlightEndIndex: number = -1;
  
  // 工具类实例
  private fileManager: FileManager | null = null;
  private progressManager: ReadingProgress | null = null;
  private highlightManager: HighlightManager | null = null;
  private wordBook: WordBook | null = null;
  private context: common.Context | null = null;
  
  // 定时器
  private timerTask: number = -1;
  private readonly speedOptions: number[] = [0.5, 0.75, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0];
  private readonly baseTimePerChar: number = 200;
  private readonly baseTimePerWord: number = 300;
  private readonly baseTimePerSentence: number = 1000;

  aboutToAppear() {
    hilog.info(0x0000, TAG, 'SpeedReadingPageEnhanced aboutToAppear');
    this.initContext();
    this.initTools();
    this.loadProgress();
    this.processText();
  }

  aboutToDisappear() {
    this.stopReading();
    this.saveProgress();
    hilog.info(0x0000, TAG, 'SpeedReadingPageEnhanced aboutToDisappear');
  }

  /**
   * 初始化Context
   * 注意：在 HarmonyOS 中，Context 需要通过 Ability 传递
   * 这里使用简化方式，实际使用时需要从 Ability 传递 context
   */
  initContext() {
    // TODO: 从 Ability 获取 context
    // 在实际使用时，应该通过页面参数或全局方式获取
    try {
      // 尝试从全局获取或使用其他方式
      // 这里暂时留空，需要在 EntryAbility 中传递
    } catch (err) {
      hilog.warn(0x0000, TAG, 'Context not available, some features may not work');
    }
  }

  /**
   * 初始化工具类
   */
  async initTools() {
    if (!this.context) {
      return;
    }

    this.fileManager = new FileManager(this.context);
    this.progressManager = new ReadingProgress(this.context);
    this.highlightManager = new HighlightManager(this.context);
    this.wordBook = new WordBook(this.context);
  }

  /**
   * 处理文本（分词、分段）
   */
  processText() {
    this.words = TextProcessor.segmentByWords(this.fullText);
    this.sentences = TextProcessor.segmentByPunctuation(this.fullText);
    hilog.info(0x0000, TAG, `Processed text: ${this.words.length} words, ${this.sentences.length} sentences`);
  }

  /**
   * 加载阅读进度
   */
  async loadProgress() {
    if (!this.progressManager) {
      return;
    }

    const progress = await this.progressManager.restoreProgress(this.fullText);
    if (progress) {
      this.currentIndex = progress.currentIndex;
      this.speed = progress.speed;
      this.readingMode = progress.mode as ReadingMode;
      hilog.info(0x0000, TAG, 'Progress restored');
    }
  }

  /**
   * 保存阅读进度
   */
  async saveProgress() {
    if (!this.progressManager) {
      return;
    }

    await this.progressManager.saveProgress(
      this.fullText,
      this.currentIndex,
      this.speed,
      this.readingMode
    );
  }

  /**
   * 切换阅读模式
   */
  switchMode(mode: ReadingMode) {
    this.stopReading();
    this.readingMode = mode;
    this.currentIndex = 0;
    this.currentWordIndex = 0;
    this.currentSentenceIndex = 0;
    this.currentText = '';
    this.saveProgress();
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
      this.resetReading();
    }
    this.isPlaying = true;
    this.readNext();
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
    this.saveProgress();
  }

  /**
   * 重置阅读
   */
  resetReading() {
    this.stopReading();
    this.currentIndex = 0;
    this.currentWordIndex = 0;
    this.currentSentenceIndex = 0;
    this.currentText = '';
  }

  /**
   * 读取下一个内容（根据模式）
   */
  readNext() {
    if (!this.isPlaying) {
      return;
    }

    let delay: number;
    let nextText: string = '';

    switch (this.readingMode) {
      case ReadingMode.CHAR:
        if (this.currentIndex < this.fullText.length) {
          nextText = this.fullText.charAt(this.currentIndex);
          this.currentIndex++;
          delay = Math.floor(this.baseTimePerChar / this.speed);
        } else {
          this.isPlaying = false;
          return;
        }
        break;

      case ReadingMode.WORD:
        if (this.currentWordIndex < this.words.length) {
          nextText = this.words[this.currentWordIndex];
          this.currentWordIndex++;
          this.currentIndex += nextText.length;
          delay = Math.floor(this.baseTimePerWord / this.speed);
        } else {
          this.isPlaying = false;
          return;
        }
        break;

      case ReadingMode.SENTENCE:
        if (this.currentSentenceIndex < this.sentences.length) {
          nextText = this.sentences[this.currentSentenceIndex];
          this.currentSentenceIndex++;
          this.currentIndex += nextText.length;
          delay = Math.floor(this.baseTimePerSentence / this.speed);
        } else {
          this.isPlaying = false;
          return;
        }
        break;
    }

    this.currentText = nextText;

    this.timerTask = setTimeout(() => {
      this.readNext();
    }, delay);
  }

  /**
   * 设置速度
   */
  setSpeed(newSpeed: number) {
    this.speed = newSpeed;
    this.saveProgress();
  }

  /**
   * 导入文件
   */
  async importFile() {
    if (!this.fileManager) {
      promptAction.showToast({ message: '文件管理器未初始化', duration: 2000 });
      return;
    }

    try {
      const content = await this.fileManager.pickTextFile();
      this.fullText = TextProcessor.cleanText(content);
      this.processText();
      this.resetReading();
      promptAction.showToast({ message: '文件导入成功', duration: 2000 });
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to import file: ${(err as BusinessError).message}`);
      promptAction.showToast({ message: '文件导入失败', duration: 2000 });
    }
  }

  /**
   * 添加高亮
   */
  async addHighlight() {
    if (!this.highlightManager || this.highlightStartIndex < 0 || this.highlightEndIndex < 0) {
      return;
    }

    await this.highlightManager.addHighlight(
      this.fullText,
      this.highlightStartIndex,
      this.highlightEndIndex,
      '#FFD700' // 金色高亮
    );

    this.highlightStartIndex = -1;
    this.highlightEndIndex = -1;
    this.selectedText = '';
    promptAction.showToast({ message: '已添加高亮', duration: 2000 });
  }

  /**
   * 添加生词
   */
  async addToWordBook(word: string) {
    if (!this.wordBook) {
      return;
    }

    const definition = await this.wordBook.queryDictionary(word);
    await this.wordBook.addWord(word, definition);
    promptAction.showToast({ message: `已添加生词: ${word}`, duration: 2000 });
  }

  /**
   * 格式化速度显示
   */
  formatSpeed(speed: number): string {
    return `${speed}x`;
  }

  /**
   * 获取主题颜色
   */
  getThemeColors() {
    switch (this.theme) {
      case ThemeType.DARK:
        return {
          bg: '#1C1C1E',
          text: '#FFFFFF',
          card: '#2C2C2E'
        };
      case ThemeType.SEPIA:
        return {
          bg: '#F4ECD8',
          text: '#3E2723',
          card: '#E8DDD0'
        };
      default:
        return {
          bg: '#FFFFFF',
          text: '#182431',
          card: '#F7F8FA'
        };
    }
  }

  build() {
    const colors = this.getThemeColors();

    Column() {
      // 标题栏
      Row() {
        Text('倍速阅读')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(colors.text)

        Blank()

        // 设置按钮
        Button() {
          Image($r('sys.media.ohos_ic_settings'))
            .width(24)
            .height(24)
        }
        .type(ButtonType.Circle)
        .backgroundColor('#00000000')
        .onClick(() => {
          this.showSettings = !this.showSettings;
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(colors.card)

      // 文本显示区域
      Column() {
        if (this.currentText.length > 0) {
          Text(this.currentText)
            .fontSize(this.fontSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(colors.text)
            .fontFamily(this.fontFamily)
            .textAlign(TextAlign.Center)
            .width('100%')
            .onLongPress(() => {
              // 长按选择文本（简化实现）
              if (this.currentText.trim().length > 0) {
                this.selectedText = this.currentText;
                promptAction.showDialog({
                  title: '操作',
                  message: `选择文本: ${this.selectedText}`,
                  buttons: [
                    { text: '添加高亮', color: '#007DFF' },
                    { text: '添加生词', color: '#007DFF' },
                    { text: '取消', color: '#8E8E93' }
                  ]
                }).then((result: promptAction.ShowDialogSuccessResponse) => {
                  if (result.index === 0) {
                    // 添加高亮
                    this.addHighlight();
                  } else if (result.index === 1) {
                    // 添加生词
                    this.addToWordBook(this.selectedText);
                  }
                });
              }
            })
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
      .backgroundColor(colors.bg)

      // 控制按钮区域
      Column() {
        // 阅读模式切换
        Row() {
          Button('逐字')
            .type(ButtonType.Capsule)
            .fontSize(14)
            .backgroundColor(this.readingMode === ReadingMode.CHAR ? '#007DFF' : '#F1F3F5')
            .fontColor(this.readingMode === ReadingMode.CHAR ? '#FFFFFF' : '#182431')
            .onClick(() => this.switchMode(ReadingMode.CHAR))
            .margin({ right: 8 })

          Button('逐词')
            .type(ButtonType.Capsule)
            .fontSize(14)
            .backgroundColor(this.readingMode === ReadingMode.WORD ? '#007DFF' : '#F1F3F5')
            .fontColor(this.readingMode === ReadingMode.WORD ? '#FFFFFF' : '#182431')
            .onClick(() => this.switchMode(ReadingMode.WORD))
            .margin({ right: 8 })

          Button('逐句')
            .type(ButtonType.Capsule)
            .fontSize(14)
            .backgroundColor(this.readingMode === ReadingMode.SENTENCE ? '#007DFF' : '#F1F3F5')
            .fontColor(this.readingMode === ReadingMode.SENTENCE ? '#FFFFFF' : '#182431')
            .onClick(() => this.switchMode(ReadingMode.SENTENCE))
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 16, bottom: 8 })

        // 速度选择按钮组
        Row() {
          ForEach(this.speedOptions, (speed: number) => {
            Button(this.formatSpeed(speed))
              .type(ButtonType.Capsule)
              .fontSize(14)
              .backgroundColor(this.speed === speed ? '#007DFF' : '#F1F3F5')
              .fontColor(this.speed === speed ? '#FFFFFF' : '#182431')
              .onClick(() => this.setSpeed(speed))
              .margin({ right: 8 })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 16 })

        // 主要控制按钮
        Row() {
          Button('导入文件')
            .type(ButtonType.Capsule)
            .fontSize(16)
            .backgroundColor('#F1F3F5')
            .fontColor('#182431')
            .onClick(() => this.importFile())
            .width(100)
            .height(44)

          Button('重置')
            .type(ButtonType.Capsule)
            .fontSize(16)
            .backgroundColor('#F1F3F5')
            .fontColor('#182431')
            .onClick(() => this.resetReading())
            .width(100)
            .height(44)
            .margin({ left: 8 })

          Button(this.isPlaying ? '暂停' : '开始')
            .type(ButtonType.Capsule)
            .fontSize(16)
            .backgroundColor('#007DFF')
            .fontColor('#FFFFFF')
            .onClick(() => this.toggleReading())
            .width(120)
            .height(44)
            .margin({ left: 8, right: 8 })

          Button('输入文本')
            .type(ButtonType.Capsule)
            .fontSize(16)
            .backgroundColor('#F1F3F5')
            .fontColor('#182431')
            .onClick(() => {
              this.showTextInput = true;
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
      .backgroundColor(colors.card)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colors.bg)
  }
}

