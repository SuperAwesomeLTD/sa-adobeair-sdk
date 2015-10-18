package  {
	
	import flash.display.MovieClip;
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Views.SABannerAd;
	import tv.superawesome.Views.SAVideoAd;
	import flash.geom.Rectangle;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAFullscreenVideoAd;
	
	public class SAAirDemo extends MovieClip{

		var bad: SABannerAd;
		
		public function SAAirDemo() {
			SuperAwesome.getInstance().enableTestMode();
			SuperAwesome.getInstance().setConfigurationProduction();
			
			var bad: SABannerAd = new SABannerAd(this.stage, new Rectangle(0,0,320,50), 21636);
			bad.playInstant();
			
			var sad: SAVideoAd = new SAVideoAd(this.stage, new Rectangle(0, 170, 350, 370), 21022);
			sad.playInstant();
			
		}
	}
	
}
