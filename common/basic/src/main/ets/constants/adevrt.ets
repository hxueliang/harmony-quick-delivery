import { AdvertModel } from '../models'

/** 广告仓库key */
export const AD_STORE_KEY = 'ad_store_key'

/** 启动广告key */
export const START_AD_KEY = 'start_ad_key'

/** 默认广告 */
export const DEFAULT_AD: AdvertModel = {
  showAd: false,
  adTime: 5,
  adImg: $r("app.media.start"),
}