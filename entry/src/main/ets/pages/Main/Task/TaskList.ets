import { formatDateTime, HxlList, HxlLoading } from '@hxl/basic/Index'

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
  @State
  resetSearchTime: boolean = false
  loading: CustomDialogController = new CustomDialogController({
    builder: HxlLoading(),
    customStyle: true,
  })

  async getTaskList(isAppend?: boolean) {
    const result = await getTaskList(this.queryParams)
    const list = isAppend ? this.taskList : []
    this.taskList = list.concat(result.items)
    this.queryParams.page++
    this.pageTotal = result.pages
  }

  getSearchBtnEnable() {
    return !!(this.queryParams.startTime && this.queryParams.endTime)
  }

  selectTime(key: 'startTime' | 'endTime') {
    DatePickerDialog.show({
      showTime: false,
      onDateAccept: (value) => {
        if (key === 'startTime') {
          this.queryParams.startTime = formatDateTime(value, 'yyyy-MM-dd')
        }
        else if (key === 'endTime') {
          this.queryParams.endTime = formatDateTime(value, 'yyyy-MM-dd')
        }
        this.resetSearchTime = false
      }
    })
  }

  async onSearch(value: string) {
    this.resetSearchTime = false
    if (!value) {
      this.getSearchList()
      return
    }
    this.queryParams.startTime = ''
    this.queryParams.endTime = ''
    this.getSearchList()
  }

  async getSearchList(setReset?: boolean) {
    try {
      if (this.resetSearchTime) {
        this.queryParams.startTime = ''
        this.queryParams.endTime = ''
      }
      if (setReset) {
        this.resetSearchTime = !this.resetSearchTime
      }
      this.pageTotal = 1
      this.queryParams.page = 1
      this.loading.open()
      await this.getTaskList()
    }
    finally {
      this.loading.close()
    }
  }

  @Builder
  getSearchForm() {
    Column() {
      Row() {
        Search({ placeholder: '请输入任务编号', value: this.queryParams.transportTaskId || '' })
          .backgroundColor($r('app.color.background_page'))
          .height(32)
          .onSubmit((value) => this.onSearch(value)) // Todo: 待测试
        // .onClick(() => {
        //   // Todo: 模似onSubmit
        //   this.queryParams.transportTaskId = '4061815043250358556'
        //   this.onSearch(this.queryParams.transportTaskId)
        // })
      }.justifyContent(FlexAlign.Center).width('100%').padding({ bottom: 5 })

      Row() {
        // 完成搜索页需要测试点击之后键盘和弹层同时弹出的情况
        Button(this.queryParams.startTime || '开始时间').getSearchBtnStyle()
          .onClick(() => this.selectTime('startTime'))
        Text("至")
        Button(this.queryParams.endTime || '结束时间').getSearchBtnStyle()
          .onClick(() => this.selectTime('endTime'))
        Button(this.resetSearchTime ? '重置' : '筛选')
          .height(32)
          .width(60)
          .backgroundColor(this.resetSearchTime ? $r('app.color.warning') : $r('app.color.primary'))
          .enabled(this.getSearchBtnEnable())
          .onClick(() => {
            this.getSearchList(true)
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .backgroundColor($r('app.color.white'))
    .padding(16)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .border({ width: { bottom: 1 }, color: $r('app.color.background_divider') })
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
      Column() {
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
      }.layoutWeight(1)
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