import hilog from '@ohos.hilog';
import preferences from '@ohos.data.preferences';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';

const TAG = 'WordBook';

/**
 * 生词信息
 */
export interface WordInfo {
  word: string;
  definition?: string; // 释义
  example?: string; // 例句
  addTime: number; // 添加时间戳
  reviewCount: number; // 复习次数
  lastReviewTime?: number; // 最后复习时间
}

/**
 * 生词本管理类
 */
export class WordBook {
  private context: common.Context;
  private preferencesStore: preferences.Preferences | null = null;
  private readonly PREF_NAME = 'wordbook';
  private readonly KEY_WORDS = 'words';
  private words: Map<string, WordInfo> = new Map();
  private initializing: Promise<void> | null = null;

  constructor(context: common.Context) {
    this.context = context;
    this.initializing = this.setup();
  }

  /**
   * 初始化Preferences
   */
  private async setup() {
    try {
      this.preferencesStore = await preferences.getPreferences(this.context, this.PREF_NAME);
      await this.loadWords();
      hilog.info(0x0000, TAG, 'WordBook initialized');
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to init preferences: ${(err as BusinessError).message}`);
    }
  }

  private async initPreferences() {
    if (this.preferencesStore) {
      return;
    }

    if (!this.initializing) {
      this.initializing = this.setup();
    }

    await this.initializing;
  }

  /**
   * 等待初始化完成
   */
  async ready() {
    await this.initPreferences();
  }

  /**
   * 加载生词数据
   */
  private async loadWords() {
    if (!this.preferencesStore) {
      return;
    }

    try {
      const wordsJson = await this.preferencesStore.get(this.KEY_WORDS, '{}');
      const wordsObj = JSON.parse(wordsJson as string) as Record<string, WordInfo>;

      this.words.clear();
      for (const word in wordsObj) {
        this.words.set(word, wordsObj[word]);
      }

      hilog.info(0x0000, TAG, `Loaded ${this.words.size} words`);
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to load words: ${(err as BusinessError).message}`);
    }
  }

  /**
   * 添加生词
   * @param word 单词
   * @param definition 释义
   * @param example 例句
   */
  async addWord(word: string, definition?: string, example?: string): Promise<void> {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      return;
    }

    const normalized = word.trim();
    if (normalized.length === 0) {
      return;
    }

    const wordInfo: WordInfo = {
      word: normalized,
      definition,
      example,
      addTime: Date.now(),
      reviewCount: 0
    };

    this.words.set(normalized, wordInfo);
    await this.saveWords();

    hilog.info(0x0000, TAG, `Word added: ${normalized}`);
  }

  /**
   * 删除生词
   * @param word 单词
   */
  async removeWord(word: string): Promise<void> {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      return;
    }

    this.words.delete(word);
    await this.saveWords();

    hilog.info(0x0000, TAG, `Word removed: ${word}`);
  }

  /**
   * 获取所有生词（按添加时间倒序）
   * @returns 生词数组
   */
  getAllWords(): WordInfo[] {
    return Array.from(this.words.values())
      .sort((a, b) => b.addTime - a.addTime)
      .map(item => ({ ...item }));
  }

  /**
   * 根据复习次数排序
   */
  getWordsByReview(): WordInfo[] {
    return Array.from(this.words.values())
      .sort((a, b) => (b.reviewCount - a.reviewCount) || (b.addTime - a.addTime))
      .map(item => ({ ...item }));
  }

  /**
   * 检查单词是否在生词本中
   * @param word 单词
   * @returns 是否在生词本中
   */
  hasWord(word: string): boolean {
    return this.words.has(word.trim());
  }

  /**
   * 更新生词复习信息
   * @param word 单词
   */
  async updateReview(word: string): Promise<void> {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      return;
    }

    const normalized = word.trim();
    const wordInfo = this.words.get(normalized);
    if (wordInfo) {
      wordInfo.reviewCount++;
      wordInfo.lastReviewTime = Date.now();
      this.words.set(normalized, wordInfo);
      await this.saveWords();
    }
  }

  /**
   * 保存生词数据
   */
  private async saveWords() {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      return;
    }

    try {
      const wordsObj: Record<string, WordInfo> = {};
      for (const [word, info] of this.words.entries()) {
        wordsObj[word] = info;
      }

      const json = JSON.stringify(wordsObj);
      await this.preferencesStore.put(this.KEY_WORDS, json);
      await this.preferencesStore.flush();
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to save words: ${(err as BusinessError).message}`);
    }
  }

  /**
   * 查询词典（简单实现，返回示例释义）
   * @param word 单词
   * @returns 释义
   */
  async queryDictionary(word: string): Promise<string> {
    await this.ready();

    const normalized = word.trim();
    const wordInfo = this.words.get(normalized);
    if (wordInfo && wordInfo.definition) {
      return wordInfo.definition;
    }

    // 示例词典数据
    const dictionary: Record<string, string> = {
      'hello': '你好；问候',
      'world': '世界',
      'read': '阅读；读取',
      'book': '书；书籍',
      'text': '文本；文字'
    };

    return dictionary[normalized.toLowerCase()] || '未找到释义';
  }

  /**
   * 导出为文本（简单 JSON 字符串）
   */
  exportAsJson(): string {
    const wordsObj: Record<string, WordInfo> = {};
    for (const [word, info] of this.words.entries()) {
      wordsObj[word] = info;
    }
    return JSON.stringify(wordsObj, null, 2);
  }
}

