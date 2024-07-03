/** key-value的结构 */
export interface KeyValue<T> {
  key?: string | number
  value?: T
  label?: string
  icon?: ResourceStr
}

export interface RouterParams {
  id?: string | number
  oldTime?: string
}

export interface ImageList {
  /** 图片url */
  url: string
}

export class ImageListModel implements ImageList {
  url: string = ''

  constructor(model: ImageList) {
    this.url = model.url
  }
}

/** 压缩文件参数 */
export interface CompressParams {
  /** 文件列表 */
  files: ImageList[]
  /** 沙箱路径 */
  path?: string
  /** 目标图像的质量，取值范围是0 ~ 100。值越大越好。 */
  quality?: number
}