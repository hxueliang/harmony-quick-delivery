import { ImageList } from '@hxl/basic/Index';

export interface DeliverParams {
  /** 交付凭证列表 */
  certificatePictureList: ImageList[]
  /** 交付图片列表 */
  deliverPictureList: ImageList[]
  /** 司机作业id */
  id: string
}

export class DeliverParamsModel implements DeliverParams {
  certificatePictureList: ImageList[] = []
  deliverPictureList: ImageList[] = []
  id: string = ''

  constructor(model: DeliverParams) {
    this.certificatePictureList = model.certificatePictureList
    this.deliverPictureList = model.deliverPictureList
    this.id = model.id
  }
}
