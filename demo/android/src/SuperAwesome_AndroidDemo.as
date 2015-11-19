package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.system.Capabilities;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Loader.SALoaderProtocol;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Network.SANetwork;
	import tv.superawesome.Views.SAAdProtocol;
	import tv.superawesome.Views.SABannerAd;
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAVideoAd;
	
	[SWF(backgroundColor="0xffffff")]
	public class SuperAwesome_AndroidDemo extends Sprite implements SALoaderProtocol
	{
		private var b:SABannerAd;
		private var v:SAVideoAd;
		private var b2:SABannerAd;
		private var i1:SAInterstitialAd;
		
		public function SuperAwesome_AndroidDemo()
		{
			super();
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true)
				
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			SuperAwesome.getInstance().setConfigurationProduction();
			SuperAwesome.getInstance().disableTestMode();
//			
			SALoader.getInstance().delegate = this;
			SALoader.getInstance().loadAd(10278);
//			SALoader.getInstance().loadAd(21245);
//			SALoader.getInstance().loadAd(10277);
//			SALoader.getInstance().loadAd(10324);
		}
		
		private function completeLoading(event: Event): void {
			trace("finished loading");
		}
		
		public function didLoadAd(ad: SAAd): void {

			ad.print();
//			if (ad.placementId == 10278) {
//				b = new SABannerAd(new Rectangle(100,550,600,500));
//				b.setAd(ad);
//				addChild(b);
//				b.play();
//			} 
//			else if (ad.placementId == 21245) {
//				trace("in ad 21245");
//				v = new SAVideoAd(new Rectangle(0, 0, 640, 480));
//				v.setAd(ad);
//				addChild(v);
//				v.play();
//			} 
//			else if (ad.placementId == 10277) {
//				trace("in ad 10277");
//				b2 = new SABannerAd(new Rectangle(50, 1050, 640, 100));
//				b2.setAd(ad);
//				addChild(b2);
//				b2.play();
//			} 
//			else 
				if (ad.placementId == 10278) {
				var i1: SAInterstitialAd = new SAInterstitialAd();
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
			// NativeApplication.nativeApplication.exit();
		}
		
//		public function adWasShown(placementId: int): void {
//			trace("Ad was shown");
//		}
//		public function adFailedToShow(placementId: int): void {
//			
//		}
//		public function adWasClosed(placementId: int): void {
//			
//		}
//		public function adFollowedURL(placementId: int): void {
//			
//		}
	}
}