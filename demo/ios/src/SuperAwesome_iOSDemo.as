package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Loader.SALoaderProtocol;
	import tv.superawesome.Data.Models.SAAd;
	
	public class SuperAwesome_iOSDemo extends Sprite implements SALoaderProtocol
	{
//		private var bad: SABannerAd;
//		private var vad: SAVideoAd;
//		private var iad: SAInterstitialAd;
		
		[SWF(backgroundColor="0xff0000")]
		public function SuperAwesome_iOSDemo()
		{
			super();
			
			// setup stage and native app attributes
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true)
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// setup SA SDK
			SuperAwesome.getInstance().disableTestMode();
			SuperAwesome.getInstance().setConfigurationProduction();
			
			SALoader.getInstance().delegate = this;
			SALoader.getInstance().loadAd(30025);
			
//			bad = new SABannerAd(new Rectangle(0, 0, 640, 100), 19311);
//			SuperAwesome.getInstance().enableTestMode();
//			bad.playInstant();
//			addChild(bad);
//			
//			vad = new SAVideoAd(new Rectangle(0, 250, 640, 480), 24532);
//			SuperAwesome.getInstance().disableTestMode();
//			vad.playInstant();
//			addChild(vad);
			
//			iad = new SAInterstitialAd(27741);
//			addChild(iad);
//			iad.playInstant();
			
//			var file:File = File.applicationStorageDirectory; 
//			file = file.resolvePath("test.html");
//			
//			var fileStream:FileStream = new FileStream();
//			fileStream.open(file, FileMode.WRITE);
//			
//			var str: String;
//			str = "<html><head></head><body><div class=\"celtra-ad-v3\">     <img src=\"data:image/png,celtra\" style=\"display: none\" onerror=\"         (function(img) {             var params = {'clickUrl':'[click]','expandDirection':'undefined','preferredClickThroughWindow':'','clickEvent':'advertiser','externalAdServer':'Custom','tagVersion':'1'};             var req = document.createElement('script');             req.id = params.scriptId = 'celtra-script-' + (window.celtraScriptIndex = (window.celtraScriptIndex||0)+1);             params.clientTimestamp = new Date/1000;             params.clientTimeZoneOffsetInMinutes = new Date().getTimezoneOffset();             var src = (window.location.protocol == 'https:' ? 'https' : 'http') + '://ads.celtra.com/4de76e38/web.js?';             for (var k in params) {                 src += '&amp;' + encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);             }             req.src = src;             img.parentNode.insertBefore(req, img.nextSibling);         })(this);     \"/> </div></body></html>";
//			fileStream.writeUTF(str);
//			fileStream.close();
//			
//			var _html: StageWebView = new StageWebView();
//			_html.viewPort = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
//			_html.stage = this.stage;
//			var buildPath:String = File.applicationStorageDirectory.nativePath;
//			var source: String = buildPath + "/"+ "test.html";
//			trace(source);
//			_html.loadURL(source);
		}
		
		public function didLoadAd(ad: SAAd): void {
			ad.print();
		}
		
		public function didFailToLoadAdForPlacementId(placementId:int): void {
			trace("did fail to load " + placementId);
		}
		
		private function handleActivate(event:Event):void {
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(event:Event):void {
			// do nothing
		}
	}
}