import { HxlCard, HxlCardItem, HxlNavBar } from '@hxl/basic/Index'

@Entry
@Component
struct Setting {
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