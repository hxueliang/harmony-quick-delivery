import { router } from '@kit.ArkUI'
import { HxlCard, HxlCardItem, HxlCheckBox, HxlNavBar, RouterParams } from '@hxl/basic/Index'

import { TaskDetailInfo, TaskDetailInfoModel } from '../../models'
import { getTaskDetail } from '../../apis'

@Entry
@Component
struct CarRecord {
  @State
  taskDetail: TaskDetailInfoModel = new TaskDetailInfoModel({} as TaskDetailInfo)

  aboutToAppear(): void {
    const params: RouterParams = router.getParams() as RouterParams
    this.getTaskDetail(params.id?.toString() || '')
  }

  async getTaskDetail(id: string) {
    this.taskDetail = await getTaskDetail(id)
  }

  @Builder
  getTimeUI() {
    HxlCard() {
      HxlCardItem({ label: '出车时间', value: this.taskDetail.actualDepartureTime })
      HxlCardItem({ label: '回车时间', value: '2020', showIcon: true, showLine: false })
    }
  }

  @Builder
  getBottomBtnUI() {
    Row() {
      Button('交车').rightBottomBtnStyle()
    }.rowBottomBtnStyle()
  }

  build() {
    Column({ space: 16 }) {
      HxlNavBar({ title: '回车登记' })

      Column() {
        this.getTimeUI()

        HxlCheckBox({ label: '车辆违章', value: false })

        HxlCheckBox({ label: '车辆故障', value: false })

        HxlCheckBox({ label: '车辆事故 ', value: false })

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