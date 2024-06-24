import { TaskStatusEnum } from '../constants'

/** 任务列表请求参数 */
export interface TaskListParams {
  /** 结束时间 */
  endTime: string | null
  /** 页码 */
  page: number
  /** 页面大小 */
  pageSize: number
  /** 开始时间 */
  startTime: string | null
  /** 作业状态 */
  status: TaskStatusEnum
  /** 运输任务id */
  transportTaskId: string | null
}

/** 任务列表数据 */
export interface TaskListData {
  /** 总条目数 */
  counts: number
  /** 数据列表 */
  items: TaskListDataItem[]
  /** 页码 */
  page: number
  /** 总页数 */
  pages: number
  /** 页尺寸 */
  pageSize: number
}

/** 任务列表数据项 */
export interface TaskListDataItem {
  /** 实际到达时间 */
  actualArrivalTime: string
  /** 实际发车时间 */
  actualDepartureTime: string
  /** 创建时间 */
  created: string
  /** 司机id */
  driverId: string
  /** 是否可提货 */
  enablePickUp: boolean
  /** 目的机构地址 */
  endAddress: string
  /** 目的机构id */
  endAgencyId: number
  /** 交付对接人 */
  finishHandover: string
  /** 司机作业单id */
  id: string
  /** 计划到达时间 */
  planArrivalTime: string
  /** 计划发车时间 */
  planDepartureTime: string
  /** 起始机构地址 */
  startAddress: string
  /** 起始机构id */
  startAgencyId: number
  /** 提货对接人 */
  startHandover: string
  /** 作业状态 */
  status: string
  /** 运输任务id */
  transportTaskId: string
}

export class TaskListParamsModel implements TaskListParams {
  endTime: string | null = null
  page: number = 0
  pageSize: number = 0
  startTime: string | null = null
  status: TaskStatusEnum = TaskStatusEnum.WAITING
  transportTaskId: string | null = null

  constructor(model: TaskListParams) {
    this.endTime = model.endTime
    this.page = model.page
    this.pageSize = model.pageSize
    this.startTime = model.startTime
    this.status = model.status
    this.transportTaskId = model.transportTaskId
  }
}

export class TaskListDataModel implements TaskListData {
  counts: number = 0
  items: TaskListDataItem[] = []
  page: number = 0
  pages: number = 0
  pageSize: number = 0

  constructor(model: TaskListData) {
    this.counts = model.counts
    this.items = model.items
    this.page = model.page
    this.pages = model.pages
    this.pageSize = model.pageSize
  }
}

export class TaskListDataItemModel implements TaskListDataItem {
  actualArrivalTime: string = ''
  actualDepartureTime: string = ''
  created: string = ''
  driverId: string = ''
  enablePickUp: boolean = false
  endAddress: string = ''
  endAgencyId: number = 0
  finishHandover: string = ''
  id: string = ''
  planArrivalTime: string = ''
  planDepartureTime: string = ''
  startAddress: string = ''
  startAgencyId: number = 0
  startHandover: string = ''
  status: string = ''
  transportTaskId: string = ''

  constructor(model: TaskListDataItem) {
    this.actualArrivalTime = model.actualArrivalTime
    this.actualDepartureTime = model.actualDepartureTime
    this.created = model.created
    this.driverId = model.driverId
    this.enablePickUp = model.enablePickUp
    this.endAddress = model.endAddress
    this.endAgencyId = model.endAgencyId
    this.finishHandover = model.finishHandover
    this.id = model.id
    this.planArrivalTime = model.planArrivalTime
    this.planDepartureTime = model.planDepartureTime
    this.startAddress = model.startAddress
    this.startAgencyId = model.startAgencyId
    this.startHandover = model.startHandover
    this.status = model.status
    this.transportTaskId = model.transportTaskId
  }
}
