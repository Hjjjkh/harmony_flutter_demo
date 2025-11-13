import hilog from '@ohos.hilog';
import fs from '@ohos.file.fs';
import picker from '@ohos.file.picker';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';

const TAG = 'FileManager';

export interface FileImportResult {
  content: string;
  fileName: string;
  extension: string;
}

/**
 * 文件管理工具类
 * 负责文件读取、导入等功能
 */
export class FileManager {
  private readonly SUPPORTED_SUFFIXES: string[] = ['.txt', '.md', '.rtf', '.html', '.htm', '.json', '.csv', '.docx', '.pdf'];
  private context: common.Context;

  constructor(context: common.Context) {
    this.context = context;
  }

  /**
   * 打开文件选择器，选择并读取文本类文件
   */
  async pickTextFile(): Promise<FileImportResult> {
    return new Promise<FileImportResult>((resolve, reject) => {
      const documentViewPicker = new picker.DocumentViewPicker();
      const documentSelectOptions = new picker.DocumentSelectOptions();
      documentSelectOptions.maxSelectNumber = 1;
      documentSelectOptions.fileSuffixFilters = this.SUPPORTED_SUFFIXES;

      documentViewPicker.select(documentSelectOptions)
        .then(async (documentSelectResult: picker.DocumentSelectResult) => {
          if (!documentSelectResult || documentSelectResult.length === 0) {
            reject(new Error('未选择文件'));
            return;
          }

          const uri = documentSelectResult[0];
          try {
            const buffer = await this.readFileBuffer(uri);
            const extension = this.getExtensionFromUri(uri);
            const content = this.convertBufferToText(buffer, extension);
            const fileName = this.getFileNameFromUri(uri) ?? `导入文件${extension}`;
            hilog.info(0x0000, TAG, `File imported: ${fileName}`);
            resolve({ content, extension, fileName });
          } catch (err) {
            hilog.error(0x0000, TAG, `Failed to read file: ${(err as BusinessError).message}`);
            promptAction.showToast({ message: '文件读取失败，请稍后重试', duration: 2000 });
            reject(err);
          }
        })
        .catch((err: BusinessError) => {
          if (err.code !== -1) { // -1 表示用户取消
            hilog.error(0x0000, TAG, `File picker error: ${err.message}`);
            promptAction.showToast({ message: '文件选择失败', duration: 2000 });
          }
          reject(err);
        });
    });
  }

  /**
   * 将内容保存到应用私有目录
   */
  async saveTextFile(content: string, fileName: string): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      try {
        const filesDir = this.context.filesDir;
        const filePath = `${filesDir}/${fileName}`;
        const file = fs.openSync(filePath, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY | fs.OpenMode.TRUNC);
        const encoder = new TextEncoder();
        const uint8Array = encoder.encode(content);
        fs.writeSync(file.fd, uint8Array.buffer);
        fs.closeSync(file);

        hilog.info(0x0000, TAG, `File saved: ${filePath}`);
        resolve(filePath);
      } catch (err) {
        hilog.error(0x0000, TAG, `Failed to save file: ${(err as BusinessError).message}`);
        reject(err);
      }
    });
  }

  /**
   * 读取文件为 ArrayBuffer
   */
  private readFileBuffer(uri: string): Promise<ArrayBuffer> {
    return new Promise<ArrayBuffer>((resolve, reject) => {
      try {
        // ArkTS 支持直接使用 URI 读取文件
        const file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
        const stat = fs.statSync(file.fd);
        const buffer = new ArrayBuffer(stat.size);
        fs.readSync(file.fd, buffer);
        fs.closeSync(file);
        resolve(buffer);
      } catch (err) {
        reject(err);
      }
    });
  }

  /**
   * 根据文件扩展名转换内容为纯文本
   */
  private convertBufferToText(buffer: ArrayBuffer, extension: string): string {
    const normalizedExt = extension.toLowerCase();
    switch (normalizedExt) {
      case '.txt':
      case '.md':
      case '.json':
      case '.csv':
        return this.decodeBuffer(buffer);
      case '.rtf':
        return this.convertRtfToText(this.decodeBuffer(buffer));
      case '.html':
      case '.htm':
        return this.convertHtmlToText(this.decodeBuffer(buffer));
      case '.docx':
        return this.extractDocxText(buffer);
      case '.pdf':
        return this.extractPdfText(buffer);
      default:
        hilog.warn(0x0000, TAG, `Unsupported extension ${extension}, fallback to plain text`);
        return this.decodeBuffer(buffer);
    }
  }

  private decodeBuffer(buffer: ArrayBuffer): string {
    try {
      const decoder = new TextDecoder('utf-8', { fatal: false });
      return decoder.decode(new Uint8Array(buffer));
    } catch (err) {
      hilog.warn(0x0000, TAG, 'TextDecoder failed, fallback to manual decoding');
      const uint8Array = new Uint8Array(buffer);
      let text = '';
      for (let i = 0; i < uint8Array.length; i++) {
        text += String.fromCharCode(uint8Array[i]);
      }
      return text;
    }
  }

  private convertHtmlToText(html: string): string {
    return html
      .replace(/<style[\s\S]*?<\/style>/gi, '')
      .replace(/<script[\s\S]*?<\/script>/gi, '')
      .replace(/<[^>]+>/g, ' ')
      .replace(/&nbsp;/g, ' ')
      .replace(/&lt;/g, '<')
      .replace(/&gt;/g, '>')
      .replace(/&amp;/g, '&')
      .replace(/\s+/g, ' ')
      .trim();
  }

  private convertRtfToText(rtf: string): string {
    return rtf
      .replace(/\\par[d]?/g, '\n')
      .replace(/\\'[0-9a-fA-F]{2}/g, (match: string) => {
        const hex = match.replace('\\''', '');
        return String.fromCharCode(parseInt(hex, 16));
      })
      .replace(/\\[^\\\s]+/g, '')
      .replace(/[{}]/g, '')
      .replace(/\s+/g, ' ')
      .trim();
  }

  /**
   * DOCX 文本提取（基础实现）
   * 说明：DOCX 为压缩包格式，这里只做基础文本识别
   */
  private extractDocxText(buffer: ArrayBuffer): string {
    const text = this.decodeBuffer(buffer);
    if (text.includes('<w:t')) {
      const matches = text.match(/<w:t[^>]*>(.*?)<\/w:t>/g);
      if (matches) {
        return matches
          .map(item => item.replace(/<w:t[^>]*>/, '').replace(/<\/w:t>/, ''))
          .join(' ');
      }
    }
    hilog.warn(0x0000, TAG, 'DOCX parsing fallback, consider integrating dedicated parser');
    return text.replace(/[^\x20-\x7E\u4E00-\u9FA5]+/g, ' ').trim();
  }

  /**
   * PDF 文本提取（基础实现）
   * 说明：PDF 结构复杂，此处尝试提取可打印字符
   */
  private extractPdfText(buffer: ArrayBuffer): string {
    const raw = this.decodeBuffer(buffer);
    const text = raw
      .replace(/\(([^\)]*)\)/g, (_match: string, group: string) => `${group} `)
      .replace(/BT[\s\S]*?ET/g, (block: string) => block.replace(/T[fjTJ]\s/g, ' '))
      .replace(/[^\x20-\x7E\u4E00-\u9FA5]+/g, ' ')
      .replace(/\s+/g, ' ')
      .trim();
    if (text.length === 0) {
      hilog.warn(0x0000, TAG, 'PDF parsing produced empty text');
    }
    return text;
  }

  private getExtensionFromUri(uri: string): string {
    const fileName = this.getFileNameFromUri(uri);
    if (!fileName) {
      return '.txt';
    }
    const dotIndex = fileName.lastIndexOf('.');
    if (dotIndex === -1) {
      return '.txt';
    }
    return fileName.substring(dotIndex).toLowerCase();
  }

  private getFileNameFromUri(uri: string): string | null {
    if (!uri) {
      return null;
    }
    const segments = uri.split('/');
    if (segments.length === 0) {
      return null;
    }
    const lastSegment = segments[segments.length - 1];
    const nameDecoded = decodeURIComponent(lastSegment);
    if (nameDecoded.includes('.')) {
      return nameDecoded;
    }
    return null;
  }
}

