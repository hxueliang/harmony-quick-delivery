import { router } from '@kit.ArkUI'

import { TaskStatusEnum } from '../../../constants'
import { TaskListDataItem } from '../../../models'

@Preview
@Component
struct TaskListItem {
  @Prop
  item: Partial<TaskListDataItem> = {}
  btnTextMap: Record<TaskStatusEnum, string> = {} as Record<TaskStatusEnum, string>

  aboutToAppear(): void {
    this.setBtnTextMap()
  }

  setBtnTextMap() {
    this.btnTextMap[TaskStatusEnum.WAITING] = '提货'
    this.btnTextMap[TaskStatusEnum.LINE] = '交货'
    this.btnTextMap[TaskStatusEnum.DELIVERED] = '回车登记'
  }

  getBtnText() {
    return this.btnTextMap[Number(this.item?.status) as TaskStatusEnum]
  }

  getBtnEnabled() {
    const status = Number(this.item?.status) as TaskStatusEnum
    return (status === TaskStatusEnum.WAITING) && this.item?.enablePickUp ||
      status === TaskStatusEnum.LINE ||
      status === TaskStatusEnum.DELIVERED
  }

  goTaskDetail() {
    router.pushUrl({
      url: 'pages/TaskDetail/TaskDetail',
      params: {
        id: this.item?.id
      }
    })
  }

  @Builder
  getTaskIdUI() {
    Row() {
      Text(`任务编号：${this.item?.id || ''}`)
        .fontSize(16)
        .fontColor($r("app.color.text_primary"))
        .fontWeight(500)
        .lineHeight(22)
    }.justifyContent(FlexAlign.SpaceBetween).width('100%')
  }

  @Builder
  getAddressUI(type: 'start' | 'end', address: string) {
    Row() {
      Text(type === 'start' ? '起' : '止')
        .fontSize(12)
        .fontColor($r("app.color.white"))
        .backgroundColor(type === 'start' ? $r("app.color.text_primary") : $r('app.color.primary'))
        .width(22)
        .height(22)
        .borderRadius(11)
        .textAlign(TextAlign.Center)
      Text(address)
        .margin({ left: 11.5 })
        .fontColor($r('app.color.text_secondary'))
        .fontSize(14)
    }.margin({ top: 21 }).width('100%')
  }

  @Builder
  getDividerUI() {
    Divider()
      .vertical(true)
      .height(2)
      .color($r('app.color.background_divider'))
      .opacity(0.6)
      .margin({ left: 8, right: 8, top: 21 })
  }

  @Builder
  getDirectionUI() {
    Text('提货时间').fontSize(14).fontColor($r('app.color.text_secondary'))
    Text(this.item?.planArrivalTime || '').fontSize(14).fontColor($r('app.color.text_secondary'))
  }

  @Builder
  getBtnUI() {
    Row() {
      if (parseInt(this.item.status!) === TaskStatusEnum.FINISH) {
        Row({ space: 10 }) {
          this.getDirectionUI()
        }
      } else {
        Column({ space: 4 }) {
          this.getDirectionUI()
        }.alignItems(HorizontalAlign.Start)
      }


      if (parseInt(this.item.status!) !== TaskStatusEnum.FINISH) {
        Button(this.getBtnText(), { type: ButtonType.Capsule })
          .backgroundColor($r('app.color.primary'))
          .fontColor($r("app.color.white"))
          .fontSize(14)
          .height(32)
          .enabled(this.getBtnEnabled())
          .onClick(() => {
            this.goTaskDetail()
          })
      }

    }.justifyContent(FlexAlign.SpaceBetween).width('100%')
  }

  build() {
    Column() {
      this.getTaskIdUI()

      this.getAddressUI('start', this.item?.startAddress || '')

      this.getAddressUI('end', this.item?.endAddress || '')

      this.getDividerUI()

      this.getBtnUI()
    }
    .margin({ left: 15, right: 15, top: 15 })
    .padding({ left: 19.5, right: 19.5, bottom: 18.5, top: 18.5 })
    .borderRadius(10)
    .backgroundColor($r('app.color.white'))
    .onClick(() => {
      if (parseInt(this.item.status!) !== TaskStatusEnum.FINISH) {
        return
      }
      this.goTaskDetail()
    })
  }
}

export default TaskListItem
