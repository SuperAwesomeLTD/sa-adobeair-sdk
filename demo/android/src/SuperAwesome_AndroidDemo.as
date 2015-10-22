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
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAVideoAd;
	
	[SWF(backgroundColor="0xffffff")]
	public class SuperAwesome_AndroidDemo extends Sprite implements SALoaderProtocol
	{
		private var vad: SAVideoAd;
		private var iad: SAInterstitialAd;
		
		public function SuperAwesome_AndroidDemo()
		{
			super();
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true)
				
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			SuperAwesome.getInstance().setConfigurationProduction();
			SuperAwesome.getInstance().enableTestMode();
			
//			SALoader.getInstance().preloadAdForPlacementId(24532);
//			SALoader.getInstance().delegate = this;
			
//			iad = new SAInterstitialAd(24541);
//			iad.playInstant();
//			addChild(iad);
			
//			vad = new SAVideoAd(new Rectangle(0, 0, 500, 350), 24532);
//			vad.playInstant();
//			addChild(vad);
		}
		
		public function didPreloadAd(ad: SAAd, placementId:int): void {
//			iad.setAd(ad);
//			iad.playPreloaded();
//			addChild(iad);
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