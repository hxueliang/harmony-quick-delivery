import { preferences } from '@kit.ArkData'

import { TOKEN_STORE_KEY, TOKEN_KEY } from '../constants'


/** token仓库 */
export class TokenStore {
  context: Context

  constructor(ctx: Context) {
    this.context = ctx
  }

  /**
   * 获取token仓库
   * @returns
   */
  getStore() {
    return preferences.getPreferencesSync(this.context, { name: TOKEN_STORE_KEY })
  }

  /**
   * 设置token
   * @param ad
   */
  async setToken(token: string) {
    const store = this.getStore()
    store.putSync(TOKEN_KEY, token)
    await store.flush()
  }

  /**
   * 获取token
   * @returns
   */
  getToken() {
    const store = this.getStore()
    return store.getSync(TOKEN_KEY, '') as string
  }
}