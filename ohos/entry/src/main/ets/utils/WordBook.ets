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

  constructor(context: common.Context) {
    this.context = context;
    this.initPreferences();
  }

  /**
   * 初始化Preferences
   */
  private async initPreferences() {
    try {
      this.preferencesStore = await preferences.getPreferences(this.context, this.PREF_NAME);
      await this.loadWords();
      hilog.info(0x0000, TAG, 'WordBook initialized');
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to init preferences: ${(err as BusinessError).message}`);
    }
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

    const wordInfo: WordInfo = {
      word,
      definition,
      example,
      addTime: Date.now(),
      reviewCount: 0
    };

    this.words.set(word, wordInfo);
    await this.saveWords();

    hilog.info(0x0000, TAG, `Word added: ${word}`);
  }

  /**
   * 删除生词
   * @param word 单词
   */
  async removeWord(word: string): Promise<void> {
    if (!this.preferencesStore) {
      return;
    }

    this.words.delete(word);
    await this.saveWords();

    hilog.info(0x0000, TAG, `Word removed: ${word}`);
  }

  /**
   * 获取所有生词
   * @returns 生词数组
   */
  getAllWords(): WordInfo[] {
    return Array.from(this.words.values());
  }

  /**
   * 检查单词是否在生词本中
   * @param word 单词
   * @returns 是否在生词本中
   */
  hasWord(word: string): boolean {
    return this.words.has(word);
  }

  /**
   * 更新生词复习信息
   * @param word 单词
   */
  async updateReview(word: string): Promise<void> {
    if (!this.preferencesStore) {
      return;
    }

    const wordInfo = this.words.get(word);
    if (wordInfo) {
      wordInfo.reviewCount++;
      wordInfo.lastReviewTime = Date.now();
      this.words.set(word, wordInfo);
      await this.saveWords();
    }
  }

  /**
   * 保存生词数据
   */
  private async saveWords() {
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
    // 这里应该调用实际的词典API
    // 目前返回示例数据
    const wordInfo = this.words.get(word);
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

    return dictionary[word.toLowerCase()] || '未找到释义';
  }
}

