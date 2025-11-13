import hilog from '@ohos.hilog';
import preferences from '@ohos.data.preferences';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';

const TAG = 'ReadingProgress';

/**
 * 阅读进度管理类
 * 负责保存和恢复阅读进度
 */
export class ReadingProgress {
  private context: common.Context;
  private preferencesStore: preferences.Preferences | null = null;
  private readonly PREF_NAME = 'reading_progress';
  private readonly KEY_TEXT_HASH = 'text_hash';
  private readonly KEY_CURRENT_INDEX = 'current_index';
  private readonly KEY_SPEED = 'speed';
  private readonly KEY_MODE = 'mode';

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
      hilog.info(0x0000, TAG, 'Preferences initialized');
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to init preferences: ${(err as BusinessError).message}`);
    }
  }

  /**
   * 生成文本哈希值（简单实现）
   * @param text 文本内容
   * @returns 哈希值
   */
  private generateTextHash(text: string): string {
    let hash = 0;
    for (let i = 0; i < Math.min(text.length, 100); i++) {
      const char = text.charCodeAt(i);
      hash = ((hash << 5) - hash) + char;
      hash = hash & hash; // Convert to 32bit integer
    }
    return hash.toString();
  }

  /**
   * 保存阅读进度
   * @param text 文本内容
   * @param currentIndex 当前索引
   * @param speed 阅读速度
   * @param mode 阅读模式
   */
  async saveProgress(text: string, currentIndex: number, speed: number, mode: string): Promise<void> {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      hilog.error(0x0000, TAG, 'Preferences store not available');
      return;
    }

    try {
      const textHash = this.generateTextHash(text);
      await this.preferencesStore.put(this.KEY_TEXT_HASH, textHash);
      await this.preferencesStore.put(this.KEY_CURRENT_INDEX, currentIndex);
      await this.preferencesStore.put(this.KEY_SPEED, speed);
      await this.preferencesStore.put(this.KEY_MODE, mode);
      await this.preferencesStore.flush();

      hilog.info(0x0000, TAG, `Progress saved: index=${currentIndex}, speed=${speed}, mode=${mode}`);
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to save progress: ${(err as BusinessError).message}`);
    }
  }

  /**
   * 恢复阅读进度
   * @param text 文本内容
   * @returns 进度信息，如果不存在则返回null
   */
  async restoreProgress(text: string): Promise<{ currentIndex: number; speed: number; mode: string } | null> {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      return null;
    }

    try {
      const textHash = this.generateTextHash(text);
      const savedHash = await this.preferencesStore.get(this.KEY_TEXT_HASH, '');
      
      // 检查文本是否匹配
      if (savedHash !== textHash) {
        hilog.info(0x0000, TAG, 'Text hash mismatch, progress not restored');
        return null;
      }

      const currentIndex = await this.preferencesStore.get(this.KEY_CURRENT_INDEX, 0);
      const speed = await this.preferencesStore.get(this.KEY_SPEED, 1.0);
      const mode = await this.preferencesStore.get(this.KEY_MODE, 'word');

      hilog.info(0x0000, TAG, `Progress restored: index=${currentIndex}, speed=${speed}, mode=${mode}`);
      return { currentIndex, speed, mode };
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to restore progress: ${(err as BusinessError).message}`);
      return null;
    }
  }

  /**
   * 清除阅读进度
   */
  async clearProgress(): Promise<void> {
    if (!this.preferencesStore) {
      await this.initPreferences();
    }

    if (!this.preferencesStore) {
      return;
    }

    try {
      await this.preferencesStore.delete(this.KEY_TEXT_HASH);
      await this.preferencesStore.delete(this.KEY_CURRENT_INDEX);
      await this.preferencesStore.delete(this.KEY_SPEED);
      await this.preferencesStore.delete(this.KEY_MODE);
      await this.preferencesStore.flush();

      hilog.info(0x0000, TAG, 'Progress cleared');
    } catch (err) {
      hilog.error(0x0000, TAG, `Failed to clear progress: ${(err as BusinessError).message}`);
    }
  }
}

