import { MapComponent } from '@hms.core.map.MapComponent'
import { HxlCard, HxlCardItem, HxlNavBar } from '@hxl/basic/Index'

@Entry
@Component
struct SelectLocation {
  build() {
    Column() {
      HxlNavBar({ title: '当前位置' })
      Stack({ alignContent: Alignment.Bottom }) {
        // 地图区域
        MapComponent({
          mapOptions: {
            position: {
              target: {
                latitude: 39.9,
                longitude: 116.4
              },
              zoom: 10
            }
          },
          mapCallback: () => {
          }
        }).width('100%').height('100%')

        Column() {
          HxlCard() {
            HxlCardItem({ label: '回龙观街道', value: '100m以内' })
            HxlCardItem({ label: '金燕龙科研楼', value: '100m以内' })
            HxlCardItem({ label: '春野画室', value: '100m以内' })
            HxlCardItem({ label: '光滑时代(金艳龙科研楼店)', value: '100m以内' })
          }
        }.padding({ bottom: 60 })
      }
    }
    .height('100%').backgroundColor($r('app.color.background_page'))
  }
}