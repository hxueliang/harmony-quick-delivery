import { HxlList } from '@hxl/basic/Index'

import { TaskListItem } from '.'
import { getTaskList } from '../../../apis'
import { TaskStatusEnum } from '../../../constants'
import { TaskListDataItemModel, TaskListParams, TaskListParamsModel } from '../../../models'

@Component
struct TaskList {
  @State
  queryParams: TaskListParamsModel = new TaskListParamsModel({
    status: TaskStatusEnum.WAITING,
    page: 1,
    pageSize: 5,
  } as TaskListParams)
  @State
  taskList: TaskListDataItemModel[] = []
  @State
  pageTotal: number = 1

  async getTaskList(isAppend?: boolean) {
    const result = await getTaskList(this.queryParams)
    const list = isAppend ? this.taskList : []
    this.taskList = list.concat(result.items)
    this.queryParams.page++
    this.pageTotal = result.pages
  }

  @Builder
  getItemUI(item: object) {
    TaskListItem({
      item: item as TaskListDataItemModel
    })
  }

  build() {
    HxlList({
      list: this.taskList,
      finished: this.pageTotal < this.queryParams.page,
      loadingText: '努力加载中...',
      finishedText: '--我是有底线的--',
      renderer: (item: object) => {
        this.getItemUI(item)
      },
      onLoad: async () => {
        await this.getTaskList(true)
      },
      onRefresh: async () => {
        this.queryParams.page = 1
        await this.getTaskList()
      }
    })
  }
}

export default TaskList