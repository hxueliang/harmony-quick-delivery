@Component
export struct HxlCard {
  @BuilderParam
  HxlCardItemCb: () => void
  left: number = 16
  right: number = 16

  build() {
    Column() {
      Column() {
        if (this.HxlCardItemCb) {
          this.HxlCardItemCb()
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .borderRadius(8)
    .backgroundColor($r('app.color.white'))
    .margin({ left: this.left, right: this.right })
  }
}