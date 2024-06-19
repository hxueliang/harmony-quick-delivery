import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AdStore, getStartAd, OPEN_SUB_WINDOW_KEY, UserInfoStore, USER_TOKEN_KEY } from '@hxl/basic/Index';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    await showStartAd(windowStage, this.context)

    windowStage.loadContent(await getLoadUrl(this.context), (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

async function showStartAd(windowStage: window.WindowStage, ctx: Context) {
  const adStore = new AdStore(ctx)
  const ad = await getStartAd()
  await adStore.setStartAd(ad) // 写入首选项
  const win = await windowStage.createSubWindow(OPEN_SUB_WINDOW_KEY)
  await win.showWindow()
  win.setUIContent('pages/StartAd/StartAd')
}

/**
 * 获取加载的页面url
 * @param cxt
 * @returns
 */
async function getLoadUrl(cxt: Context) {
  let url = 'pages/Login/Login'
  const userInfoStore = new UserInfoStore(cxt)
  const token = userInfoStore.getToken()
  if(token) {
    AppStorage.setOrCreate(USER_TOKEN_KEY, token)
    url='pages/Index'
  }
  return url
}
