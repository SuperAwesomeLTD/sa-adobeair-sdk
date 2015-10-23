package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import tv.superawesome.SuperAwesome;
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
		private var iad: SAInterstitialAd;
		
		[SWF(backgroundColor="0xffffff")]
		public function SuperAwesome_iOSDemo()
		{
			super();
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true)
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			SuperAwesome.getInstance().disableTestMode();
			
			SALoader.getInstance().preloadAdForPlacementId(24541);
			SALoader.getInstance().delegate = this;
			
			iad = new SAInterstitialAd();
			
//			vad = new SAVideoAd(new Rectangle(0, 0, 320, 270), 24532);
//			vad.playInstant();
//			addChild(vad);
			
			bad = new SABannerAd(new Rectangle(0, 270, 320, 50), 19311);
			bad.playInstant();
			addChild(bad);
		}
		
		public function didPreloadAd(ad: SAAd, placementId:int): void {
			iad.setAd(ad);
			addChild(iad);
			iad.playPreloaded();
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