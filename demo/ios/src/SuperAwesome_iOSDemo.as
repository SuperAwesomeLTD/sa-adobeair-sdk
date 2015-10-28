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
		
		[SWF(backgroundColor="0xff0000")]
		public function SuperAwesome_iOSDemo()
		{
			super();
			
			// setup stage and native app attributes
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true)
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// setup SA SDK
			SuperAwesome.getInstance().disableTestMode();
			
			SALoader.getInstance().preloadAdForPlacementId(24541);
			SALoader.getInstance().delegate = this;
			
			bad = new SABannerAd(new Rectangle(0, 0, 640, 100), 19311);
			SuperAwesome.getInstance().enableTestMode();
			bad.playInstant();
			addChild(bad);
			
			vad = new SAVideoAd(new Rectangle(0, 250, 640, 480), 24532);
			SuperAwesome.getInstance().disableTestMode();
			vad.playInstant();
			addChild(vad);
		}
		
		public function didPreloadAd(ad: SAAd, placementId:int): void {
			// do nothing
		}
		
		public function didFailToPreloadAdForPlacementId(placementId:int): void {
			trace("did fail to load " + placementId);
		}
		
		private function handleActivate(event:Event):void {
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(event:Event):void {
			// do nothing
		}
	}
}