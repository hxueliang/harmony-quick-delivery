import { fileIo, picker } from '@kit.CoreFileKit'

import { HxlPreview } from '.'
import { ImageList } from '../models'
import { util } from '@kit.ArkTS'
import { request } from '@kit.BasicServicesKit'
import { uploadImage } from '../apis'

/** 图片宽/高 */
const IMAGE_WIDTH = 100
/** 行间隔高 */
const ROWS_GAP = 10
/** 阴影高 */
const SHADOW_RADIUS = 6

@Preview
@Component
export struct HxlUpload {
  @Prop
  imageList: ImageList[] = []
  title: string = ''
  maxNumber: number = 3
  currentIndex: number = 0
  preview: CustomDialogController = new CustomDialogController({
    builder: HxlPreview({
      urls: this.imageList.map(item => item.url),
      index: this.currentIndex
    }),
    customStyle: true,
  })
  onListChange: (list: ImageList[]) => void = () => {
  }

  async selectImage() {
    const photo = new picker.PhotoViewPicker()
    const result = await photo.select({
      MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber: this.maxNumber - this.imageList.length, // 分多次选择要减去之前以选的数量
    })
    this.imageList = this.imageList.concat(result.photoUris.map(url => ({ url } as ImageList)))
    this.onListChange(this.imageList)
  }

  getGridHeight() {
    let basicsNum = this.maxNumber
    if (this.imageList.length < this.maxNumber) {
      basicsNum = this.imageList.length + 1 // 加1表示：加上"+号图片"来算grid的高度
    }
    const lineHeight = IMAGE_WIDTH + ROWS_GAP
    return Math.ceil(basicsNum / 3) * lineHeight
  }

  @Builder
  getAddImageUI() {
    Grid() {
      ForEach(this.imageList, (item: ImageList, index: number) => {
        GridItem() {
          Row() {
            Stack({ alignContent: Alignment.TopEnd }) {
              Image(item.url)
                .width(IMAGE_WIDTH - SHADOW_RADIUS)
                .aspectRatio(1)
                .borderRadius(4)
                .shadow({ radius: SHADOW_RADIUS, color: $r('app.color.text_secondary') })
                .onClick(() => {
                  this.currentIndex = index
                  this.preview.open()
                })
              Image($r('app.media.ic_btn_delete'))
                .width(30)
                .aspectRatio(1)
                .onClick(() => {
                  this.imageList.splice(index, 1)
                  this.onListChange(this.imageList)
                })
            }
          }
          .getImageRowStyle()
        }
      })
      if (this.imageList.length < this.maxNumber) {
        GridItem() {
          Row() {
            Image($r('app.media.ic_add_img')).width(30).aspectRatio(1)
          }
          .getImageRowStyle()
          .backgroundColor($r('app.color.background_page'))
          .onClick(() => {
            this.selectImage()
          })
        }
      }
    }
    .height(this.getGridHeight())
    .columnsTemplate('1fr 1fr 1fr')
    .columnsGap(ROWS_GAP)
    .rowsGap(ROWS_GAP)
  }

  build() {
    Column() {
      Text(this.title)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .margin({ bottom: 16, top: 4 })

      this.getAddImageUI()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Extend(Row)
function getImageRowStyle() {
  .width(IMAGE_WIDTH)
  .aspectRatio(1)
  .borderRadius(4)
  .justifyContent(FlexAlign.Center)
}

export const UploadFile = async (list: ImageList[]) => {
  const cacheDir = getContext().cacheDir
  const filesParamsList: request.File[] = []
  list.forEach(item => {
    const file = fileIo.openSync(item.url, fileIo.OpenMode.READ_ONLY) // 手机相册中的图片
    const extendName = item.url.split('.')[1]
    const fileName = util.generateRandomUUID() + '.' + extendName
    const path = cacheDir + '/' + fileName
    fileIo.copyFileSync(file.fd, path)
    filesParamsList.push({
      filename: fileName,
      name: 'file', // 上传接口字段名
      uri: 'internal://cache/' + fileName,
      type: extendName,
    })
    fileIo.close(file.fd) // 释放资源
  })
  return await uploadImage(getContext(), filesParamsList)
}