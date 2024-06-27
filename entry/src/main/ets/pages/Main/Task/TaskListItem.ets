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
  getBtnUI() {
    Row() {
      Column() {
        Text('提货时间').fontSize(14).fontColor($r('app.color.text_secondary'))
        Text(this.item?.planArrivalTime || '').fontSize(14).fontColor($r('app.color.text_secondary')).margin({ top: 4 })
      }.alignItems(HorizontalAlign.Start)

      Button(this.getBtnText(), { type: ButtonType.Capsule })
        .backgroundColor($r('app.color.primary'))
        .fontColor($r("app.color.white"))
        .fontSize(14)
        .height(32)
        .enabled(this.getBtnEnabled())
        .onClick(() => {
          router.pushUrl({
            url: 'pages/TaskDetail/TaskDetail',
            params: {
              id: this.item?.id
            }
          })
        })

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

  }
}

export default TaskListItem
