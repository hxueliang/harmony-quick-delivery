import { HxlCard, HxlCardItem, HxlNavBar, HxlUpload } from '@hxl/basic/Index'

@Entry
@Component
struct ExceptionReport {
  @Builder
  getListUI() {
    Column() {
      Scroll() {
        Column({ space: 16 }) {
          HxlCard() {
            HxlCardItem({
              label: '异常时间', value: '请选择', showIcon: true,
            })
            HxlCardItem({
              label: '上报位置', value: '请选择', showIcon: true,
            })
            HxlCardItem({
              label: '异常类型', value: '请选择', showIcon: true,
            })
            HxlCardItem({
              label: '异常描述', value: '', showLine: false,
            })
            TextArea({
              placeholder: '请输入异常描述',
            }).textAreaStyle()
            Text(`0/50`).textAreaCountStyle()
            Row().height(16)
          }

          HxlCard() {
            Row() {
              HxlUpload({
                title: '上传图片(最多6张)',
                imageList: [],
                maxNumber: 6,
                canUpdateImage: true
              })
            }.padding({ top: 20, bottom: 20 })
          }
        }
      }.padding({ bottom: 80 })
    }.layoutWeight(1).margin({ top: 16 })
  }

  @Builder
  getBottomBtnUI() {
    Row() {
      Button("提交")
        .height(50).width(207)
        .backgroundColor($r('app.color.primary'))
    }
    .height(70)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.white'))
  }

  build() {
    Column() {
      HxlNavBar({ title: '上报异常' })

      this.getListUI()

      this.getBottomBtnUI()
    }
    .height('100%').backgroundColor($r('app.color.background_page'))
  }
}

@Extend(TextArea)
function textAreaStyle() {
  .height(130)
  .borderRadius(8)
  .placeholderColor($r('app.color.text_secondary'))
  .fontSize(14)
}

@Extend(Text)
function textAreaCountStyle() {
  .margin({ top: -30 })
  .textAlign(TextAlign.End)
  .width('100%')
  .padding({ right: 15 })
  .fontColor($r('app.color.text_secondary'))
}