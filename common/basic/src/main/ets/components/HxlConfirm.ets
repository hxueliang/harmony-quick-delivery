import { promptAction, TreeListenType } from '@kit.ArkUI'

@Preview
@CustomDialog
@Component
export struct HxlConfirm {
  controller: CustomDialogController
  message: string = '确认要进行此操作吗'
  @Prop
  buttons: ButtonModel[] = [{
    title: '确认',
    fontColor: $r('app.color.primary'),
  }]
  @State
  btnEnabledList: boolean [] = this.buttons.map(_ => true)

  @Builder
  getContentUI() {
    Column() {
      Text(this.message)
        .fontSize(18)
        .fontColor($r('app.color.text_primary'))
    }
    .width('100%')
    .padding({ top: 40, bottom: 40 })
    .justifyContent(FlexAlign.Center)
    .border({
      width: { bottom: 0.5 },
      color: $r('app.color.background_divider')
    })
  }

  @Builder
  getBtnUI() {
    Row() {
      ForEach(this.buttons, (btn: ButtonModel, index: number) => {
        Button(btn.title)
          .fontColor(btn.fontColor || $r('app.color.text_secondary'))
          .fontSize(btn.fontSize || 16)
          .type(ButtonType.Normal)
          .height(50)
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)
          .enabled(this.btnEnabledList[index])
          .border({
            width: { right: this.buttons.length - 1 !== index ? 0.5 : 0 },
            color: $r('app.color.background_divider')
          })
          .onClick(async () => {
            if (btn.action) {
              try {
                this.btnEnabledList[index] = false
                await btn.action()
              } catch (err) {
                console.log('x_log', err.message)
                promptAction.showToast({ message: err.message || '操作失败' })
                return
              } finally {
                this.btnEnabledList[index] = true
              }
            }
            this.controller.close()
          })
      })
    }
  }

  build() {
    Column() {
      this.getContentUI()

      this.getBtnUI()
    }
    .width(278)
    .backgroundColor($r('app.color.white'))
    .borderRadius(12)
  }
}

class ButtonModel {
  title: string = '确认'
  fontColor?: ResourceStr = $r('app.color.text_primary')
  fontSize?: number = 16
  enabled?: boolean = true
  action?: () => void
}