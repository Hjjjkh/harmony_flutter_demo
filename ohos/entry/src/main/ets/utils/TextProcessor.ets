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
    // 中文和英文标点符号
    const punctuationRegex = /[。！？；\n\r\t\.!?;]/g;
    const segments: string[] = [];
    let lastIndex = 0;
    let match: RegExpExecArray | null;

    while ((match = punctuationRegex.exec(text)) !== null) {
      const segment = text.substring(lastIndex, match.index + 1).trim();
      if (segment.length > 0) {
        segments.push(segment);
      }
      lastIndex = match.index + 1;
    }

    // 添加最后一段
    if (lastIndex < text.length) {
      const lastSegment = text.substring(lastIndex).trim();
      if (lastSegment.length > 0) {
        segments.push(lastSegment);
      }
    }

    // 如果没有找到标点符号，返回整个文本
    if (segments.length === 0) {
      segments.push(text);
    }

    hilog.info(0x0000, TAG, `Segmented text into ${segments.length} segments`);
    return segments;
  }

  /**
   * 按词分割文本（简单实现，支持中英文）
   * @param text 原始文本
   * @returns 分词后的数组
   */
  static segmentByWords(text: string): string[] {
    const words: string[] = [];
    let currentWord = '';

    for (let i = 0; i < text.length; i++) {
      const char = text.charAt(i);
      const charCode = char.charCodeAt(0);

      // 判断是否为中文字符（Unicode范围：0x4E00-0x9FFF）
      const isChinese = charCode >= 0x4E00 && charCode <= 0x9FFF;
      // 判断是否为英文字母或数字
      const isAlphanumeric = (charCode >= 0x0041 && charCode <= 0x005A) ||
        (charCode >= 0x0061 && charCode <= 0x007A) ||
        (charCode >= 0x0030 && charCode <= 0x0039);

      if (isChinese) {
        // 中文字符，每个字作为一个词
        if (currentWord.length > 0) {
          words.push(currentWord);
          currentWord = '';
        }
        words.push(char);
      } else if (isAlphanumeric) {
        // 英文字母或数字，累积成词
        currentWord += char;
      } else {
        // 标点符号或其他字符
        if (currentWord.length > 0) {
          words.push(currentWord);
          currentWord = '';
        }
        // 标点符号也作为一个词（可选）
        if (char.trim().length > 0) {
          words.push(char);
        }
      }
    }

    // 添加最后一个词
    if (currentWord.length > 0) {
      words.push(currentWord);
    }

    hilog.info(0x0000, TAG, `Segmented text into ${words.length} words`);
    return words;
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
}

