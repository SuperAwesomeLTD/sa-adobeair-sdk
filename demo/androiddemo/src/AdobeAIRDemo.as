package
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import tv.superawesome.SAAd;
	import tv.superawesome.SABannerAd;
	import tv.superawesome.SAFullscreenVideoAd;
	import tv.superawesome.SAInterstitialAd;
	import tv.superawesome.SALoader;
	import tv.superawesome.SALockOrientation;
	import tv.superawesome.SAVideoAd;
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.interfaces.SAAdInterface;
	import tv.superawesome.interfaces.SALoaderInterface;
	import tv.superawesome.interfaces.SAParentalGateInterface;
	import tv.superawesome.interfaces.SAVideoAdInterface;
	
	public class AdobeAIRDemo extends Sprite implements SALoaderInterface, SAAdInterface, SAVideoAdInterface, SAParentalGateInterface {
		
//		private var loader:SALoader = new SALoader();
		private var fvad:SAFullscreenVideoAd;
		// private var iad:SAInterstitialAd;
		private var bad:SABannerAd;
		private var vad:SAVideoAd;
		
		public function AdobeAIRDemo() {
			super();
			
			/** support autoOrients */
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			/** setup the demo */
			SuperAwesome.getInstance().setConfigurationProduction();
			SuperAwesome.getInstance().disableTestMode();
			
			var loader:SALoader = new SALoader();
			loader.delegate = this;
			loader.loadAd(24541);
			var loader2:SALoader = new SALoader ();
			loader2.delegate = this;
			loader2.loadAd(28000);
			
			var color1:uint = 0xff0000;
			
			var playBanner:Sprite = new Sprite ();
			playBanner.graphics.beginFill(color1, 1);
			playBanner.graphics.drawRect(0, 0, 200, 150);
			playBanner.graphics.endFill();
			addChild(playBanner);
			playBanner.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
				loader.loadAd(24541);
			});
		}
		
		public function didLoadAd(ad: SAAd): void {
			trace(ad.placementId);
			trace(ad.adJson);
			
			if (ad.placementId == 24541) {
				var iad: SAInterstitialAd = new SAInterstitialAd();
				iad.setAd(ad);
				iad.adDelegate = this;
				iad.play();
				iad = null;
			} else if (ad.placementId == 28000) {
				// abc
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