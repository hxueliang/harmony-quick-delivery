import { Context } from '@kit.AbilityKit'
import { request } from '@kit.BasicServicesKit'

import { BASE_URL, TOKEN_KEY } from '../constants'
import { ImageList, ResponseData } from '../models'

export const uploadImage = (context: Context, files: request.File[]) => {
  return new Promise<ImageList[]>(async (resolve, reject) => {
    try {
      // 组件请求参数
      const config: request.UploadConfig = {
        url: BASE_URL + '/files/imageUpload',
        header: {
          Authorization: AppStorage.get(TOKEN_KEY) || '',
          'Content-type': 'multipart/form-data',
        },
        method: 'POST',
        files,
        data: [],
      }

      // 调上传接口，得到上传任务
      const task = await request.uploadFile(context, config)

      // 监听失败
      task.on('fail', () => {
        AlertDialog.show({ message: '上传失败' })
        reject(new Error('上传失败'))
      })

      // 监听图片上传完成，上传成功多少张图片，触发多少次该回调，并将结果存入arr中
      const arr: ImageList[] = []
      task.on('headerReceive', (header: object) => {
        const result = JSON.parse(header['body']) as ResponseData<string>
        if (result.code === 200) {
          arr.push({ url: result.data?.toString() || '' })
        }
      })

      // 所有图片上传完成，触发一次该回调，并将resolve(arr)
      task.on('complete', () => {
        resolve(arr)
      })
    } catch (err) {
      AlertDialog.show({ message: err.message })
      reject(err)
    }
  })
}