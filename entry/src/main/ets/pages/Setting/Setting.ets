import { HxlCard, HxlCardItem, HxlConfirm, HxlNavBar, TokenStore, TOKEN_KEY } from '@hxl/basic/Index'
import { promptAction, router } from '@kit.ArkUI'

import { getUserTaskInfo } from '../../apis'

@Entry
@Component
struct Setting {
  confirm: CustomDialogController = new CustomDialogController({
    builder: HxlConfirm({
      message: '确认要退出吗？',
      buttons: [{
        title: '取消',
      }, {
        title: '确认',
        fontColor: $r('app.color.primary'),
        action: async () => {
          await this.logoutApi()
        }
      }]
    }),
    customStyle: true,
    alignment: DialogAlignment.Center,
    autoCancel: false,
  })

  async logoutApi() {
    // 模似成功接口-失败
    // return new Promise<boolean>((resolve, reject) => {
    //   setTimeout(() => {
    //     reject(new Error('退出登录失败'))
    //   }, 1000)
    // })

    // 模似成功接口-成功
    await getUserTaskInfo({
      year: new Date().getFullYear().toString().padStart(2, '0'),
      month: (new Date().getMonth() + 1).toString().padStart(2, '0')
    })
    promptAction.showToast({ message: '【模拟接口】退出成功' })
    AppStorage.set(TOKEN_KEY, '')
    new TokenStore(getContext()).setToken('')
    router.pushUrl({ url: 'pages/Login/Login' })
  }

  @Builder
  getListUI() {
    Column() {
      HxlCard() {
        HxlCardItem({ label: '换绑手机' })
        HxlCardItem({ label: '修改密码' })
        HxlCardItem({ label: '消息通知设置' })
        HxlCardItem({ label: '清理缓存', showLine: false })
      }
    }
    .padding({ top: 20, bottom: 20 })
  }

  @Builder
  getBtnUI() {
    Row() {
      Button('退出')
        .width('100%')
        .height(50)
        .backgroundColor($r('app.color.white'))
        .borderRadius(8)
        .fontColor($r('app.color.text_primary'))
        .type(ButtonType.Normal)
        .borderRadius(8)
        .onClick(() => {
          this.confirm.open()
        })
    }
    .padding({ right: 16, left: 16 })
  }

  build() {
    Column() {
      HxlNavBar({ title: '系统设置' })

      this.getListUI()

      this.getBtnUI()

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}