package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import tv.superawesome.SABannerAd;
	import tv.superawesome.SAInterstitialAd;
	import tv.superawesome.SAVideoAd;
	import tv.superawesome.enums.SAEvent;
	
	public class AndroidDemo3 extends Sprite // implements SALoaderInterface, SAAdInterface, SAVideoAdInterface, SAParentalGateInterface
	{	
//		private var loader:SALoader = new SALoader();
//		private var fvad:SAFullscreenVideoAd;
//		private var iad:SAInterstitialAd;
//		private var bad:SABannerAd;
//		private var vad:SAVideoAd;
		
		public function AndroidDemo3()
		{
			super();
			
			SAInterstitialAd.setConfigurationStaging();
			SAInterstitialAd.load(247);
			SAInterstitialAd.setCallback(function(placement:int, evt: int): void {
				trace("SAInterstitialAd " + placement + " evt: " + evt);
			});
			
			SAVideoAd.setConfigurationStaging ();
			SAVideoAd.setCallback(function(placement:int, evt:int): void {
				trace("SAVideoAd " + placement + "|" + evt);
				if (evt == SAEvent.adLoaded) {
					trace("SAVideoAd " + placement + " ==> adLoaded");
				}
				if (evt == SAEvent.adFailedToLoad) {
					trace("SAVideoAd " + placement + " ==> adFailedToLoad");
				}
				if (evt == SAEvent.adShown) {
					trace("SAVideoAd " + placement + " ==> adShown");
				}
				if (evt == SAEvent.adFailedToShow) {
					trace("SAVideoAd " + placement + " ==> adFailedToShow");
				}
				if (evt == SAEvent.adClosed) {
					trace("SAVideoAd " + placement + " ==> adClosed");
				}
				if (evt == SAEvent.adClicked) {
					trace("SAVideoAd " + placement + " ==> adClicked");
				}
			});
			SAVideoAd.load(252);
			
			var banner : SABannerAd = new SABannerAd ();
			banner.setPositionTop();
			banner.setColorGray();
			banner.setConfigurationStaging();
			banner.setCallback(function(placement:int, evt:int): void {
				trace("SABannerAd " + placement + "|" + evt);
				if (evt == SAEvent.adLoaded) {
					trace("SABannerAd " + placement + " ==> adLoaded");
				}
				if (evt == SAEvent.adFailedToLoad) {
					trace("SABannerAd " + placement + " ==> adFailedToLoad");
				}
				if (evt == SAEvent.adShown) {
					trace("SABannerAd " + placement + " ==> adShown");
				}
				if (evt == SAEvent.adFailedToShow) {
					trace("SABannerAd " + placement + " ==> adFailedToShow");
				}
				if (evt == SAEvent.adClosed) {
					trace("SABannerAd " + placement + " ==> adClosed");
				}
				if (evt == SAEvent.adClicked) {
					trace("SABannerAd " + placement + " ==> adClicked");
				}
			});
			banner.load(113);
			
			var default_bg_color:uint = 0xff0000;
			
			var sprite:Sprite = new Sprite();
//			sprite.x = 100;
//			sprite.y = 200;
//			sprite.width = 500;
//			sprite.height = 250;
			sprite.graphics.beginFill(default_bg_color, 1);
			sprite.graphics.drawRect(100, 200, 500, 250);
			sprite.graphics.endFill();
			addChild(sprite);
			sprite.addEventListener(MouseEvent.CLICK, function (event:Event): void {
//				var hasAd:Boolean = SAVideoAd.hasAdAvailable(252);
//				trace("What's the story, morning glory? " + hasAd);
				if (banner.hasAdAvailable()) {
					banner.play();
				}
				if (SAVideoAd.hasAdAvailable(252)) {
					SAVideoAd.play(252);
				}
				
//				if (SAInterstitialAd.hasAdAvailable(247)) {
//					SAInterstitialAd.play(247);
//				}
			});
			
			
			
			
			
//			/** support autoOrients */
//			stage.align = StageAlign.TOP_LEFT;
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			
//			/** setup the demo */
//			SuperAwesome.getInstance().setConfigurationProduction();
//			SuperAwesome.getInstance().disableTestMode();
//			
//			loader.delegate = this;
//			//			loader.loadAd(24541);
//			//			loader.loadAd(115);
//			loader.loadAd(30462);
		}
		
//		public function didLoadAd(ad: SAAd): void {
//			trace(ad.placementId);
//			trace(ad.adJson);
//			
//			if (ad.placementId == 30462) {
//								iad = new SAInterstitialAd();
//								iad.setAd(ad);
//								iad.play();
////				fvad = new SAFullscreenVideoAd();
////				fvad.setAd(ad);
////				fvad.play();
//			}
//			
//			//			if (ad.placementId == 114) {
//			////				trace("will call inter for 10305");
//			////				iad = new SAInterstitialAd();
//			////				iad.setAd(ad);
//			////				iad.play();
//			//			} else if (ad.placementId == 113) {
//			////				trace("will call inter for 30471");
//			////				bad = new SABannerAd(new Rectangle(250, 450, 640, 100));
//			////				bad.setAd(ad);
//			////				bad.adDelegate = this;
//			////				bad.isParentalGateEnabled = true;
//			////				bad.parentalGateDelegate = this;
//			////				bad.play();
//			//			} else if (ad.placementId == 116) {
//			//				trace("will call inter for 28000");
//			//				fvad = new SAFullscreenVideoAd();
//			//				fvad.setAd(ad);
//			//				fvad.videoAdDelegate = this;
//			//				fvad.shouldShowCloseButton = true;
//			//				fvad.shouldAutomaticallyCloseAtEnd = true;
//			//				fvad.shouldLockOrientation = true;
//			//				fvad.lockOrientation = SALockOrientation.LANDSCAPE;
//			//				fvad.play();
//			//			}
//		}
//		
//		public function didFailToLoadAd(placementId: int): void {
//			trace("failed to load " + placementId);
//		}
//		
//		public function adWasShown(placementId: int): void {
//			trace("adWasShown " + placementId);
//		}
//		
//		public function adFailedToShow(placementId: int): void {
//			trace("adFailedToShow " + placementId);
//		}
//		
//		public function adWasClosed(placementId: int): void {
//			trace("adWasClosed " + placementId);
//		}
//		
//		public function adWasClicked(placementId: int): void {
//			trace("adWasClicked " + placementId);
//		}
//		
//		public function adHasIncorrectPlacement(placementId: int): void {
//			trace("adHasIncorrectPlacement " + placementId);
//		}
//		
//		public function adStarted(placementId: int): void {
//			trace("adStarted " + placementId);
//		}
//		
//		public function videoStarted(placementId: int): void {
//			trace("videoStarted " + placementId);
//		}
//		
//		public function videoReachedFirstQuartile(placementId: int): void {
//			trace("videoReachedFirstQuartile " + placementId);
//		}
//		
//		public function videoReachedMidpoint(placementId: int): void {
//			trace("videoReachedMidpoint " + placementId);
//		}
//		
//		public function videoReachedThirdQuartile(placementId: int): void {
//			trace("videoReachedThirdQuartile " + placementId);
//		}
//		
//		public function videoEnded(placementId: int): void {
//			trace("videoEnded " + placementId);
//		}
//		
//		public function adEnded(placementId: int): void {
//			trace("adEnded " + placementId);
//		}
//		
//		public function allAdsEnded(placementId: int): void {
//			trace("allAdsEnded " + placementId);
//		}
//		
//		public function parentalGateWasCanceled(placementId: int): void {
//			trace("parentalGateWasCanceled" + placementId);
//		}
//		
//		public function parentalGateWasFailed(placementId: int): void {
//			trace("parentalGateWasFailed" + placementId);
//		}
//		
//		public function parentalGateWasSucceded(placementId: int): void {
//			trace("parentalGateWasSucceded" + placementId);
//		}
	}
}