@CustomDialog
@Preview
@Component
export struct HxlSelectCard {
  controller: CustomDialogController
  title: string = ''
  showIcon: boolean = true
  @BuilderParam
  renderer: () => void
  onConfirm: () => void = () => {
  }

  @Builder
  getTitleUI() {
    Row() {
      Text(this.title)
        .fontSize(18)
        .fontWeight(600)
        .fontColor($r('app.color.text_primary'))
      Image($r('app.media.ic_btn_close'))
        .width(16)
        .colorBlend($r('app.color.text_secondary'))
        .aspectRatio(1)
    }
    .width('100%')
    .padding({ bottom: 10, left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  getListUI() {
    if (this.renderer) {
      this.renderer()
    }
  }

  @Builder
  getBtnUI() {
    Row() {
      Button('确定')
        .width('70%')
        .backgroundColor($r('app.color.primary'))
        .onClick(() => {
          this.onConfirm()
        })
    }
    .width('100%')
    .padding({ top: 10 })
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      this.getTitleUI()

      this.getListUI()

      this.getBtnUI()
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .backgroundColor($r('app.color.white'))
    .borderRadius({ topLeft: 12, topRight: 12 })
  }
}