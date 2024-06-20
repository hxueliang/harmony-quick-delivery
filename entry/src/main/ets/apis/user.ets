import { Request } from '@hxl/basic/Index'

import { LoginForm, UserInfoModel } from '../models/user'

export const login = (data: LoginForm) => {
  return Request.post<string>('/login/account', data)
}

export const getUserInfo = () => {
  return Request.get<UserInfoModel>('/users')
}