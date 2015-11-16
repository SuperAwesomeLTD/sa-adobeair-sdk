package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Loader.SALoaderProtocol;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Views.SAAdProtocol;
	import tv.superawesome.Views.SABannerAd;
	import tv.superawesome.Views.SAInterstitialAd;
	import tv.superawesome.Views.SAVideoAd;
	
	[SWF(backgroundColor="0xffffff")]
	public class SuperAwesome_AndroidDemo extends Sprite
	{
		private var vad: SAVideoAd;
		private var iad: SAInterstitialAd;
		private var _html: StageWebView;
		
		public function SuperAwesome_AndroidDemo()
		{
			super();
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true)
				
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			SuperAwesome.getInstance().setConfigurationProduction();
//			SuperAwesome.getInstance().disableTestMode();
			
//			SALoader.getInstance().preloadAdForPlacementId(24532);
//			SALoader.getInstance().delegate = this;
			
//			iad = new SAInterstitialAd(24541);
//			iad.playInstant();
//			addChild(iad);
			
//			iad = new SAInterstitialAd(27741);
//			addChild(iad);
//			iad.playInstant();
//			
//			vad = new SAVideoAd(new Rectangle(0, 0, 500, 350), 24532);
//			vad.playInstant();
//			vad.delegate = this;
//			addChild(vad);
			
			// File
//			var file:File = File.applicationStorageDirectory.resolvePath("test.html"); 
//			var fileStream:FileStream = new FileStream();
//			fileStream.open(file, FileMode.WRITE);
//			var str: String = "<html><head></head><body><div class=\"celtra-ad-v3\">     <img src=\"data:image/png,celtra\" style=\"display: none\" onerror=\"         (function(img) {             var params = {'clickUrl':'[click]','expandDirection':'undefined','preferredClickThroughWindow':'','clickEvent':'advertiser','externalAdServer':'Custom','tagVersion':'1'};             var req = document.createElement('script');             req.id = params.scriptId = 'celtra-script-' + (window.celtraScriptIndex = (window.celtraScriptIndex||0)+1);             params.clientTimestamp = new Date/1000;             params.clientTimeZoneOffsetInMinutes = new Date().getTimezoneOffset();             var src = (window.location.protocol == 'https:' ? 'https' : 'http') + '://ads.celtra.com/4de76e38/web.js?';             for (var k in params) {                 src += '&amp;' + encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);             }             req.src = src;             img.parentNode.insertBefore(req, img.nextSibling);         })(this);     \"/> </div></body></html>";
//			fileStream.writeUTF(str);
//			fileStream.close();
//			
////			var destination:File = File.applicationStorageDirectory.resolvePath("docs/test.html");
////			file.copyTo(destination, true);   
////			var initialURL: String = "file://" + destination.nativePath ;
//			
//			trace(file.nativePath);
//						
//			_html = new StageWebView();
//			_html.viewPort = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
//			_html.stage = this.stage;
//			_html.loadString(str);
////			_html.loadURL(initialURL);
//			_html.addEventListener(Event.COMPLETE, completeLoading);
		}
		
		private function completeLoading(event: Event): void {
			trace("finished loading");
		}
		
//		public function didPreloadAd(ad: SAAd, placementId:int): void {
////			iad.setAd(ad);
////			iad.playPreloaded();
////			addChild(iad);
//		}
//		
//		public function didFailToPreloadAdForPlacementId(placementId:int): void {
//			trace("did fail to load " + placementId);
//		}
		
		private function handleActivate(event:Event):void {
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(event:Event):void {
			// NativeApplication.nativeApplication.exit();
		}
		
//		public function adWasShown(placementId: int): void {
//			trace("Ad was shown");
//		}
//		public function adFailedToShow(placementId: int): void {
//			
//		}
//		public function adWasClosed(placementId: int): void {
//			
//		}
//		public function adFollowedURL(placementId: int): void {
//			
//		}
	}
}