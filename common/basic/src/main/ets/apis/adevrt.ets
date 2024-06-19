import { DEFAULT_AD } from '../constants'
import { AdvertModel } from '../models'

export function getStartAd() {
  return new Promise<AdvertModel>((resolve, reject) => {
    DEFAULT_AD.adTime = 2
    setTimeout(() => {
      resolve(DEFAULT_AD)
    }, 500)
  })
}