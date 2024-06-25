import { router } from '@kit.ArkUI'
import { HxlNavBar, HxlToggleCard, RouterParams } from '@hxl/basic/Index'

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

  @Builder
  getListUI() {
    Scroll() {
      Column({ space: 16 }) {
        ForEach([1, 2, 3, 4], (item: number) => {
          HxlToggleCard() {
            Text(JSON.stringify(this.taskDetail))
          }
        })
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