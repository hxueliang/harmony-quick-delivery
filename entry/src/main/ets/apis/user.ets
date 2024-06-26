import { Request } from '@hxl/basic/Index'

import { LoginForm, UserInfoModel, UserTaskInfoModel, UserTaskInfoParam } from '../models'

export const login = async (data: LoginForm) => {
  return Request.post<string>('/login/account', data)

  // 模似登录返回token
  return await 'token123'
}

export const getUserInfo = () => {
  return Request.get<UserInfoModel>('/users')
}

export const getUserTaskInfo = (data: UserTaskInfoParam) => {
  return Request.get<UserTaskInfoModel>('/users/taskReport', data)
}