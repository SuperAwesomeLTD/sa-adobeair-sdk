package tv.superawesome.Views{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;
	
	import tv.superawesome.Data.Models.SACreativeFormat;
	import tv.superawesome.System.*;
	
	public class SAInterstitialAd extends SAView{
		
		// private vars
		private var background: Sprite;
		private var close: Sprite;
		private var webView: StageWebView;
		
		// constructor
		public function SAInterstitialAd(){
			// call super
			super(new Rectangle(0, 0, 0, 0));
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
			
			////////////////////////////////////////////////
			// 1. create background
			if (background == null) {
				[Embed(source = '../../../resources/bg.png')] var BgIconClass:Class;
				var bmp2:Bitmap = new BgIconClass();
				
				background = new Sprite();
				background.addChild(bmp2);
				this.addChildAt(background, 0);
			}
			
			background.x = super.frame.x;
			background.y = super.frame.y;
			background.width = super.frame.width;
			background.height = super.frame.height;
			
			////////////////////////////////////////////////
			// 2. create webview
			if (webView == null) {
				webView = new StageWebView(true);
				webView.stage = this.stage;
				webView.addEventListener(Event.COMPLETE, success);
				webView.addEventListener(ErrorEvent.ERROR, error);
				webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, locationChanged);
			}
			
			var tW: Number = super.frame.width * 0.85;
			var tH: Number = super.frame.height * 0.85;
			var tX: Number = ( super.frame.width - tW ) / 2;
			var tY: Number = ( super.frame.height - tH) / 2;
			var newR: Rectangle = super.arrangeAdInFrame(new Rectangle(tX, tY, tW, tH));
			newR.x += tX;
			newR.y += tY;
			webView.viewPort = newR;
			
			switch (ad.creative.format){
				case SACreativeFormat.image: {
					webView.loadString(ad.adHTML);
					break;
				}
				case SACreativeFormat.rich: {
					
					var _stype: String = SASystem.getSystemType();
					
					// If the deployment target is iPhone, then do some hacks to display 
					// rich media properly scaled
					if (_stype == SASystemType.ios) {
						var scale: Number = 1;
						if (ad.creative.details.width < ad.creative.details.height) {
							scale = newR.width / Math.min(this.stage.stageWidth, this.stage.stageHeight);
						} else {
							scale = newR.height / Math.max(this.stage.stageWidth, this.stage.stageHeight);
						}
						
						var finalString1: String = ad.adHTML;
						finalString1 = finalString1.replace("_PARAM_SCALE_", scale);
						finalString1 = finalString1.replace("_PARAM_SCALE_", scale);
						finalString1 = finalString1.replace("_PARAM_DPI_", "device-dpi");
						
						webView.loadString(finalString1);
					} 
					// If the deployment target is not iPhone (then Android), do some other
					// hacks to display rich media properly scaled
					else if (_stype == SASystemType.android) {
						var cdpi: Number = Capabilities.screenDPI;
						var ndpi: Number =  Math.floor((ad.creative.details.width * cdpi) / newR.width);
						
						var finalString2: String = ad.adHTML;
						finalString2 = finalString2.replace("_PARAM_SCALE_", "1.0");
						finalString2 = finalString2.replace("_PARAM_SCALE_", "1.0");
						finalString2 = finalString2.replace("_PARAM_DPI_", (ndpi + "dpi"));
						trace(finalString2);
						webView.loadString(finalString2);
					}
					
					break;
				}
				case SACreativeFormat.tag: {
					var finalHTML: String = ad.adHTML;
					
					var file:File = File.applicationStorageDirectory; 
					file = file.resolvePath("tmpTag.html");
					var fileStream: FileStream = new FileStream();
					fileStream.open(file, FileMode.WRITE);
					fileStream.writeUTFBytes(finalHTML);
					fileStream.close();
					
					var destination:File = File.applicationStorageDirectory.resolvePath("docs/tmpTag.html");
					file.copyTo(destination, true);   
					var finalURL: String = "file://" + destination.nativePath ;
					
					webView.loadURL(finalURL);
					
					break;
				}
			}
			
			////////////////////////////////////////////////
			// create close button
			if (close == null) {
				[Embed(source = '../../../resources/close.png')] var CancelIconClass:Class;
				var bmp: Bitmap = new CancelIconClass();
				
				close = new Sprite();
				close.addChild(bmp);
				close.addEventListener(MouseEvent.CLICK, closeAction);
					
				this.addChildAt(close, 1);
			}
			
			var cS: Number = Math.min(super.frame.width, super.frame.height) * 0.15;
			close.x = super.frame.width - cS / 2.0;
			close.y = 0;
			close.width = cS / 2.0;
			close.height = cS / 2.0;
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
			// call delegate
			if (this.delegate != null) {
				this.delegate.adWasClicked(this.ad.placementId);
			}
			
			var clickURL: URLRequest = null;
			
			switch (ad.creative.format) {
				case SACreativeFormat.image: {
					e.preventDefault();
					e.stopImmediatePropagation();
					
					clickURL = new URLRequest(this.ad.creative.clickURL);
					navigateToURL(clickURL, "_blank");
					
					break;
				}
				case SACreativeFormat.rich: {
					// do nothing
					break;
				}
				case SACreativeFormat.tag: {
					e.preventDefault();
					e.stopImmediatePropagation();
					
					var url: String = e.location;
					var toDel:String = url.slice(0, url.indexOf("http"));
					url = url.replace(toDel,"");
					var finalURL: String = ad.creative.trackingURL + "&redir="+url;
					
					// navigate
					clickURL = new URLRequest(url);
					navigateToURL(clickURL, "_blank");
					
					break;
				}
			}
		}
	}
}