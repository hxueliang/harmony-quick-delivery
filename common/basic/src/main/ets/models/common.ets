/** key-value的结构 */
export interface KeyValue<T> {
  key?: string | number
  value?: T
  label?: string
}

export interface RouterParams {
  id?: string | number
}
