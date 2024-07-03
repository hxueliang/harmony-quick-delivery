import { ErrorEvent, MessageEvents, ThreadWorkerGlobalScope, util, worker } from '@kit.ArkTS';
import { image } from '@kit.ImageKit';
import { fileIo } from '@kit.CoreFileKit';

import { ImageList, CompressParams } from '../models';


const workerPort: ThreadWorkerGlobalScope = worker.workerPort;

/**
 * Defines the event handler to be called when the worker thread receives a message sent by the host thread.
 * The event handler is executed in the worker thread.
 *
 * @param e message data
 */
workerPort.onmessage = async (e: MessageEvents) => {
  try {
    const params = e.data as CompressParams
    if (!params?.files) {
      return
    }
    const imagePackerAPI = image.createImagePacker() // 创建图片压缩API
    let packOpts: image.PackingOption = { format: 'image/jpeg', quality: params.quality || 20 }
    const files: ImageList[] = params?.files || [] // 源文件地址
    const targetFiles: ImageList[] = [] // 目标文件地址
    while (files.length) {
      const file = files.pop()
      const sourceFile = fileIo.openSync(file?.url || '', fileIo.OpenMode.READ_ONLY) // 打开源文件
      const extendName = file?.url.split('.')[1] || 'jpg'
      const targetName = util.generateRandomUUID() + '.' + extendName
      const targetPath = params.path + '/' + targetName
      const targetFile = fileIo.openSync(targetPath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE) // 打开源文件
      // Todo: 多次执行这句代码程序是死掉，原因未知
      await imagePackerAPI.packToFile(image.createImageSource(sourceFile.fd), targetFile.fd, packOpts) // 对源文件压缩
      targetFiles.push({ url: targetPath })
      fileIo.closeSync(sourceFile.fd) // 关闭来源文件
      fileIo.closeSync(targetFile.fd) // 关闭目标文件
    }
    workerPort.postMessage({ files: targetFiles })
    workerPort.close()
  }
  catch (err) {
    console.log('x_log', JSON.stringify(e) + ' a')
  }
}

/**
 * Defines the event handler to be called when the worker receives a message that cannot be deserialized.
 * The event handler is executed in the worker thread.
 *
 * @param e message data
 */
workerPort.onmessageerror = (e: MessageEvents) => {
  console.log('x_log', JSON.stringify(e) + ' b')
}

/**
 * Defines the event handler to be called when an exception occurs during worker execution.
 * The event handler is executed in the worker thread.
 *
 * @param e error message
 */
workerPort.onerror = (e: ErrorEvent) => {
  console.log('x_log', JSON.stringify(e) + ' c')
}