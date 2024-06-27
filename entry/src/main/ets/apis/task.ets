import { Request } from '@hxl/basic/Index'

import {
  DeliverParams,
  PickUpParams,
  TaskDetailInfoModel,
  TaskListDataItem,
  TaskListDataItemModel,
  TaskListDataModel,
  TaskListParams
} from '../models'

export async function getTaskList(params: TaskListParams) {
  return Request.get<TaskListDataModel>('/tasks/list', params)

  // 模似数据
  // const res = await Request.get<TaskListDataModel>('/tasks/list', params)
  // console.log('x_log', JSON.stringify(res))
  const item = new TaskListDataItemModel({
    "id": "4061815043250542307",
    "startAgencyId": 1024984540818568481,
    "startAddress": "辽宁抚顺顺城鸭绿江北街58-8号",
    "endAgencyId": 1024993422324415489,
    "endAddress": "湖北武汉武昌友谊大道194号附近",
    "status": '1',
    "driverId": "4061815043225773184",
    "transportTaskId": "4061815043250358556",
    "startHandover": 'null',
    "finishHandover": 'null',
    "planDepartureTime": "2024-06-18 20:00:00",
    "actualDepartureTime": 'null',
    "planArrivalTime": "2024-06-19 06:00:00",
    "actualArrivalTime": 'null',
    "created": "2024-06-18 15:04:32",
    "enablePickUp": false
  })
  const item2: TaskListDataItem = JSON.parse(JSON.stringify(item))
  item2.id = '123'
  const item3: TaskListDataItem = JSON.parse(JSON.stringify(item2))
  item3.id = '124'
  item.enablePickUp = true
  const arr = [item, item2, item3]
  const obj: TaskListDataModel = new TaskListDataModel({
    "counts": 30,
    "pageSize": 5,
    "pages": 6,
    "page": 1,
    "items": arr
  })
  return await obj
}

export async function getTaskDetail(id: string) {
  return Request.get<TaskDetailInfoModel>(`/tasks/details/${id}`)

  // 模似数据
  // const res = await Request.get<TaskDetailInfoModel>(`/tasks/details/${id}`)
  // console.log('x_log', JSON.stringify(res))
  const obj = new TaskDetailInfoModel({
    "id": "4061815043250542307",
    "startAgencyId": "1024984540818568481",
    "startProvince": "辽宁",
    "startCity": "抚顺",
    "startAddress": "辽宁抚顺顺城鸭绿江北街58-8号",
    "endAgencyId": "1024993422324415489",
    "endProvince": "湖北",
    "endAddress": "湖北武汉武昌友谊大道194号附近",
    "endCity": "武汉",
    "status": 1,
    "driverId": "4061815043225773184",
    "transportTaskId": "4061815043250358556",
    "startHandoverName": "奶油张张包",
    "startHandoverPhone": "13112324543",
    "finishHandoverName": "曹永军",
    "finishHandoverPhone": "15084738473",
    "planDepartureTime": "2024-06-18 20:00:00",
    "actualDepartureTime": 'null',
    "planArrivalTime": "2024-06-19 06:00:00",
    "actualArrivalTime": 'null',
    "licensePlate": "粤A11223",
    "driverName": "司机",
    "cargoPickUpPictureList": [],
    "cargoPictureList": [],
    "certificatePictureList": [],
    "deliverPictureList": [],
    "exceptionList": [],
    // "enablePickUp": true
  })
  return await obj
}

export const pickUp = (params: PickUpParams) => {
  return Request.post<null>('/tasks/takeDelivery', params)
}

export const deliver = (params: DeliverParams) => {
  return Request.post<null>('/tasks/deliver', params)
}