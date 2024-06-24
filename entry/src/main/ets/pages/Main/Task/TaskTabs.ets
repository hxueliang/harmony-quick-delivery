import { TabModel } from '@hxl/basic/Index'

import { TaskList } from '.'

@Preview
@Component
struct TaskTabs {
  @State
  currentIndex: number = 0
  tabsData: TabModel[] = [{
    name: 'waiting',
    title: '待提货'
  }, {
    name: 'line',
    title: '在途'
  }, {
    name: 'finish',
    title: '已完成'
  }]

  @Builder
  getTabUI() {
    Tabs({ index: $$this.currentIndex }) {
      ForEach(this.tabsData, (item: TabModel) => {
        TabContent() {
          if (item.name === this.tabsData[0].name) {
            TaskList()
          } else if (item.name === this.tabsData[1].name) {

          } else if (item.name === this.tabsData[2].name) {

          }
        }.tabBar(item.title)
      })
    }
  }

  /**
   * 覆盖tabs组件的默认tabBar样式
   */
  @Builder
  getTabBarUI() {
    Row() {
      ForEach(this.tabsData, (item: TabModel, index: number) => {
        Column({ space: 5 }) {
          Text(item.title)
            .fontColor(index === this.currentIndex ? $r('app.color.text_primary') : $r('app.color.text_secondary'))
            .fontWeight(index === this.currentIndex ? FontWeight.Bolder : FontWeight.Medium)
            .animation({ duration: 300 })
          Divider()
            .strokeWidth(4)
            .color(index === this.currentIndex ? $r('app.color.primary') : $r('app.color.text_secondary'))
            .width(24)
            .animation({ duration: 300 })
        }
        .margin({ left: 30 })
        .onClick(() => {
          this.currentIndex = index
        })
      })
    }
    .backgroundColor($r('app.color.white'))
    .height(44)
    .width('100%')
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      this.getTabUI()
      this.getTabBarUI()
    }
  }
}

export default TaskTabs