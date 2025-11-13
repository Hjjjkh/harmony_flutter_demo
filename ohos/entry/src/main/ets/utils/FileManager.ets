import hilog from '@ohos.hilog';
import fs from '@ohos.file.fs';
import picker from '@ohos.file.picker';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';

const TAG = 'FileManager';

/**
 * 文件管理工具类
 * 负责文件读取、导入等功能
 */
export class FileManager {
  private context: common.Context;

  constructor(context: common.Context) {
    this.context = context;
  }

  /**
   * 打开文件选择器（TXT文件）
   * @returns Promise<string> 文件内容
   */
  async pickTextFile(): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      const documentViewPicker = new picker.DocumentViewPicker();
      const documentSelectOptions = new picker.DocumentSelectOptions();
      documentSelectOptions.maxSelectNumber = 1;
      documentSelectOptions.fileSuffixFilters = ['.txt', '.md'];

      documentViewPicker.select(documentSelectOptions)
        .then((documentSelectResult: picker.DocumentSelectResult) => {
          if (documentSelectResult && documentSelectResult.length > 0) {
            const uri = documentSelectResult[0];
            this.readTextFile(uri).then((content: string) => {
              resolve(content);
            }).catch((err: BusinessError) => {
              hilog.error(0x0000, TAG, `Failed to read file: ${err.message}`);
              reject(err);
            });
          } else {
            reject(new Error('No file selected'));
          }
        })
        .catch((err: BusinessError) => {
          hilog.error(0x0000, TAG, `File picker error: ${err.message}`);
          reject(err);
        });
    });
  }

  /**
   * 读取文本文件内容
   * @param uri 文件URI
   * @returns Promise<string> 文件内容
   */
  async readTextFile(uri: string): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      try {
        const file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
        const stat = fs.statSync(file.fd);
        const buffer = new ArrayBuffer(stat.size);
        fs.readSync(file.fd, buffer);
        fs.closeSync(file);

        // 将ArrayBuffer转换为字符串（UTF-8编码）
        const uint8Array = new Uint8Array(buffer);
        let text = '';
        for (let i = 0; i < uint8Array.length; i++) {
          text += String.fromCharCode(uint8Array[i]);
        }

        // 尝试使用TextDecoder解码（如果支持）
        try {
          const decoder = new TextDecoder('utf-8');
          text = decoder.decode(uint8Array);
        } catch (e) {
          hilog.warn(0x0000, TAG, 'TextDecoder not available, using fallback');
        }

        hilog.info(0x0000, TAG, `Read file successfully, size: ${stat.size} bytes`);
        resolve(text);
      } catch (err) {
        hilog.error(0x0000, TAG, `Failed to read file: ${(err as BusinessError).message}`);
        reject(err);
      }
    });
  }

  /**
   * 保存文本到文件
   * @param content 文本内容
   * @param fileName 文件名
   * @returns Promise<string> 保存的文件路径
   */
  async saveTextFile(content: string, fileName: string): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      try {
        const filesDir = this.context.filesDir;
        const filePath = `${filesDir}/${fileName}`;
        const file = fs.openSync(filePath, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY | fs.OpenMode.TRUNC);
        
        // 将字符串转换为Uint8Array
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
}

