package  {
	
	import flash.display.MovieClip;
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Loader.*;
	import tv.superawesome.Views.SABannerAd;
	import tv.superawesome.Views.SAVideoAd;
	import tv.superawesome.Views.SAVideoAdProtocol;
	import flash.geom.Rectangle;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAFullscreenVideoAd;
	
	public class SAAirDemo extends MovieClip implements SALoaderProtocol{

		var bad: SABannerAd;
		
		public function SAAirDemo() {
			// constructor code
			
			SuperAwesome.getInstance().enableTestMode();
			SuperAwesome.getInstance().setConfigurationProduction();
			
			SALoader.getInstance().preloadAdForPlacementId(21636);
			SALoader.getInstance().delegate = this;
			
			// bad = new SABannerAd(this.stage, new Rectangle(0,0,250,150));
			
			// var bad: SABannerAd = new SABannerAd(this.stage, new Rectangle(0,0,320,150), 21636);
			// bad.playInstant();
			
			
			// var sad: SAVideoAd = new SAVideoAd(this.stage, new Rectangle(0, 170, 350, 370), 21022);
			// sad.playInstant();
			
			var iad: SAInterstitialAd = new SAInterstitialAd(this.stage, 21924);
			iad.playInstant();
			
			var fvad: SAFullscreenVideoAd = new SAFullscreenVideoAd(this.stage, 21022);
			fvad.playInstant();
		}
		
		public function didPreloadAd(ad: SAAd, placementId:int): void {
			// bad.setAd(ad);
			// bad.playPreloaded();
		}
		
		public function didFailToPreloadAdForPlacementId(placementId:int): void {
			trace("did fail");
		}

	}
	
}
