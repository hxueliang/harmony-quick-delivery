import { Request } from '@hxl/basic/Index'

import { LoginForm, UserInfoModel, UserTaskInfoModel, UserTaskInfoParam } from '../models'

export const login = (data: LoginForm) => {
  return Request.post<string>('/login/account', data)
}

export const getUserInfo = () => {
  return Request.get<UserInfoModel>('/users')
}

export const getUserTaskInfo = (data: UserTaskInfoParam) => {
  return Request.get<UserTaskInfoModel>('/users/taskReport', data)
}