import { MarginPaddingModel } from '../models'

@Component
export struct HxlToggleCard {
  @State
  showCard: boolean = false
  title: string = '标题'
  style: MarginPaddingModel = new MarginPaddingModel()
  @BuilderParam
  contentUI: () => void

  build() {
    Column({ space: 16 }) {
      Row() {
        Text(this.title)
          .fontSize(18)
          .fontWeight(500)
          .fontColor($r('app.color.text_primary'))
        Image(this.showCard ? $r('app.media.ic_btn_cut') : $r('app.media.ic_btn_add'))
          .width(30)
          .aspectRatio(1)
          .onClick(() => {
            animateTo({ duration: 300 }, () => {
              this.showCard = !this.showCard
            })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      if (this.showCard && this.contentUI) {
        this.contentUI()
      }
    }
    .padding({
      left: this.style.pl || this.style.plr || this.style.p,
      right: this.style.pr || this.style.plr || this.style.p,
      top: this.style.pt || this.style.ptb || this.style.p,
      bottom: this.style.pb || this.style.ptb || this.style.p,
    })
    .margin({
      left: this.style.ml || this.style.mlr || this.style.m,
      right: this.style.mr || this.style.mlr || this.style.m,
      top: this.style.mt || this.style.mtb || this.style.m,
      bottom: this.style.mb || this.style.mtb || this.style.m,
    })
    .backgroundColor($r('app.color.white'))
    .borderRadius(8)
  }
}