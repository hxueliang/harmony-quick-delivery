import { http } from '@kit.NetworkKit'
import { promptAction, router } from '@kit.ArkUI'

import { BASE_URL, TOKEN_KEY } from '../constants'
import { TokenStore } from '../store'
import { ResponseData } from '../models'

async function requestHttp<T>(
  url: string = "",
  method: http.RequestMethod = http.RequestMethod.GET,
  data?: object
): Promise<T> {
  const httpRequest = http.createHttp()
  url = BASE_URL + url
  // Todo: 目录版本，git请求需要手动拼接参数，应该是官方的bug，后续版本调整后，要删除此代码
  if (method === http.RequestMethod.GET && data && Object.keys(data).length) {
    url += "?" + Object.keys(data).filter(key => data[key] !== void (0)).map(key => `${key}=${data[key]}`).join("&")
  }
  // 组装参数
  const config: http.HttpRequestOptions = {
    extraData: method === http.RequestMethod.GET ? '' : data,
    header: {
      'Content-Type': 'application/json',
      Authorization: AppStorage.get(TOKEN_KEY) || '',
    },
    method,
    readTimeout: 10 * 1000,
  }
  try {
    const result = await httpRequest.request(url, config)
    if (result.responseCode === 401) {
      // 移动端产品应该去做无感刷新
      new TokenStore(getContext()).setToken('')
      AppStorage.set(TOKEN_KEY, '')
      router.replaceUrl({ url: 'pages/Login/Login' })
      promptAction.showToast({ message: '登录失效' })
      return Promise.reject(new Error("登录失效"))
    }
    if (result.responseCode === 404) {
      promptAction.showToast({ message: '请求地址错误' })
      return Promise.reject(new Error("请求地址错误"))
    }
    const res = JSON.parse(result.result as string) as ResponseData<T>
    if (res.code === 200) {
      return res.data as T
    }
    promptAction.showToast({ message: "服务器异常" })
    return Promise.reject(new Error(res.msg))

  } catch (error) {
    promptAction.showToast({ message: error.message })
    return Promise.reject(error)
  }
}

export class Request {
  static get<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.GET, data)
  }

  static post<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.POST, data)
  }

  static delete<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.DELETE, data)
  }

  static put<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.PUT, data)
  }
}
