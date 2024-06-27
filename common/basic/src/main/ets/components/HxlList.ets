import { promptAction } from '@kit.ArkUI'

@Component
export struct HxlList {
  @State
  refreshStatus: RefreshStatus = RefreshStatus.Inactive
  @State
  refreshing: boolean = false
  @State
  loading: boolean = false
  @Prop
  finished: boolean = false
  @Prop
  list: object[] = []
  @Prop
  loadingText: string = '加载中...'
  @Prop
  finishedText: string = '没有更多数据了~'
  @BuilderParam
  renderer: (item: object) => void
  onLoad: () => void = () => {
  }
  onRefresh: () => void = () => {
  }
  scroller: Scroller = new Scroller()
  refreshStatusMap: Record<RefreshStatus, string> = {}

  aboutToAppear(): void {
    this.setRefreshStatusMap()
  }

  setRefreshStatusMap() {
    this.refreshStatusMap[RefreshStatus.Drag] = '继续下拉'
    this.refreshStatusMap[RefreshStatus.OverDrag] = '松手加载'
    this.refreshStatusMap[RefreshStatus.Refresh] = '加载中'
  }

  @Builder
  getLastItemUI() {
    Row({ space: 10 }) {
      if (this.finished) {
        Text(this.finishedText)
      } else if (this.loading) {
        Text(this.loadingText)
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
      }
    }
    .width('100%')
    .padding({ top: 10, bottom: 20 })
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  getRefreshUI() {
    Row({ space: 5 }) {
      Text(this.refreshStatusMap[this.refreshStatus] || '')
      if (this.refreshStatus === RefreshStatus.Refresh) {
        LoadingProgress()
          .width(20)
          .aspectRatio(1)
          .color($r('app.color.primary'))
      }
    }
  }

  build() {
    Refresh({ refreshing: $$this.refreshing, builder: this.getRefreshUI }) {
      List({ space: 10, scroller: this.scroller }) {
        // 因为this.list是由业务组件传入的
        // 而业务组件的传入的list大概率是接口返回的
        // 接口返回的数据有可能不是数组类型
        // 目前面发现在途列表为空时，接口没返回空数组，而返回null倒导致应用直接死掉
        // 此处增加 数组效验 和 非空交验
        if (Array.isArray(this.list)) {
          ForEach(this.list, (item: object) => {
            if (item) {
              ListItem() {
                this.renderer(item)
              }
            }
          })
        }
        ListItem() {
          this.getLastItemUI()
        }
      }
      .onReachEnd(() => {
        if (this.loading || this.finished) {
          return
        }
        this.loading = true
        this.scroller.scrollEdge(Edge.Bottom) // 解决超慢速划到底部loading没显示
        setTimeout(async () => {
          await this.onLoad()
          this.loading = false
        }, 500)
      })
    }
    .height('100%')
    // .onRefreshing(() => { promptAction.showToast({ message: 'onRefreshing' }) })
    .onStateChange(async state => {
      this.refreshStatus = state
      if (state !== RefreshStatus.Refresh) {
        return
      }
      await this.onRefresh()
      this.refreshing = false
      this.loading = false
    })
  }
}