package
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import tv.superawesome.SAAd;
	import tv.superawesome.SABannerAd;
	import tv.superawesome.SAFullscreenVideoAd;
	import tv.superawesome.SAInterstitialAd;
	import tv.superawesome.SALoader;
	import tv.superawesome.SAVideoAd;
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.interfaces.SAAdInterface;
	import tv.superawesome.interfaces.SALoaderInterface;
	import tv.superawesome.interfaces.SAParentalGateInterface;
	import tv.superawesome.interfaces.SAVideoAdInterface;
	
	public class AndroidDemo extends Sprite implements SALoaderInterface, SAAdInterface, SAVideoAdInterface, SAParentalGateInterface {
		
		private var loader:SALoader = new SALoader();
		private var fvad:SAFullscreenVideoAd;
		private var iad:SAInterstitialAd;
		private var bad:SABannerAd;
		private var vad:SAVideoAd;
		
		public function AndroidDemo() {
			super();
			
			/** support autoOrients */
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			/** setup the demo */
			SuperAwesome.getInstance().setConfigurationProduction();
			SuperAwesome.getInstance().enableTestMode();
			
			loader.delegate = this;
			loader.loadAd(28000);
			loader.loadAd(30471);
			loader.loadAd(10305);
		}
		
		public function didLoadAd(ad: SAAd): void {
			trace(ad.placementId);
			trace(ad.adJson);
			
			if (ad.placementId == 10305) {
				trace("will call inter for 10305");
				iad = new SAInterstitialAd();
				iad.setAd(ad);
				iad.play();
			} else if (ad.placementId == 30471) {
				trace("will call inter for 30471");
				bad = new SABannerAd(new Rectangle(250, 450, 640, 100));
				bad.setAd(ad);
				bad.play();
			} else if (ad.placementId == 28000) {
				trace("will call inter for 28000");
				fvad = new SAFullscreenVideoAd();
				fvad.setAd(ad);
				fvad.shouldShowCloseButton = true;
				fvad.shouldAutomaticallyCloseAtEnd = true;
				fvad.play();
				
				vad = new SAVideoAd(new Rectangle(0, 50, 640, 400));
				vad.setAd(ad);
				vad.play();
			}
		}
		
		public function didFailToLoadAd(placementId: int): void {
			trace("failed to load " + placementId);
		}
		
		public function adWasShown(placementId: int): void {
			trace("adWasShown " + placementId);
		}
		
		public function adFailedToShow(placementId: int): void {
			trace("adFailedToShow " + placementId);
		}
		
		public function adWasClosed(placementId: int): void {
			trace("adWasClosed " + placementId);
		}
		
		public function adWasClicked(placementId: int): void {
			trace("adWasClicked " + placementId);
		}
		
		public function adHasIncorrectPlacement(placementId: int): void {
			trace("adHasIncorrectPlacement " + placementId);
		}
		
		public function adStarted(placementId: int): void {
			trace("adStarted " + placementId);
		}
		
		public function videoStarted(placementId: int): void {
			trace("videoStarted " + placementId);
		}
		
		public function videoReachedFirstQuartile(placementId: int): void {
			trace("videoReachedFirstQuartile " + placementId);
		}
		
		public function videoReachedMidpoint(placementId: int): void {
			trace("videoReachedMidpoint " + placementId);
		}
		
		public function videoReachedThirdQuartile(placementId: int): void {
			trace("videoReachedThirdQuartile " + placementId);
		}
		
		public function videoEnded(placementId: int): void {
			trace("videoEnded " + placementId);
		}
		
		public function adEnded(placementId: int): void {
			trace("adEnded " + placementId);
		}
		
		public function allAdsEnded(placementId: int): void {
			trace("allAdsEnded " + placementId);
		}
		
		public function parentalGateWasCanceled(placementId: int): void {
			trace("parentalGateWasCanceled" + placementId);
		}
		
		public function parentalGateWasFailed(placementId: int): void {
			trace("parentalGateWasFailed" + placementId);
		}
		
		public function parentalGateWasSucceded(placementId: int): void {
			trace("parentalGateWasSucceded" + placementId);
		}
	}
}