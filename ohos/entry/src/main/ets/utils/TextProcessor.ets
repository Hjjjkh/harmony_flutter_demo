import hilog from '@ohos.hilog';

const TAG = 'TextProcessor';

/**
 * 文本处理工具类
 * 负责文本分段、分词等功能
 */
export class TextProcessor {
  /**
   * 按标点符号分段文本
   * @param text 原始文本
   * @returns 分段后的文本数组
   */
  static segmentByPunctuation(text: string): string[] {
    if (!text || text.trim().length === 0) {
      return [];
    }

    const normalized = text.replace(/\r\n/g, '\n');
    const punctuationRegex = /([。！？!?；;…]+|\n+)/g;
    const segments: string[] = [];
    let lastIndex = 0;
    let match: RegExpExecArray | null;

    while ((match = punctuationRegex.exec(normalized)) !== null) {
      const endIndex = match.index + match[0].length;
      const rawSegment = normalized.substring(lastIndex, endIndex).trim();
      if (rawSegment.length > 0) {
        segments.push(this.normalizeQuotes(rawSegment));
      }
      lastIndex = endIndex;
    }

    if (lastIndex < normalized.length) {
      const tail = normalized.substring(lastIndex).trim();
      if (tail.length > 0) {
        segments.push(this.normalizeQuotes(tail));
      }
    }

    const merged = this.combineShortSegments(segments, 12);
    hilog.info(0x0000, TAG, `Segmented text into ${merged.length} smart segments`);
    return merged;
  }

  /**
   * 按词分割文本（简单实现，支持中英文）
   * @param text 原始文本
   * @returns 分词后的数组
   */
  static segmentByWords(text: string): string[] {
    if (!text || text.trim().length === 0) {
      return [];
    }

    const tokens = text.match(/([A-Za-z]+(?:'[A-Za-z]+)?|\d+(?:\.\d+)?|[\u4E00-\u9FFF]|[，。,、“”"'‘’\(\)（）\[\]{}<>—\-…]|[^\s])/g);
    if (!tokens) {
      return [text.trim()];
    }

    const cleaned: string[] = [];
    let buffer = '';
    tokens.forEach(token => {
      if (/^[A-Za-z0-9]+$/.test(token)) {
        buffer += token;
      } else {
        if (buffer.length > 0) {
          cleaned.push(buffer);
          buffer = '';
        }
        cleaned.push(token);
      }
    });

    if (buffer.length > 0) {
      cleaned.push(buffer);
    }

    const result = cleaned.filter(item => item.trim().length > 0);
    hilog.info(0x0000, TAG, `Segmented text into ${result.length} tokens`);
    return result;
  }

  /**
   * 清理文本（移除多余空格、换行等）
   * @param text 原始文本
   * @returns 清理后的文本
   */
  static cleanText(text: string): string {
    return text
      .replace(/\s+/g, ' ') // 多个空格替换为单个空格
      .replace(/\n\s*\n/g, '\n') // 多个换行替换为单个换行
      .trim();
  }

  /**
   * 检测文本编码（简单实现）
   * @param text 文本内容
   * @returns 编码类型
   */
  static detectEncoding(text: string): string {
    // 简单检测：如果包含中文字符，可能是UTF-8
    for (let i = 0; i < Math.min(text.length, 100); i++) {
      const charCode = text.charCodeAt(i);
      if (charCode >= 0x4E00 && charCode <= 0x9FFF) {
        return 'UTF-8';
      }
    }
    return 'UTF-8'; // 默认UTF-8
  }

  private static normalizeQuotes(text: string): string {
    return text
      .replace(/[“”]/g, '"')
      .replace(/[‘’]/g, "'")
      .replace(/\s+/g, ' ')
      .trim();
  }

  private static combineShortSegments(segments: string[], minLength: number): string[] {
    if (segments.length <= 1) {
      return segments;
    }

    const result: string[] = [];
    let buffer = '';

    segments.forEach((segment, index) => {
      if ((buffer + segment).length < minLength && index !== segments.length - 1) {
        buffer += (buffer.length > 0 ? ' ' : '') + segment;
      } else {
        if (buffer.length > 0) {
          result.push(`${buffer} ${segment}`.trim());
          buffer = '';
        } else {
          result.push(segment);
        }
      }
    });

    if (buffer.length > 0) {
      result.push(buffer.trim());
    }

    return result;
  }
}


