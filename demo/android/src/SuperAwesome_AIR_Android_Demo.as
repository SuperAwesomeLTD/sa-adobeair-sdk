package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Loader.SALoaderProtocol;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.System.SASystem;
	import tv.superawesome.Views.SABannerAd;
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAVideoAd;
	import tv.superawesome.Views.Protocols.SAAdProtocol;
	import tv.superawesome.Views.Protocols.SAVideoAdProtocol;
	
	public class SuperAwesome_AIR_Android_Demo extends Sprite implements SALoaderProtocol, SAAdProtocol, SAVideoAdProtocol
	{
		public function SuperAwesome_AIR_Android_Demo()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			trace(SuperAwesome.getInstance().getSdkVersion());
			trace(SASystem.getSystemType() + "_" + SASystem.getSystemSize());
			
			SuperAwesome.getInstance().disableTestMode();
			SuperAwesome.getInstance().setConfigurationProduction();
			
			SALoader.getInstance().delegate = this;
			SALoader.getInstance().loadAd(10324);
			SALoader.getInstance().loadAd(28000);
		}
		
		public function didLoadAd(ad: SAAd): void {
//			var iad:SAInterstitialAd = new SAInterstitialAd();
//			iad.setAd(ad);
//			iad.adDelegate = this;
//			addChild(iad);
//			iad.play();
			var vad:SAVideoAd = new SAVideoAd(new Rectangle(0, 40, 640, 480));
			vad.setAd(ad);
			vad.adDelegate = this;
			vad.videoDelegate = this;
			addChild(vad);
			vad.play();
			
//			var bad:SABannerAd = new SABannerAd(new Rectangle(0, 0, 700, 500));
//			bad.setAd(ad);
//			addChild(bad);
//			bad.play();
		}
		
		public function didFailToLoadAdForPlacementId(placementId: int): void {
			trace("empty");
		}
		
		public function adWasShown(placementId: int): void {
			trace(placementId + " adWasShown");
		}
		
		public function adFailedToShow(placementId: int): void {
			trace(placementId + " adFailedToShow");
		}
		
		public function adWasClosed(placementId: int): void {
			trace(placementId + " adWasClosed");	
		}
		
		public function adWasClicked(placementId: int): void {
			trace(placementId + " adWasClicked");	
		}
		
		public function adHasIncorrectPlacement(placementId: int): void {
			trace(placementId + " adHasIncorrectPlacement");
		}
		
		public function videoStarted(placementId: int): void {
			trace(placementId + " videoStarted");
		}
		
		public function videoReachedFirstQuartile(placementId:int): void {
			trace(placementId + " videoReachedFirstQuartile");
		}
		
		public function videoReachedMidpoint(placementId:int): void {
			trace(placementId + " videoReachedMidpoint");
		}
		
		public function videoReachedThirdQuartile(placementId: int): void {
			trace(placementId + " videoReachedThirdQuartile");
		}
		
		public function videoEnded(placementId:int): void {
			trace(placementId + " videoEnded");
		}
	}
}