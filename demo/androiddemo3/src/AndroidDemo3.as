package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
//	import tv.superawesome.sdk.SAAppWall;
//	import tv.superawesome.SABannerAd;
//	import tv.superawesome.SACPI;
//	import tv.superawesome.SAInterstitialAd;
//	import tv.superawesome.SAVideoAd;
//	import tv.superawesome.SuperAwesome;
//	import tv.superawesome.SuperAwesomeAdvertiser;
//	import tv.superawesome.enums.SAEvent;
	import tv.superawesome.sdk.advertiser.SAVerifyInstall;
	
	public class AndroidDemo3 extends Sprite
	{	
		
		public function AndroidDemo3()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			SAVerifyInstall.getInstance().handleInstall(function(success:Boolean): void {
				trace("Handled CPI with " + success);
			});
			
//			var inst:SACPI = SACPI.getInstance();
//			trace("Instance is " + inst);
			
//			SACPI.getInstance().handleInstall (function (success:Boolean): void {
//				trace("Handled CPI with " + success);
//			});
			
//			SuperAwesome.getInstance().handleCPI ();
			
			// SuperAwesome.getInstance().handleCPI();
//			SuperAwesome.getInstance().
			
//			var banner:SABannerAd = new SABannerAd();
//			banner.setConfigurationStaging();
//			banner.setColorTransparent();
//			banner.setSize_728_90();
////			banner.setPositionTop();
////			banner.disabledParentalGate();
//			banner.setCallback(function(placement:int, evt: int): void {
//				if (evt == SAEvent.adLoaded) {
//					trace("Banner Ad loaded " + placement);
//				} else if (evt == SAEvent.adFailedToLoad) {
//					trace("Banner Ad failed to load " + placement);
//				} else if (evt == SAEvent.adShown) {
//					trace("Banner Ad shown " + placement);
//				} else if (evt == SAEvent.adFailedToShow) {
//					trace("Banner Ad failed to show " + placement);
//				} else if (evt == SAEvent.adClicked) {
//					trace("Banner Ad clicked " + placement);
//				} else if (evt == SAEvent.adClosed) {
//					trace("Banner Ad closed " + placement);
//				}
//			});
//			
//			SAInterstitialAd.setConfigurationStaging();
////			SAInterstitialAd.setOrientationPortrait();
////			SAInterstitialAd.disabledParentalGate();
//			SAInterstitialAd.setCallback(function(placement:int, evt: int): void {
//				if (evt == SAEvent.adLoaded) {
//					trace("Interstitial Ad loaded " + placement);
//				} else if (evt == SAEvent.adFailedToLoad) {
//					trace("Interstitial Ad failed to load " + placement);
//				} else if (evt == SAEvent.adShown) {
//					trace("Interstitial Ad shown " + placement);
//				} else if (evt == SAEvent.adFailedToShow) {
//					trace("Interstitial Ad failed to show " + placement);
//				} else if (evt == SAEvent.adClicked) {
//					trace("Interstitial Ad clicked " + placement);
//				} else if (evt == SAEvent.adClosed) {
//					trace("Interstitial Ad closed " + placement);
//				}
//			});
//			
//			SAVideoAd.setConfigurationStaging();
////			SAVideoAd.disableCloseAtEnd();
////			SAVideoAd.setOrientationLandscape();
////			SAVideoAd.enableCloseButton();
//			SAVideoAd.setCallback(function(placement:int, evt: int): void {
//				if (evt == SAEvent.adLoaded) {
//					trace("Video Ad loaded " + placement);
//				} else if (evt == SAEvent.adFailedToLoad) {
//					trace("Video Ad failed to load " + placement);
//				} else if (evt == SAEvent.adShown) {
//					trace("Video Ad shown " + placement);
//				} else if (evt == SAEvent.adFailedToShow) {
//					trace("Video Ad failed to show " + placement);
//				} else if (evt == SAEvent.adClicked) {
//					trace("Video Ad clicked " + placement);
//				} else if (evt == SAEvent.adClosed) {
//					trace("Video Ad closed " + placement);
//				} else if (evt == SAEvent.adEnded) { 
//					trace("Video Ad ended " + placement);
//				}
//			});
//			
//			banner.load(636);
////			banner.close();
//			SAInterstitialAd.load(605);
//			SAInterstitialAd.load(606);
//			SAVideoAd.load(604);
//			
//			var color1:uint = 0xff0000;
//			var color2:uint = 0x00ff00;
//			var color3:uint = 0x0000ff;
//			var color4:uint = 0xff00ff;
//			var color5:uint = 0x00ffff;
//			var color6:uint = 0xf0f0f0;
//			
//			var playBanner:Sprite = new Sprite ();
//			playBanner.graphics.beginFill(color1, 1);
//			playBanner.graphics.drawRect(0, 0, 200, 150);
//			playBanner.graphics.endFill();
//			addChild(playBanner);
//			playBanner.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
//				if (banner.hasAdAvailable()) {
//					banner.play();
//				}
//			});
//			
//			var playInter1:Sprite = new Sprite ();
//			playInter1.graphics.beginFill(color2, 1);
//			playInter1.graphics.drawRect(200, 0, 200, 150);
//			playInter1.graphics.endFill();
//			addChild(playInter1);
//			playInter1.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
//				if (SAInterstitialAd.hasAdAvailable(605)){
//					SAInterstitialAd.play(605);
//				}
//			});
//			
//			var playInter2:Sprite = new Sprite ();
//			playInter2.graphics.beginFill(color3, 1);
//			playInter2.graphics.drawRect(400, 0, 200, 150);
//			playInter2.graphics.endFill();
//			addChild(playInter2);
//			playInter2.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
//				if (SAInterstitialAd.hasAdAvailable(606)) {
//					SAInterstitialAd.play(606);
//				}
//			});
//			
//			var playVideo1:Sprite = new Sprite ();
//			playVideo1.graphics.beginFill(color4, 1);
//			playVideo1.graphics.drawRect(0, 150, 200, 150);
//			playVideo1.graphics.endFill();
//			addChild(playVideo1);
//			playVideo1.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
//				 if (SAVideoAd.hasAdAvailable(604)) {
//					SAVideoAd.play(604);
//				 }
//			});
			
//			var playVideo2:Sprite = new Sprite ();
//			playVideo2.graphics.beginFill(color5, 1);
//			playVideo2.graphics.drawRect(200, 150, 200, 150);
//			playVideo2.graphics.endFill();
//			addChild(playVideo2);
//			playVideo2.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
////				if (SAVideoAd.hasAdAvailable(417)) {
////					SAVideoAd.play(417);
////				}
//				if (SAAppWall.hasAdAvailable(437)) {
//					SAAppWall.play(437);
//				}
//			});
			
//			var dispose:Sprite = new Sprite ();
//			dispose.graphics.beginFill(color6, 1);
//			dispose.graphics.drawRect(400, 150, 200, 150);
//			dispose.graphics.endFill();
//			addChild(dispose);
//			dispose.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
//				 SuperAwesome.getInstance().disposeContext();
//			});
		}
	}
}