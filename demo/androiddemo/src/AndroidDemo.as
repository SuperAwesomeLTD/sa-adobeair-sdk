package
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Loader.SALoaderProtocol;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Parser.SAVASTData;
	import tv.superawesome.Data.Parser.SAVASTParser;
	import tv.superawesome.System.SASystem;
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAVideoAd;
	import tv.superawesome.Views.Protocols.SAAdProtocol;
	
	public class AndroidDemo extends Sprite implements SALoaderProtocol, SAAdProtocol {
		
		var adData:SAAd = null;
		
		public function AndroidDemo() {
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			trace(SuperAwesome.getInstance().getSdkVersion());
			trace(SASystem.getSystemType() + "_" + SASystem.getSystemSize());
			
			SuperAwesome.getInstance().disableTestMode();
			SuperAwesome.getInstance().setConfigurationProduction();
			
			var goButton:SimpleButton = new SimpleButton();
			
			var myButtonSprite:Sprite = new Sprite();
			myButtonSprite.graphics.lineStyle(1, 0x555555);
			myButtonSprite.graphics.beginFill(0xff000,1);
			myButtonSprite.graphics.drawRect(0,50,400,100);
			myButtonSprite.graphics.endFill();
			
			goButton.overState = goButton.downState = goButton.upState = goButton.hitTestState = myButtonSprite;
			addChild(goButton);
			goButton.addEventListener(MouseEvent.CLICK, loadTheAd);
			
			SALoader.getInstance().delegate = this;
//			SALoader.getInstance().loadAd(79);
			SALoader.getInstance().loadAd(28000);
			
//			var parser:SAVASTParser = new SAVASTParser();
//			parser.simpleVASTParse("https://ads.staging.superawesome.tv/v2/video/vast/79/336/554/?sdkVersion=unknown&rnd=288097736", function (vastdata: SAVASTData): void {
//				vastdata.print();
//			});
//			var parser2:SAVASTParser = new SAVASTParser();
//			parser2.simpleVASTParse("https://rtr.innovid.com/r1.56bba2bd642b83.82132076;cb=[timestamp]", function (vastdata2: SAVASTData): void {
//				vastdata2.print();
//			});
		}
		
		public function loadTheAd(event: MouseEvent = null): void {
			if (adData != null) {
//				var iad:SAInterstitialAd = new SAInterstitialAd();
//				iad.setAd(adData);
//				iad.adDelegate = this;
//				addChildAt(iad, 0);
//				iad.play();
				var vad:SAVideoAd = new SAVideoAd(new Rectangle(0, 100, 640, 480));
				vad.setAd(adData);
				addChild(vad);
				vad.play();
			}
		}
		
		public function didLoadAd(ad: SAAd): void {
			ad.print();
			adData = ad;
//			var vad:SAVideoAd = new SAVideoAd(new Rectangle(0, 40, 640, 480));
//			vad.setAd(ad);
//			vad.adDelegate = this;
//			addChild(vad);
//			vad.play();
			
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