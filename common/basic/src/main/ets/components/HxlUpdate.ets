import { picker } from '@kit.CoreFileKit'

@Preview
@Component
export struct HxlUpload {
  title: string = ''
  maxNumber: number = 3

  async selectImage() {
    const photo = new picker.PhotoViewPicker()
    const result = await photo.select({
      MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber: this.maxNumber,
    })
    AlertDialog.show({ message: JSON.stringify(result.photoUris) })
  }

  @Builder
  getAddBtnUI() {
    Row() {
      Image($r('app.media.ic_add_img'))
        .width(30)
        .aspectRatio(1)
    }
    .width(100)
    .aspectRatio(1)
    .borderRadius(4)
    .justifyContent(FlexAlign.Center)
    .margin({ bottom: 14 })
    .backgroundColor($r('app.color.background_page'))
    .onClick(() => {
      this.selectImage()
    })
  }

  build() {
    Column() {
      Text(this.title)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .margin({ bottom: 16, top: 4 })

      this.getAddBtnUI()
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}