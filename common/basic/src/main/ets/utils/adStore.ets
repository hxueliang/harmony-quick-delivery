import { preferences } from '@kit.ArkData'

import { AD_STORE_KEY, START_AD_KEY } from '../constants'
import { AdvertModel } from '../models'

const DEFAULT_AD: AdvertModel = {
  showAd: false,
  adTime: 5,
  adImg: $r("app.media.start"),
}

/** 广告仓库 */
export class AdStore {
  context: Context

  constructor(ctx: Context) {
    this.context = ctx
  }

  /**
   * 获取AD仓库
   * @returns
   */
  getStore() {
    return preferences.getPreferencesSync(this.context, { name: AD_STORE_KEY })
  }

  /**
   * 设置启动广告
   * @param ad
   */
  async setStartAd(ad: AdvertModel) {
    const store = this.getStore()
    store.putSync(START_AD_KEY, JSON.stringify(ad))
    await store.flush()
  }

  /**
   * 获取启动广告
   * @returns
   */
  getStartAd() {
    const store = this.getStore()
    return JSON.parse(store.getSync(START_AD_KEY, JSON.stringify(DEFAULT_AD)) as string) as AdvertModel
  }
}