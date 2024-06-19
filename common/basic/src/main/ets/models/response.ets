/** 响应的数据类型 */
export class ResponseData<T> {
  code: number = 0
  msg: string = ''
  data: T | null = null
}