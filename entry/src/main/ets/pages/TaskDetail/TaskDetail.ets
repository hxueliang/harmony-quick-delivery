import { router } from '@kit.ArkUI'
import { HxlNavBar, HxlToggleCard, KeyValue, RouterParams } from '@hxl/basic/Index'

import { TaskDetailInfo, TaskDetailInfoModel } from '../../models/taskDetail'
import { getTaskDetail } from '../../apis'

@Entry
@Component
struct TaskDetail {
  @State
  taskDetail: TaskDetailInfoModel = new TaskDetailInfoModel({} as TaskDetailInfo)

  aboutToAppear(): void {
    const params = router.getParams() as RouterParams
    if (params?.id) {
      this.getTaskDetail(params.id.toString())
    }
  }

  async getTaskDetail(id: string) {
    this.taskDetail = await getTaskDetail(id)
  }

  /** 获取基础信息项目 */
  @Builder
  getBaseItemUI(item: KeyValue<string>) {
    Row() {
      Text(item.label).fontSize(14).fontColor($r('app.color.text_secondary')).lineHeight(20)
      Row() {
        Text(item.value).fontSize(14).fontColor($r('app.color.text_secondary'))
        if (item.icon) {
          Image(item.icon).width(24).height(24)
        }
      }
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({ top: 14 })
  }

  /** 获取基础信息 */
  @Builder
  getBaseUI() {
    Row() {
      Column() {
        Row() {
          Text('起').baseTextOneStyle()
          Text('北京市昌平区回龙观街道西三旗桥东金燕龙写字楼8877号').baseTextTwoStyle()
        }.margin({ top: 21 })

        Row() {
          Text('止').baseTextOneStyle().backgroundColor($r('app.color.primary'))
          Text('河南省郑州市路北区北清路99号').baseTextTwoStyle()
        }.margin({ top: 14.5 })
      }.alignItems(HorizontalAlign.Start).layoutWeight(1).margin({ right: 20 })

      Column() {
        Image($r('app.media.ic_navigation')).width(22).height(22)
        Text('开始导航').fontSize(14).margin({ top: 10, bottom: 10 })
      }.justifyContent(FlexAlign.SpaceBetween).margin({ top: 20 })

    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width('100%')

    Divider().vertical(false).height(2).color($r('app.color.background_divider')).margin({ left: 8, right: 8, top: 21 })

    this.getBaseItemUI({ label: '任务编号', value: '2132324324343434' })
    this.getBaseItemUI({ label: '联系人', value: '2132324324343434' })
    this.getBaseItemUI({ label: '联系电话', value: '2132324324343434', icon: $r('app.media.ic_phone') })
    this.getBaseItemUI({ label: '提货时间', value: '2132324324343434' })
    this.getBaseItemUI({ label: '预计送达时间', value: '2132324324343434' })
  }

  /** 车辆司机信息 */
  @Builder
  getDriverUI() {
    Row() {
      Text(`车牌号`).fontSize(14).fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Text("京A123456").fontSize(14).fontColor($r('app.color.text_secondary'))
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({
      top: 14
    })

    Row() {
      Text(`司机姓名`).fontSize(14).fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Text("张三").fontSize(14).fontColor($r('app.color.text_secondary'))
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({
      top: 14
    })
  }

  /** 运输路线 */
  @Builder
  getTransLineUI() {
    Row() {
      Column() {
        Text("北京市").fontSize(16).fontColor($r('app.color.text_primary')).lineHeight(22).fontWeight(600)
        Text("北京市").fontSize(14).lineHeight(22)
      }.width(50)

      Image($r("app.media.ic_right_arrow")).width(36).height(16)
      Column() {
        Text("河南省").fontSize(16).fontColor($r('app.color.text_primary')).lineHeight(22).fontWeight(600)
        Text("郑州市").fontSize(14).lineHeight(22)
      }.width(50)
    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width('100%').padding({
      left: 60,
      right: 60
    })
  }

  @Builder
  getListUI() {
    Scroll() {
      Column({ space: 16 }) {
        HxlToggleCard({ title: '基本信息' }) {
          this.getBaseUI()
        }

        HxlToggleCard({ title: '车辆司机信息' }) {
          this.getDriverUI()
        }

        HxlToggleCard({ title: '运输路线' }) {
          this.getTransLineUI()
        }
      }
      .padding({ top: 16, bottom: 16 })
    }
  }

  build() {
    Column() {
      HxlNavBar({ title: '任务详情' })

      this.getListUI()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}

@Extend(Text)
function baseTextOneStyle() {
  .fontSize(12)
  .fontColor($r('app.color.white'))
  .backgroundColor($r('app.color.text_primary'))
  .width(22)
  .height(22)
  .borderRadius(11)
  .textAlign(TextAlign.Center)
}

@Extend(Text)
function baseTextTwoStyle() {
  .margin({ left: 11.5 }).fontColor($r('app.color.text_secondary')).fontSize(14).lineHeight(20)
}