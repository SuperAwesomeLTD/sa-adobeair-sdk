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
	
	public class AndroidDemo3 extends Sprite
	{	
		
		public function AndroidDemo3()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var banner:SABannerAd = new SABannerAd();
			banner.setPositionBottom();
			banner.setConfigurationStaging();
			banner.enableParentalGate();
			banner.load(414);
			
			SAInterstitialAd.setConfigurationStaging();
			SAInterstitialAd.disabledParentalGate();
			SAInterstitialAd.setOrientationPortrait();
			SAInterstitialAd.load(415);
			SAInterstitialAd.load(418);
			
			SAVideoAd.setConfigurationStaging();
			SAVideoAd.setOrientationLandscape();
			SAVideoAd.enableSmallClickButton();
			SAVideoAd.disableCloseButton();
			SAVideoAd.load(416);
			SAVideoAd.load(417);
			
			var color1:uint = 0xff0000;
			var color2:uint = 0x00ff00;
			var color3:uint = 0x0000ff;
			var color4:uint = 0xff00ff;
			var color5:uint = 0x00ffff;
			
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
			
			var playInter1:Sprite = new Sprite ();
			playInter1.graphics.beginFill(color2, 1);
			playInter1.graphics.drawRect(200, 0, 200, 150);
			playInter1.graphics.endFill();
			addChild(playInter1);
			playInter1.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
				if (SAInterstitialAd.hasAdAvailable(415)){
					trace("has ad available");
					SAInterstitialAd.play(415);
				}
			});
			
			var playInter2:Sprite = new Sprite ();
			playInter2.graphics.beginFill(color3, 1);
			playInter2.graphics.drawRect(400, 0, 200, 150);
			playInter2.graphics.endFill();
			addChild(playInter2);
			playInter2.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
				if (SAInterstitialAd.hasAdAvailable(418)) {
					SAInterstitialAd.play(418);
				}
			});
			
			var playVideo1:Sprite = new Sprite ();
			playVideo1.graphics.beginFill(color4, 1);
			playVideo1.graphics.drawRect(0, 150, 200, 150);
			playVideo1.graphics.endFill();
			addChild(playVideo1);
			playVideo1.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
				if (SAVideoAd.hasAdAvailable(416)) {
					SAVideoAd.play(416);
				}
			});
			
			var playVideo2:Sprite = new Sprite ();
			playVideo2.graphics.beginFill(color5, 1);
			playVideo2.graphics.drawRect(200, 150, 200, 150);
			playVideo2.graphics.endFill();
			addChild(playVideo2);
			playVideo2.addEventListener(MouseEvent.CLICK, function(evt:Event): void {
				if (SAVideoAd.hasAdAvailable(417)) {
					SAVideoAd.play(417);
				}
			});
		}
	}
}