import { Request } from '@hxl/basic/Index'
import { TaskListDataModel, TaskListParams } from '../models/task'
import { TaskDetailInfoModel } from '../models/taskDetail'

export function getTaskList(params: TaskListParams) {
  return Request.get<TaskListDataModel>('/tasks/list', params)
}

export function getTaskDetail(id: string) {
  return Request.get<TaskDetailInfoModel>(`/tasks/details/${id}`)
}