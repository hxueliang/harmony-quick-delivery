import router from '@ohos.router';

@Preview
@Component
export struct HxlNavBar {
  title: string = ''
  showBack: boolean = true

  @Builder
  getTitleUI() {
    if (this.title) {
      Row() {
        Text(this.title)
          .fontColor($r('app.color.text_primary'))
          .fontSize(18)
          .fontWeight(600)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .height('100%')
    }
  }

  @Builder
  getBackUI() {
    if (this.showBack) {
      Row() {
        Image($r("app.media.ic_btn_nav_back"))
          .width(44)
          .aspectRatio(1)
          .onClick(() => {
            router.back()
          })
      }
      .alignItems(VerticalAlign.Center)
      .width(44)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      this.getTitleUI()

      this.getBackUI()
    }
    .backgroundColor($r('app.color.white'))
    .height(50)
    .width('100%')
  }
}
