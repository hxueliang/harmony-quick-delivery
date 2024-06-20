import { HxlCard, HxlCardItem } from '@hxl/basic/Index'
import { UserInfo, UserInfoModel } from '../../../models'
import { getUserInfo } from '../../../apis'

@Preview
@Component
struct My {
  @State
  userInfo: UserInfoModel = new UserInfoModel({} as UserInfo)

  aboutToAppear(): void {
    this.getUserInfo()
  }

  async getUserInfo() {
    this.userInfo = await getUserInfo()
  }

  @Builder
  getBaseInfoUI() {
    Column() {
      Image(this.userInfo.avatar)
        .width(67)
        .height(67)
        .borderRadius(34.5)
        .backgroundColor($r('app.color.white'))
      Text(this.userInfo.name || '')
        .fontSize(18)
        .fontWeight(600)
        .lineHeight(25)
        .margin({ top: 9, bottom: 9 })
        .fontColor($r('app.color.white'))
      Text(`司机编号: ${this.userInfo.number || ''}`)
        .fontSize(14)
        .fontWeight(400)
        .lineHeight(20)
        .fontColor($r('app.color.white'))
      Text(`手机号: ${this.userInfo.phone || ''}`)
        .fontSize(14)
        .fontWeight(400)
        .lineHeight(20)
        .margin({ top: 10 })
        .fontColor($r('app.color.white'))
    }
    .backgroundImage($r('app.media.bg_page_my'))
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .height(292)
    .margin({ top: -2 })
  }

  @Builder
  getMonthTaskUI() {
    Column() {
      Text('- 本月任务 -')
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .lineHeight(20)
      Row() {
        this.getTaskItemUI(1000, '任务总量')
        this.getTaskItemUI(1000, '完成任务量')
        this.getTaskItemUI(1000, '运输里程(km)')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .backgroundColor($r('app.color.white'))
    .borderRadius(8)
    .margin({ left: 14.5, right: 14.5, top: -55, bottom: 15 })
    .height(134)
    .padding({ top: 13.5, bottom: 13.5 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  getTaskItemUI(value: number, label: string) {
    Column() {
      Text(value?.toString() || '')
        .fontSize(18)
        .fontColor($r('app.color.text_primary'))
        .lineHeight(25)
        .margin({ bottom: 17 })
      Text(label)
        .fontSize(12)
        .fontColor($r('app.color.text_primary'))
        .lineHeight(17)
    }
    .justifyContent(FlexAlign.SpaceAround)
    .layoutWeight(1)
  }

  @Builder
  getInfoListUI() {
    HxlCard() {
      HxlCardItem({ label: '车辆信息' })
      HxlCardItem({ label: '任务数据' })
      HxlCardItem({
        label: '系统设置',
        showLine: false,
        onClink: () => {
        }
      })
    }
  }

  build() {
    Column() {
      // 基本信息
      this.getBaseInfoUI()

      // 本月任务
      this.getMonthTaskUI()

      // 信息列表
      this.getInfoListUI()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
    .borderRadius(8)
  }
}

export default My