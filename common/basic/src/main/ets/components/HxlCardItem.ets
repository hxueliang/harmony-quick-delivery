@Preview
@Component
export struct HxlCardItem {
  @Prop
  value: string = ''
  label: string = ''
  showIcon: boolean = true
  showLine: boolean = true
  onClink: () => void = () => {
  }

  build() {
    Row() {
      Text(this.label)
        .fontColor($r('app.color.text_primary'))
      Row() {
        if (this.value) {
          Text(this.value)
            .fontColor($r('app.color.text_secondary'))
        }
        if (this.showIcon) {
          Image($r('app.media.ic_btn_more'))
            .width(20)
            .aspectRatio(1)
        }
      }
      .translate({ x: 4 })
      .onClick(() => this.onClink())
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.SpaceBetween)
    .border({
      width: {
        bottom: this.showLine ? 1 : 0
      },
      color: $r('app.color.background_divider')
    })
  }
}