import { preferences } from '@kit.ArkData'

import { USER_INFO_STORE_KEY, USER_TOKEN_KEY } from '../constants'


/** token仓库 */
export class UserInfoStore {
  context: Context

  constructor(ctx: Context) {
    this.context = ctx
  }

  /**
   * 获取token仓库
   * @returns
   */
  getStore() {
    return preferences.getPreferencesSync(this.context, { name: USER_INFO_STORE_KEY })
  }

  /**
   * 设置token
   * @param ad
   */
  async setToken(token:string) {
    const store = this.getStore()
    store.putSync(USER_TOKEN_KEY, token)
    await store.flush()
  }

  /**
   * 获取token
   * @returns
   */
  getToken() {
    const store = this.getStore()
    return store.getSync(USER_TOKEN_KEY, '') as string
  }
}