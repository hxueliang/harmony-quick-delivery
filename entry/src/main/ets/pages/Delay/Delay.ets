import { formatDateTime, HxlCard, HxlCardItem, HxlNavBar, RouterParams } from '@hxl/basic/Index'
import { promptAction, router } from '@kit.ArkUI'

import { DelayParamsType, DelayParamsTypeModel } from '../../models'
import { delay } from '../../apis'

@Entry
@Component
struct Delay {
  @State
  delayParams: DelayParamsTypeModel = new DelayParamsTypeModel({} as DelayParamsType)
  @State
  oldTime: string = ''

  aboutToAppear(): void {
    const params = router.getParams() as RouterParams
    this.delayParams.id = params.id?.toString() || ''
    this.oldTime = params.oldTime || ''
  }

  getSubmitEnable() {
    return !!(this.delayParams?.id && this.delayParams?.delayTime && this.delayParams?.delayReason)
  }

  async onSubmit() {
    await delay(this.delayParams)
    router.back()
    promptAction.showToast({ message: '延迟提货成功' })
  }

  build() {
    Column() {
      HxlNavBar({ title: '延迟提货' })
      HxlCard() {
        HxlCardItem({ label: '原定时间', value: this.oldTime })
        HxlCardItem({
          label: '延迟时间',
          value: this.delayParams.delayTime || '请选择',
          showIcon: true,
          onClink: () => {
            DatePickerDialog.show({
              showTime: true,
              useMilitaryTime: true,
              onDateAccept: (date) => {
                const formatDate = formatDateTime(new Date(date), 'yyyy-MM-dd hh:mm')
                this.delayParams.delayTime = formatDate
              }
            })
          }
        })

        TextArea({ placeholder: '请输入延迟提货原因', text: this.delayParams.delayReason }).getTextAreaStyle()
          .onChange((value) => {
            this.delayParams.delayReason = value
          })
        Text(`${this.delayParams.delayReason?.length || 0}/50`).getTextStyle()
        Row() {
          Button("提交").getSubmitBtnStyles()
            .enabled(this.getSubmitEnable())
            .onClick(() => this.onSubmit())
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
  .maxLength(50)
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

@Styles
function getSubmitBtnStyles() {
  .height(50)
  .width(207)
  .backgroundColor($r('app.color.primary'))
}