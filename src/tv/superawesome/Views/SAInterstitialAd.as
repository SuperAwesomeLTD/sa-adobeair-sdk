package tv.superawesome.Views{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.filesystem.File;
	import es.xperiments.media.StageWebViewBridge;
	
	public class SAInterstitialAd extends SAView{
		
		// private vars
		private var background: Sprite;
		private var close: Sprite;
		private var webView: StageWebView;
		
		// constructor
		public function SAInterstitialAd(){
			// call super
			super(new Rectangle(0, 0, 0, 0));
			
			// load external resources 
			[Embed(source = '../../../resources/bg.png')] var BgIconClass:Class;
			var bmp2:Bitmap = new BgIconClass();
			
			[Embed(source = '../../../resources/close.png')] var CancelIconClass:Class;
			var bmp: Bitmap = new CancelIconClass();
			
			// create background
			background = new Sprite();
			background.addChild(bmp2);
			this.addChildAt(background, 0);
			
			// create webview
			webView = new StageWebView();
			webView.addEventListener(Event.COMPLETE, success);
			webView.addEventListener(ErrorEvent.ERROR, error);
			webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, locationChanged);
			webView.addEventListener(Event.COMPLETE, onHTMLLoadComplete, false, 0, true);
			
			// create close button
			close = new Sprite();
			close.addChild(bmp);
			close.addEventListener(MouseEvent.CLICK, closeAction);
			this.addChildAt(close, 1);
		}
		
		public function onResize(...ig): void {
			if (super.ad != null) {
				this.play();
			}
		}
		
		public override function play(): void {	
			if (this.stage != null) delayedDisplay();
			else this.addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		private function delayedDisplay(e:Event = null): void {
			this.frame = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			this.stage.addEventListener(Event.RESIZE, onResize);
			
			// assign new background frame
			background.x = super.frame.x;
			background.y = super.frame.y;
			background.width = super.frame.width;
			background.height = super.frame.height;
			
			// assign new webview frame
			var tW: Number = super.frame.width * 0.85;
			var tH: Number = super.frame.height * 0.85;
			var tX: Number = ( super.frame.width - tW ) / 2;
			var tY: Number = ( super.frame.height - tH) / 2;
			var newR: Rectangle = super.arrangeAdInFrame(new Rectangle(tX, tY, tW, tH));
			newR.x += tX;
			newR.y += tY;
			webView.stage = this.stage;
			webView.viewPort = newR;
			trace('Inside the interstitial');
			trace(ad.adHTML);
			
//			var htmlString:String = "<!DOCTYPE HTML>" + 
//				"<html><script type=text/javascript>" + 
//				"function callURI(){" + 
//				"alert(\"You clicked me!!\");"+ 
//				"}</script><body>" + 
//				"<p><a href=javascript:callURI()>Click Me</a></p>" + 
//				"</body></html>"; 
//			
//			webView.loadString(htmlString);
//			webView.loadURL("https://s3-eu-west-1.amazonaws.com/beta-ads-uploads/rich-media/upload_23ea4ad869ed5253ebcb6f1474e672bf/index.html");
			webView.loadURL("https://s3-eu-west-1.amazonaws.com/beta-ads-uploads/rich-media/upload_2cb21eb333130e17c41519c1df366b25/index.html");
			
//			var buildPath:String = File.applicationDirectory.nativePath;
//			var source:String;
//			source = buildPath + "/"+ "resources/test.html";
//			trace(source);
//			webView.loadURL(source);
			
			// assign new close btn frame
			var cS: Number = Math.min(super.frame.width, super.frame.height) * 0.15;
			close.x = super.frame.width - cS / 2.0;
			close.y = 0;
			close.width = cS / 2.0;
			close.height = cS / 2.0;
		}
		
		private function onHTMLLoadComplete(event:Event):void {
//			var write: String = "\"<script type='text/javascript' src='https://ads.superawesome.tv/v2/ad.js?placement=30016'></script>\"";
//			var func: String = "javascript:document.write("+write+")";
//			trace(func);
//			webView.loadURL(func);
		}
		
		private function closeAction(event: MouseEvent): void {
			// call remove child
			parent.removeChild(this);
			webView.stage = null;
			
			// call delegate
			if (super.delegate != null) {
				super.delegate.adWasClosed(ad.placementId);
			}
		}
		
		private function locationChanged(e:LocationChangeEvent): void {
			e.preventDefault()
			super.goToURL();
		}
	}
}