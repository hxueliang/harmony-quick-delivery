import { formatDateTime, HxlCard, HxlCardItem, HxlNavBar, HxlSelectCard, HxlUpload } from '@hxl/basic/Index'
import { ExceptionParamsType, ExceptionParamsTypeModel } from '../../models'
import { router } from '@kit.ArkUI'

const exceptErrorList: string[] = ['发动机启动困难', '不着车、漏油', '照明失灵', '有异常响动', '排烟异常、温度异常', '轮胎漏气', '其他问题']

@Entry
@Component
struct ExceptionReport {
  @State
  exceptionParams: ExceptionParamsTypeModel = new ExceptionParamsTypeModel({} as ExceptionParamsType)
  typeDialog: CustomDialogController = new CustomDialogController({
    builder: HxlSelectCard({
      title: '请选择异常类型',
      renderer: () => {
        this.getTypeListUI()
      },
      onConfirm: () => {
        this.exceptionParams.exceptionType = exceptErrorList[this.currentTypeIndex]
        this.typeDialog.close()
      }
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom,
  })
  @State
  currentTypeIndex: number = -1

  @Builder
  getTypeListItemUI(item: string, index: number, showLine: boolean) {
    Row() {
      Text(item)
      Image(this.currentTypeIndex === index ? $r('app.media.ic_radio_true') : $r('app.media.ic_radio_false'))
        .width(30)
        .aspectRatio(1)
        .translate({ x: 8 })
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.SpaceBetween)
    .border({ width: { bottom: showLine ? 1 : 0 }, color: $r('app.color.background_divider') })
    .onClick(() => {
      this.currentTypeIndex = index
    })
  }

  @Builder
  getTypeListUI() {
    Column() {
      List() {
        ForEach(exceptErrorList, (item: string, index: number) => {
          this.getTypeListItemUI(item, index, index < exceptErrorList.length - 1)
        })
      }
      .padding({ left: 16, right: 16 })
    }
    .height(exceptErrorList.length >= 6 ? 360 : 'auto')
  }

  @Builder
  getListUI() {
    Column() {
      Scroll() {
        Column({ space: 16 }) {
          HxlCard() {
            HxlCardItem({
              label: '异常时间', value: this.exceptionParams.exceptionTime || '请选择', showIcon: true,
              onClink: () => {
                DatePickerDialog.show({
                  showTime: true,
                  useMilitaryTime: true,
                  onDateAccept: (value) => {
                    this.exceptionParams.exceptionTime = formatDateTime(value, 'yyyy-MM-dd hh:mm')
                  }
                })
              }
            })
            HxlCardItem({
              label: '上报位置', value: '请选择', showIcon: true,
              onClink: () => {
                router.pushUrl({
                  url: 'pages/SelectLocation/SelectLocation'
                })
              }
            })
            HxlCardItem({
              label: '异常类型', value: this.exceptionParams.exceptionType || '请选择', showIcon: true,
              onClink: () => {
                this.typeDialog.open()
              }
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
      Button('提交')
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