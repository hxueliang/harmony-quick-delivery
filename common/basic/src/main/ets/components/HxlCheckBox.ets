@Preview
@Component
export struct HxlCheckBox {
  @Prop
  value: boolean = false
  label: string = ''
  confirmText: string = '是'
  cancelText: string = '否'
  ml: number = 16
  mr: number = 16
  mt: number = 16
  mb: number = 0
  onChangeValue: (value: boolean) => void = () => {
  }

  @Builder
  getCheckBoxUI(type: boolean) {
    Row() {
      Image(type === this.value ? $r('app.media.ic_radio_true') : $r('app.media.ic_radio_false'))
        .width(32)
        .aspectRatio(1)
      Text(type ? this.confirmText : this.cancelText)
    }.onClick(() => {
      this.value = type
      this.onChangeValue(this.value)
    })
  }

  build() {
    Row() {
      Row() {
        // 左侧文案
        Text(this.label)
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))

        // 右侧内容
        Row({ space: 10 }) {
          this.getCheckBoxUI(true)
          this.getCheckBoxUI(false)
        }
      }.getBoxStyles()
    }
    .width('100%')
    .padding({ left: this.ml, right: this.mr, top: this.mt, bottom: this.mb })
  }
}

@Extend(Row)
function getBoxStyles() {
  .width('100%')
  .borderRadius(8)
  .height(60)
  .padding({ left: 16, right: 16 })
  .justifyContent(FlexAlign.SpaceBetween)
  .backgroundColor($r('app.color.white'))
}
