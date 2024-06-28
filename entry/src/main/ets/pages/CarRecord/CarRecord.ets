import { promptAction, router } from '@kit.ArkUI'
import {
  formatDateTime,
  HxlCard,
  HxlCardItem,
  HxlCheckBox,
  HxlLoading,
  HxlNavBar,
  RouterParams
} from '@hxl/basic/Index'

import { CarRecordType, CarRecordTypeModel, TaskDetailInfo, TaskDetailInfoModel } from '../../models'
import { carRecord, getTaskDetail } from '../../apis'

@Entry
@Component
struct CarRecord {
  @State
  taskDetail: TaskDetailInfoModel = new TaskDetailInfoModel({} as TaskDetailInfo)
  @State
  carRecordParams: CarRecordTypeModel = new CarRecordTypeModel({} as CarRecordType)
  loading: CustomDialogController = new CustomDialogController({
    builder: HxlLoading({ title: '处理中...' }),
    customStyle: true
  })

  aboutToAppear(): void {
    const params: RouterParams = router.getParams() as RouterParams
    this.getTaskDetail(params.id?.toString() || '')
  }

  async getTaskDetail(id: string) {
    this.taskDetail = await getTaskDetail(id)
  }

  async goCarRecord() {
    if (!this.carRecordParams.endTime) {
      promptAction.showToast({ message: '请选择回车时间' })
      return
    }
    this.carRecordParams.id = this.taskDetail.transportTaskId
    this.carRecordParams.startTime = this.taskDetail.actualDepartureTime
    try {
      this.loading.open()
      await carRecord(this.carRecordParams)
      promptAction.showToast({ message: '交车成功' })
      router.clear()
      router.replaceUrl({
        url: 'pages/Main/Main'
      })
    } catch (err) {
      promptAction.showToast({ message: err.message })
    } finally {
      this.loading.close()
    }
  }

  @Builder
  getTimeUI() {
    HxlCard() {
      HxlCardItem({ label: '出车时间', value: this.taskDetail.actualDepartureTime })
      HxlCardItem({
        label: '回车时间',
        value: this.carRecordParams.endTime || '请选择',
        showIcon: true,
        showLine: false,
        onClink: () => {
          DatePickerDialog.show({
            showTime: true,
            useMilitaryTime: true,
            onDateAccept: (date) => {
              const formatDate = formatDateTime(new Date(date), 'yyyy-MM-dd hh:mm')
              this.carRecordParams.endTime = formatDate;
            }
          })
        }
      })
    }
  }

  @Builder
  getBottomBtnUI() {
    Row() {
      Button('交车').rightBottomBtnStyle()
        .onClick(() => {
          this.goCarRecord()
        })
    }.rowBottomBtnStyle()
  }

  build() {
    Column({ space: 16 }) {
      HxlNavBar({ title: '回车登记' })

      Column() {
        this.getTimeUI()

        HxlCheckBox({
          label: '车辆违章',
          value: !!this.carRecordParams.isBreakRules,
          onChangeValue: bool => this.carRecordParams.isBreakRules = bool
        })

        HxlCheckBox({
          label: '车辆故障',
          value: !!this.carRecordParams.isFault,
          onChangeValue: bool => this.carRecordParams.isFault = bool
        })

        HxlCheckBox({
          label: '车辆事故 ',
          value: !!this.carRecordParams.isAccident,
          onChangeValue: bool => this.carRecordParams.isAccident = bool
        })

      }.layoutWeight(1)

      this.getBottomBtnUI()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}

@Extend(Button)
function rightBottomBtnStyle() {
  .backgroundColor($r('app.color.primary'))
  .fontColor($r('app.color.white'))
  .height(50)
  .width('70%')
  .margin({ left: 13 })
}

@Extend(Row)
function rowBottomBtnStyle() {
  .width('100%')
  .padding({ left: 15, right: 15 })
  .height(70)
  .justifyContent(FlexAlign.Center)
  .alignItems(VerticalAlign.Center)
  .backgroundColor($r('app.color.white'))
}