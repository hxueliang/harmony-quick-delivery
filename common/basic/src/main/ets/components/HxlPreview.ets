@CustomDialog
@Component
export struct HxlPreview {
  controller: CustomDialogController
  urls: string[] = []
  index: number = 0

  @Builder
  getSwiperUI() {
    Swiper() {
      ForEach(this.urls, (url: string) => {
        Image(url).width('100%').height(400)
      })
    }.index(this.index).loop(false)
    .indicator( /* 设置导航点样式 */
      // new DigitIndicator().fontColor($r('app.color.text_secondary')).selectedFontColor($r('app.color.text_primary'))
      new DotIndicator().color($r('app.color.text_secondary')).selectedColor($r('app.color.text_primary'))
    )
    .displayArrow( /* 设置导航点箭头样式 */{
      showBackground: true,
      isSidebarMiddle: true,
      backgroundSize: 30,
      backgroundColor: $r('app.color.white_transparent'),
      arrowSize: 24,
      arrowColor: $r('app.color.text_primary'),
    }, false)
  }

  build() {
    Column() {
      this.getSwiperUI()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.black'))
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.controller.close()
    })
  }
}