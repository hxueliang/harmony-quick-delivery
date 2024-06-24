import { router } from '@kit.ArkUI'
import { HxlNavBar, RouterParams } from '@hxl/basic/Index'

@Entry
@Component
struct TaskDetail {
  aboutToAppear(): void {
    const params = router.getParams() as RouterParams
    if (params?.id) {
      AlertDialog.show({ message: params.id.toString() })
    }
  }

  build() {
    Column() {
      HxlNavBar({ title: '任务详情' })
    }

    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}