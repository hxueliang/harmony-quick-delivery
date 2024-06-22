@Preview
@Component
export struct HxlSkeleton {
  @Prop
  showAvatar: boolean = true
  @Prop
  count: number = 3
  timer: number = -1
  @State
  currentColor: string = "#f3f4f5"

  aboutToAppear(): void {
    this.timer = setInterval(() => {
      if (this.currentColor === "#f3f4f5") {
        this.currentColor = "#f7f8f9"
      } else {
        this.currentColor = "#f3f4f5"
      }
    }, 1000)
  }

  aboutToDisappear(): void {
    clearInterval(this.timer)
  }

  @Builder
  getItemRowUI(width: string, backgroundColor: string) {
    Row()
      .width(width)
      .height(26)
      .backgroundColor(backgroundColor)
  }

  @Builder
  getSingleItem() {
    Column() {
      Row({ space: 10 }) {
        if (this.showAvatar) {
          Row()
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor(this.currentColor)
        }
        Column({ space: 10 }) {
          this.getItemRowUI('30%', this.currentColor)
          this.getItemRowUI('100%', this.currentColor)
          this.getItemRowUI('100%', this.currentColor)
          this.getItemRowUI('50%', this.currentColor)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

      }
      .alignItems(VerticalAlign.Top)
      .width('100%')
    }
    .width('100%')
  }

  build() {
    Column({ space: 30 }) {
      ForEach(Array.from(Array(this.count)), () => {
        this.getSingleItem()
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .width('100%')
    .height('100%')
    .backgroundColor($r("app.color.white"))
  }
}