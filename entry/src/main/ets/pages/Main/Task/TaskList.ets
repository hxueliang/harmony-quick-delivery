import { HxlList } from '@hxl/basic/Index'

import { TaskListItem } from '.'
import { getTaskList } from '../../../apis'
import { TaskStatusEnum } from '../../../constants'
import { TaskListDataItemModel, TaskListParams, TaskListParamsModel } from '../../../models'

@Preview
@Component
struct TaskList {
  @State
  queryParams: TaskListParamsModel = new TaskListParamsModel({
    status: TaskStatusEnum.WAITING,
    page: 1,
    pageSize: 5,
  } as TaskListParams)
  @State
  taskList: TaskListDataItemModel[] = []
  @State
  pageTotal: number = 1

  async getTaskList(isAppend?: boolean) {
    const result = await getTaskList(this.queryParams)
    const list = isAppend ? this.taskList : []
    this.taskList = list.concat(result.items)
    this.queryParams.page++
    this.pageTotal = result.pages
  }

  @Builder
  getSearchForm() {
    Column() {
      Row() {
        Search({ placeholder: '请输入任务编号' }).backgroundColor($r('app.color.background_page')).height(32)
      }.justifyContent(FlexAlign.Center).width('100%').padding({ bottom: 5 })

      Row() {
        // 完成搜索页需要测试点击之后键盘和弹层同时弹出的情况
        Button('开始时间').getSearchBtnStyle()
        Text("至")
        Button('结束时间').getSearchBtnStyle()
        Button("筛选").height(32).width(60).backgroundColor($r('app.color.primary'))
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .backgroundColor($r('app.color.white'))
    .padding(16)
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }

  @Builder
  getItemUI(item: object) {
    TaskListItem({
      item: item as TaskListDataItemModel
    })
  }

  build() {
    Column() {
      if (this.queryParams.status === TaskStatusEnum.FINISH) {
        this.getSearchForm()
      }
      HxlList({
        list: this.taskList,
        finished: this.pageTotal < this.queryParams.page,
        loadingText: '努力加载中...',
        finishedText: '--我是有底线的--',
        renderer: (item: object) => {
          this.getItemUI(item)
        },
        onLoad: async () => {
          await this.getTaskList(true)
        },
        onRefresh: async () => {
          this.queryParams.page = 1
          await this.getTaskList()
        }
      })
    }
  }
}

@Extend(Button)
function getSearchBtnStyle() {
  .fontSize(14)
  .width(110)
  .height(32)
  .padding({ left: 0, right: 0 })
  .fontColor('#999')
  .backgroundColor($r('app.color.background_page'))
}

export default TaskList