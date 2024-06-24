/** key-value的结构 */
export interface KeyValue<T> {
  key?: string | number
  value?: T
  label?: string
}

export interface RouterParams {
  id?: string | number
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