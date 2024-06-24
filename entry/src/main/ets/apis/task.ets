import { Request } from '@hxl/basic/Index'
import { TaskListDataModel, TaskListParams } from '../models/task'

export function getTaskList(params: TaskListParams) {
  return Request.get<TaskListDataModel>('/tasks/list', params)
}