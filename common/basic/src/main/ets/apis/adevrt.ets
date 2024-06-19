import { DEFAULT_AD } from '../constants'
import { AdvertModel } from '../models'

export function getStartAd() {
  return new Promise<AdvertModel>((resolve, reject) => {
    // DEFAULT_AD.adTime = 2
    const ad = JSON.parse(JSON.stringify(DEFAULT_AD) as string) as AdvertModel
    ad.adTime = 2
    setTimeout(() => {
      resolve(ad)
    }, 500)
  })
}