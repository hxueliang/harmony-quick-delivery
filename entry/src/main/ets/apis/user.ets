import { Request } from '@hxl/basic/Index'

import { LoginForm } from '../models/user'

export const login = (data: LoginForm) => {
  return Request.post<string>('/login/account', data)
}