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
	import tv.superawesome.Views.SAVideoAd;
	
	public class SuperAwesome_AIR_iOSiPad_Demo extends Sprite implements SALoaderProtocol
	{
		public function SuperAwesome_AIR_iOSiPad_Demo()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			SuperAwesome.getInstance().disableTestMode();
			SuperAwesome.getInstance().setConfigurationProduction();
			
			SALoader.getInstance().delegate = this;
			SALoader.getInstance().loadAd(28000);
		}
		
		public function didLoadAd(ad: SAAd): void {
			var vad:SAVideoAd = new SAVideoAd(new Rectangle(0, 40, 640, 480));
			vad.setAd(ad);
			addChild(vad);
			vad.play();
		}
		
		public function didFailToLoadAdForPlacementId(placementId: int): void {
			trace("empty");
		}
	}
}