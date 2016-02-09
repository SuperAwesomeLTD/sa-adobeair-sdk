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
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAVideoAd;
	import tv.superawesome.Views.Protocols.SAAdProtocol;
	
	public class AndroidDemo extends Sprite implements SALoaderProtocol, SAAdProtocol {
		public function AndroidDemo() {
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			trace(SuperAwesome.getInstance().getSdkVersion());
			trace(SASystem.getSystemType() + "_" + SASystem.getSystemSize());
			
			SuperAwesome.getInstance().disableTestMode();
			SuperAwesome.getInstance().setConfigurationDevelopment();
			
			SALoader.getInstance().delegate = this;
			SALoader.getInstance().loadAd(5);
		}
		
		public function didLoadAd(ad: SAAd): void {
			ad.print();
			var vad:SAVideoAd = new SAVideoAd(new Rectangle(0, 40, 640, 480));
			vad.setAd(ad);
			vad.adDelegate = this;
			addChild(vad);
			vad.play();
//			var vad:SAVideoAd = new SAVideoAd(new Rectangle(0, 40, 640, 480));
//			vad.setAd(ad);
//			vad.adDelegate = this;
//			addChild(vad);
//			vad.play();
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
	}
}