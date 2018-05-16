package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import tv.superawesome.sdk.advertiser.SAVerifyInstall;
	import tv.superawesome.sdk.agegate.SAAgeGate;
	import tv.superawesome.sdk.publisher.SAAppWall;
	import tv.superawesome.sdk.publisher.SABannerAd;
	import tv.superawesome.sdk.publisher.SAInterstitialAd;
	import tv.superawesome.sdk.publisher.SAVideoAd;
	import tv.superawesome.sdk.publisher.enums.SAEvent;
	
	public class DemoScreen extends Sprite
	{	
		
		public function DemoScreen()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			SAVerifyInstall.getInstance().handleInstall(function(success:Boolean): void {
//				trace("Handled CPI with " + success);
//			});
//			
//			trace("Current age is " + SAAgeGate.getCurrentAge());
//			
			
			
			var banner:SABannerAd = new SABannerAd();
			banner.setConfigurationProduction();
			banner.setColorTransparent();
			banner.setSize_728_90();
			banner.setCallback(function(placement:int, evt: int): void {
				if (evt == SAEvent.adLoaded) {
					trace("Banner Ad loaded " + placement);
				} else if (evt == SAEvent.adFailedToLoad) {
					trace("Banner Ad failed to load " + placement);
				} else if (evt == SAEvent.adShown) {
					trace("Banner Ad shown " + placement);
				} else if (evt == SAEvent.adFailedToShow) {
					trace("Banner Ad failed to show " + placement);
				} else if (evt == SAEvent.adClicked) {
					trace("Banner Ad clicked " + placement);
				} else if (evt == SAEvent.adClosed) {
					trace("Banner Ad closed " + placement);
				}
			});
			
			SAVideoAd.setConfigurationProduction();ape();
			SAVideoAd.enableCloseButton();
			SAVideoAd.setCallback(function(placement:int, evt: int): void {
				if (evt == SAEvent.adLoaded) {
					trace("Video Ad loaded " + placement);
				} else if (evt == SAEvent.adFailedToLoad) {
					trace("Video Ad failed to load " + placement);
				} else if (evt == SAEvent.adShown) {
					trace("Video Ad shown " + placement);
				} else if (evt == SAEvent.adFailedToShow) {
					trace("Video Ad failed to show " + placement);
				} else if (evt == SAEvent.adClicked) {
					trace("Video Ad clicked " + placement);
				} else if (evt == SAEvent.adClosed) {
					trace("Video Ad closed " + placement);
				} else if (evt == SAEvent.adEnded) { 
					trace("Video Ad ended " + placement);
				}
			});
			
			banner.load(36982);
			SAVideoAd.load(36981);
			
			var color1:uint = 0xff0000;
			var color4:uint = 0xff00ff;
			
			var playBanner:Sprite = new Sprite ();
			playBanner.graphics.beginFill(color1, 1);
			playBanner.graphics.drawRect(0, 0, 200, 150);
			playBanner.graphics.endFill();
			addChild(playBanner);
			playBanner.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
				if (banner.hasAdAvailable()) {
					banner.play();
				}
			});
			
			var playVideo1:Sprite = new Sprite ();
			playVideo1.graphics.beginFill(color4, 1);
			playVideo1.graphics.drawRect(0, 150, 200, 150);
			playVideo1.graphics.endFill();
			addChild(playVideo1);
			playVideo1.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
				 if (SAVideoAd.hasAdAvailable(36981)) {
					SAVideoAd.play(36981);
				 }
			});
		}
	}
}