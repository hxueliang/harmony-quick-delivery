import { TokenStore, TOKEN_KEY } from '@hxl/basic/Index'
import { login } from '../../apis'
import { LoginForm, LoginFormModel } from '../../models'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct Login {
  @State
  loading: boolean = false
  @State
  loginForm: LoginFormModel = new LoginFormModel({
    account: '13512341234',
    password: '123456'
  } as LoginForm)

  getBtnEnabled() {
    if (!this.loginForm.account || !this.loginForm.password) {
      return false
    }
    if (this.loading) {
      return false
    }
    // Todo: 其它效验
    return true
  }

  @Styles
  loginStyle() {
    .backgroundColor('#fff')
    .border({ color: $r('app.color.background_divider'), width: { bottom: 1 } })
    .width('100%')
    .height(58)
    .borderRadius(0)
  }

  async login() {
    this.loading = true
    const token = await login(this.loginForm)
    this.loading = false
    await new TokenStore(getContext()).setToken(token)
    AppStorage.set(TOKEN_KEY, token)
    promptAction.showToast({ message: '登录成功' })
    router.replaceUrl({ url: 'pages/Main/Main' })
  }

  build() {
    Column() {
      // 顶部标题
      Text('速送').fontColor($r('app.color.text_primary')).fontSize(18).height(25)
      // 账号登录
      Row() {
        Text('账号登录').fontColor($r('app.color.text_primary')).fontSize(24).fontWeight(FontWeight.Bold)
        Row() {
          Text('注册').fontColor($r('app.color.primary')).fontSize(16).fontWeight(FontWeight.Bold)
          Image($r("app.media.ic_angle")).width(10).height(10).margin({ left: 5 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 50, bottom: 50 })

      // 用户名输入框
      TextInput({ placeholder: '请输入账号', text: this.loginForm.account })
        .loginStyle()
        .onChange((value) => {
          this.loginForm.account = value
        })

      // 密码框
      TextInput({ placeholder: '请输入密码', text: this.loginForm.password })
        .loginStyle()
        .type(InputType.Password)
        .showPasswordIcon(true)// 显示密码按钮
        .onChange((value) => {
          this.loginForm.password = value
        })
        .onSubmit(() => {
          this.login()
        })

      // 登录按钮
      Button({ type: ButtonType.Capsule }) {
        Row() {
          if (this.loading) {
            LoadingProgress().width(20).height(20).margin({ right: 12 }).color($r('app.color.white'))
          }
          Text('登录').fontColor($r('app.color.white'))
        }
      }
      .backgroundColor($r('app.color.primary'))
      .width('100%')
      .height(50)
      .margin({ top: 50 })
      .enabled(this.getBtnEnabled())
      .onClick(() => {
        this.login()
      })
    }
    .padding({ left: 32, right: 32 })
    .margin({ top: 40 })
  }
}