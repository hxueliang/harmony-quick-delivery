import { Request } from '@hxl/basic/Index'
import { DeliverParams } from '../models'

export const deliver = (params: DeliverParams) => {
  return Request.post<null>('/tasks/deliver', params)
}