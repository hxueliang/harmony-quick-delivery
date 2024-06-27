import { promptAction, router } from '@kit.ArkUI'
import {
  HxlLoading,
  HxlNavBar,
  HxlSkeleton,
  HxlToggleCard,
  HxlUpload,
  ImageList,
  ImageListModel,
  KeyValue,
  RouterParams,
  UploadFile
} from '@hxl/basic/Index'

import { TaskDetailInfo, TaskDetailInfoModel } from '../../models/taskDetail'
import { getTaskDetail, pickUp } from '../../apis'
import { PickUpParams } from '../../models'

@Entry
@Component
struct TaskDetail {
  @State
  taskDetail: TaskDetailInfoModel = new TaskDetailInfoModel({} as TaskDetailInfo)
  scroller: Scroller = new Scroller()
  loading: CustomDialogController = new CustomDialogController({
    builder: HxlLoading({ title: '处理中...' }),
    customStyle: true
  })

  aboutToAppear(): void {
    const params = router.getParams() as RouterParams
    if (params?.id) {
      this.getTaskDetail(params.id.toString())
    }
  }

  async getTaskDetail(id: string) {
    this.taskDetail = await getTaskDetail(id)
  }

  /** 提货按钮可否点击 */
  getPickUpEnabled() {
    return (
      this.taskDetail.cargoPickUpPictureList?.length > 0
        && this.taskDetail.cargoPickUpPictureList?.every(item =>!!item.url)
        && this.taskDetail.cargoPictureList?.length > 0
        && this.taskDetail.cargoPictureList?.every(item =>!!item.url)
    )
  }

  /** 点击提货 */
  async goPickUp() {
    try {
      this.loading.open()
      let arr = await Promise.all([
        UploadFile(this.taskDetail.cargoPickUpPictureList),
        UploadFile(this.taskDetail.cargoPictureList)
      ])
      // 模似上传返回数据
      // let arr = [
      //   [{ url: 'https://b.bdstatic.com/searchbox/icms/searchbox/img/young_boy.png' } as ImageList],
      //   [{ url: 'https://b.bdstatic.com/searchbox/icms/searchbox/img/young_girl.png' } as ImageList]
      // ]
      const params: PickUpParams = {
        id: this.taskDetail.id,
        cargoPickUpPictureList: arr[0],
        cargoPictureList: arr[1]
      }
      await pickUp(params)
      this.getTaskDetail(this.taskDetail.id)
      this.scroller.scrollEdge(Edge.Top)
      promptAction.showToast({ message: '提货成功' })
    } catch (err) {
      const errObj: Error = Array.isArray(err) && err.length ? err[0] : err
      console.log('x_log', errObj.message)
      AlertDialog.show({ message: errObj.message })
    } finally {
      this.loading.close()
    }
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
          Text(this.taskDetail.startAddress).baseTextTwoStyle()
        }.margin({ top: 21 })

        Row() {
          Text('止').baseTextOneStyle().backgroundColor($r('app.color.primary'))
          Text(this.taskDetail.endAddress).baseTextTwoStyle()
        }.margin({ top: 14.5 })
      }.alignItems(HorizontalAlign.Start).layoutWeight(1).margin({ right: 20 })

      Column() {
        Image($r('app.media.ic_navigation')).width(22).height(22)
        Text('开始导航').fontSize(14).margin({ top: 10, bottom: 10 })
      }.justifyContent(FlexAlign.SpaceBetween).margin({ top: 20 })

    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width('100%')

    Divider().vertical(false).height(2).color($r('app.color.background_divider')).margin({ left: 8, right: 8, top: 21 })

    this.getBaseItemUI({ label: '任务编号', value: this.taskDetail.transportTaskId })
    this.getBaseItemUI({ label: '联系人', value: this.taskDetail.startHandoverName })
    this.getBaseItemUI({ label: '联系电话', value: this.taskDetail.startHandoverPhone, icon: $r('app.media.ic_phone') })
    this.getBaseItemUI({ label: '提货时间', value: this.taskDetail.planDepartureTime })
    this.getBaseItemUI({ label: '预计送达时间', value: this.taskDetail.planArrivalTime })
  }

  /** 车辆司机信息 */
  @Builder
  getDriverUI() {
    Row() {
      Text(`车牌号`).fontSize(14).fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Text(this.taskDetail.licensePlate).fontSize(14).fontColor($r('app.color.text_secondary'))
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({
      top: 14
    })

    Row() {
      Text(`司机姓名`).fontSize(14).fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Text(this.taskDetail.driverName).fontSize(14).fontColor($r('app.color.text_secondary'))
    }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({
      top: 14
    })
  }

  /** 运输路线 */
  @Builder
  getTransLineUI() {
    Row() {
      Column() {
        Text(this.taskDetail.startProvince)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .lineHeight(22)
          .fontWeight(600)
        Text(this.taskDetail.startCity).fontSize(14).lineHeight(22)
      }.width(50)

      Image($r("app.media.ic_right_arrow")).width(36).height(16)
      Column() {
        Text(this.taskDetail.endProvince)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
          .lineHeight(22)
          .fontWeight(600)
        Text(this.taskDetail.endCity).fontSize(14).lineHeight(22)
      }.width(50)
    }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width('100%').padding({
      left: 60,
      right: 60
    })
  }

  /** 提货信息 */
  @Builder
  getTakeGoodsUI() {
    Column() {
      HxlUpload({
        title: '请拍照上传回单凭证',
        imageList: this.taskDetail.cargoPickUpPictureList || [],
        onListChange: (list: ImageList[]) => {
          this.taskDetail.cargoPickUpPictureList = list
        }
      })
      HxlUpload({
        title: '请拍照上传货品照片',
        imageList: this.taskDetail.cargoPictureList || [],
        onListChange: (list: ImageList[]) => {
          this.taskDetail.cargoPictureList = list
        }
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  /** 底部按钮结构 */
  @Builder
  getBottomBtnUI() {
    // 已完成不显示任何按钮
    Row() {
      Button("延迟收货", { type: ButtonType.Capsule })
        .backgroundColor($r('app.color.btn_gray'))
        .fontColor($r('app.color.text_primary'))
        .fontSize(16)
        .height(50)
        .width(125)
      Button("提货", { type: ButtonType.Capsule })
        .backgroundColor($r('app.color.primary'))
        .fontColor($r('app.color.white'))
        .height(50)
        .flexGrow(1)
        .margin({ left: 13 })
        .enabled(this.getPickUpEnabled())
        .onClick(() => {
          this.goPickUp()
        })
    }
    .width('100%')
    .padding({ left: 15, right: 15 })
    .height(70)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor($r('app.color.white'))
  }

  @Builder
  getListUI() {
    Column() {
      Scroll(this.scroller) {
        Column({ space: 16 }) {
          HxlToggleCard({ title: '基本信息', showCard: true }) {
            this.getBaseUI()
          }

          HxlToggleCard({ title: '车辆司机信息' }) {
            this.getDriverUI()
          }

          HxlToggleCard({ title: '运输路线' }) {
            this.getTransLineUI()
          }

          HxlToggleCard({ title: '提货信息', showCard: true }) {
            this.getTakeGoodsUI()
          }
        }
        .padding({ top: 16, bottom: 16 })
      }
    }
    .layoutWeight(1)
  }

  build() {
    Column() {
      HxlNavBar({ title: '任务详情' })

      if (!this.taskDetail.id) {
        HxlSkeleton({ count: 4, showAvatar: false })
      }

      this.getListUI()

      this.getBottomBtnUI()
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