package
{	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.system.Capabilities;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Loader.SALoaderProtocol;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Views.SABannerAd;
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAVideoAd;
	
	public class SuperAwesome_iOSDemo extends Sprite implements SALoaderProtocol
	{
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
			SuperAwesome.getInstance().setConfigurationProduction();
			
			SALoader.getInstance().delegate = this;
			SALoader.getInstance().loadAd(10278);
//			SALoader.getInstance().loadAd(21245);
//			SALoader.getInstance().loadAd(10277);
//			SALoader.getInstance().loadAd(10324);
		}
		
		public function didLoadAd(ad: SAAd): void {
//			ad.print();
			
//			if (ad.placementId == 10278) {
//				var b:SABannerAd = new SABannerAd(new Rectangle(50,290,300,250));
//				b.setAd(ad);
//				addChild(b);
//				b.play();
//			} else 
//				if (ad.placementId == 21245) {
//				var v:SAVideoAd = new SAVideoAd(new Rectangle(0, 50, 320, 240));
//				v.setAd(ad);
//				addChild(v);
//				v.play();
//			} 
//				else if (ad.placementId == 10277) {
//				var b2: SABannerAd = new SABannerAd(new Rectangle(25, 600, 320, 50));
//				b2.setAd(ad);
//				addChild(b2);
//				b2.play();
//			} else 
			if (ad.placementId == 10278) {
				var i1:SAInterstitialAd = new SAInterstitialAd();
				i1.setAd(ad);
				addChild(i1);
				i1.play();
			}
		}
		
		public function didFailToLoadAdForPlacementId(placementId:int): void {
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