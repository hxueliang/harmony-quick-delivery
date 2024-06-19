@Entry
@Component
struct StartAd {
  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r('app.media.background')).objectFit(ImageFit.Cover)
      Text(`5秒后跳过`)
        .padding({ left: 10, right: 10 })
        .margin({ right: 20, top: 20 })
        .height(30)
        .fontSize(14)
        .borderRadius(15)
        .backgroundColor($r("app.color.background_page"))
        .textAlign(TextAlign.Center)

    }.height('100%').width('100%')
  }
}
