package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Loader.SALoaderProtocol;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Views.SABannerAd;
	import tv.superawesome.Views.SAVideoAd;
	import tv.superawesome.Views.SAInterstitialAd;
	
	public class SuperAwesome_iOSDemo extends Sprite implements SALoaderProtocol
	{
		private var bad: SABannerAd;
		private var vad: SAVideoAd;
		
		[SWF(backgroundColor="0xffffff")]
		public function SuperAwesome_iOSDemo()
		{
			super();
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true)
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			SALoader.getInstance().preloadAdForPlacementId(21863);
			SALoader.getInstance().preloadAdForPlacementId(21022);
			SALoader.getInstance().delegate = this;
			
			bad = new SABannerAd(new Rectangle(0, 0, 320, 100));
			vad = new SAVideoAd(new Rectangle(0, 100, 480, 320), 21022);
		}
		
		public function didPreloadAd(ad: SAAd, placementId:int): void {
			trace("loaded " + placementId);
			if (placementId == 21863) {
				bad.setAd(ad);
				addChild(bad);
				bad.playPreloaded();
			}
			else if (placementId == 21022) {
				vad.setAd(ad);
				addChild(vad);
				vad.playPreloaded();
			}
		}
		
		public function didFailToPreloadAdForPlacementId(placementId:int): void {
			trace("did fail to load " + placementId);
		}
		
		private function handleActivate(event:Event):void {
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(event:Event):void {
			// NativeApplication.nativeApplication.exit();
		}
	}
}