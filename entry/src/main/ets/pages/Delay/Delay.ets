import { HxlCard, HxlCardItem, HxlNavBar } from '@hxl/basic/Index'

@Entry
@Component
struct Delay {
  build() {
    Column() {
      HxlNavBar({ title: '延迟提货' })
      HxlCard() {
        HxlCardItem({ label: '原定时间', value: '' })
        HxlCardItem({ label: '延迟时间', value: '', showIcon: true })
        TextArea({ placeholder: '请输入延迟提货原因' }).getTextAreaStyle()
        Text('0/50').getTextStyle()
        Row() {
          Button("提交").height(50).width(207).backgroundColor($r('app.color.primary'))
        }.justifyContent(FlexAlign.Center).padding({ top: 20, bottom: 20 })
      }
    }.height('100%').backgroundColor($r('app.color.background_page'))
  }
}

@Extend(TextArea)
function getTextAreaStyle() {
  .backgroundColor($r('app.color.background_page'))
  .margin({ top: 20 })
  .borderRadius(8)
  .height(130)
  .placeholderColor($r('app.color.text_secondary'))
  .fontSize(14)
}

@Extend(Text)
function getTextStyle() {
  .margin({ top: -30 })
  .textAlign(TextAlign.End)
  .width('100%')
  .padding({ right: 15 })
  .fontColor($r('app.color.text_secondary'))
}