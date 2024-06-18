/**
 * 广告接口
 */
export class AdvertModel {
  /** 显示广告 */
  showAd: boolean = false
  /** 广告时长 */
  adTime: number = 5
  /** 广告链接 */
  adUrl?: string
  /** 广告图片 */
  adImg?: ResourceStr
}