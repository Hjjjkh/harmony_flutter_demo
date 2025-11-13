import hilog from '@ohos.hilog';
import preferences from '@ohos.data.preferences';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';

const TAG = 'HighlightManager';

/**
 * 高亮标注信息
 */
export interface HighlightInfo {
  startIndex: number;
  endIndex: number;
  text: string;
  color: string;
  note?: string; // 备注
}

/**
 * 高亮管理类
 * 负责保存和管理文本高亮标注
 */
export class HighlightManager {
  private context: common.Context;
  private preferencesStore: preferences.Preferences | null = null;
  private readonly PREF_NAME = 'highlights';
  private highlights: Map<string, HighlightInfo[]> = new Map(); // key: textHash, value: highlights

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
      await this.loadHighlights();
      hilog.info(0x0000, TAG, 'HighlightManager initialized');
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to init preferences: ${(err as BusinessError).message}`);
    }
  }

  /**
   * 生成文本哈希值
   */
  private generateTextHash(text: string): string {
    let hash = 0;
    for (let i = 0; i < Math.min(text.length, 100); i++) {
      const char = text.charCodeAt(i);
      hash = ((hash << 5) - hash) + char;
      hash = hash & hash;
    }
    return hash.toString();
  }

  /**
   * 加载高亮数据
   */
  private async loadHighlights() {
    if (!this.preferencesStore) {
      return;
    }

    try {
      const keys = await this.preferencesStore.getAll();
      for (const key of Object.keys(keys)) {
        if (key.startsWith('highlight_')) {
          const textHash = key.substring(10);
          const highlightsJson = await this.preferencesStore.get(key, '[]');
          try {
            const highlights = JSON.parse(highlightsJson as string) as HighlightInfo[];
            this.highlights.set(textHash, highlights);
          } catch (e) {
            hilog.warn(0x0000, TAG, `Failed to parse highlights for ${textHash}`);
          }
        }
      }
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to load highlights: ${(err as BusinessError).message}`);
    }
  }

  /**
   * 添加高亮
   * @param text 文本内容
   * @param startIndex 开始索引
   * @param endIndex 结束索引
   * @param color 高亮颜色
   * @param note 备注
   */
  async addHighlight(text: string, startIndex: number, endIndex: number, color: string, note?: string): Promise<void> {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      return;
    }

    const textHash = this.generateTextHash(text);
    const highlightText = text.substring(startIndex, endIndex);
    
    const highlight: HighlightInfo = {
      startIndex,
      endIndex,
      text: highlightText,
      color,
      note
    };

    if (!this.highlights.has(textHash)) {
      this.highlights.set(textHash, []);
    }

    const highlights = this.highlights.get(textHash);
    if (highlights) {
      highlights.push(highlight);
      await this.saveHighlights(textHash, highlights);
      hilog.info(0x0000, TAG, `Highlight added: ${startIndex}-${endIndex}`);
    }
  }

  /**
   * 获取文本的所有高亮
   * @param text 文本内容
   * @returns 高亮数组
   */
  getHighlights(text: string): HighlightInfo[] {
    const textHash = this.generateTextHash(text);
    return this.highlights.get(textHash) || [];
  }

  /**
   * 删除高亮
   * @param text 文本内容
   * @param startIndex 开始索引
   * @param endIndex 结束索引
   */
  async removeHighlight(text: string, startIndex: number, endIndex: number): Promise<void> {
    if (!this.preferencesStore) {
      return;
    }

    const textHash = this.generateTextHash(text);
    const highlights = this.highlights.get(textHash);
    if (!highlights) {
      return;
    }

    const filtered = highlights.filter(h => 
      !(h.startIndex === startIndex && h.endIndex === endIndex)
    );

    this.highlights.set(textHash, filtered);
    await this.saveHighlights(textHash, filtered);
    hilog.info(0x0000, TAG, `Highlight removed: ${startIndex}-${endIndex}`);
  }

  /**
   * 保存高亮数据
   */
  private async saveHighlights(textHash: string, highlights: HighlightInfo[]) {
    if (!this.preferencesStore) {
      return;
    }

    try {
      const key = `highlight_${textHash}`;
      const json = JSON.stringify(highlights);
      await this.preferencesStore.put(key, json);
      await this.preferencesStore.flush();
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to save highlights: ${(err as BusinessError).message}`);
    }
  }
}

