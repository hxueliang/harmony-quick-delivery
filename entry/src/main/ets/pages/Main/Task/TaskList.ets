import { getTaskList } from '../../../apis'
import { TaskStatusEnum } from '../../../constants'
import {
  TaskListData,
  TaskListDataItemModel,
  TaskListDataModel,
  TaskListParams,
  TaskListParamsModel
} from '../../../models'

@Component
struct TaskList {
  @State
  queryParams: TaskListParamsModel = new TaskListParamsModel({
    status: TaskStatusEnum.WAITING,
    page: 1,
    pageSize: 5,
  } as TaskListParams)
  @State
  taskData: TaskListDataModel = new TaskListDataModel({} as TaskListData)
  @State
  taskList: TaskListDataItemModel[] = []

  aboutToAppear(): void {
    this.getTaskList()
  }

  async getTaskList() {
    this.taskData = await getTaskList(this.queryParams)
    this.taskList = this.taskData.items
  }

  build() {
    Text(JSON.stringify(this.taskList))
  }
}

export default TaskList