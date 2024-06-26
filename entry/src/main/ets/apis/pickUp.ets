import { Request } from '@hxl/basic/Index'
import { PickUpParams } from '../models/pickUp'

export const pickUp = (params: PickUpParams) => {
  return Request.post<null>('/tasks/takeDelivery', params)
}