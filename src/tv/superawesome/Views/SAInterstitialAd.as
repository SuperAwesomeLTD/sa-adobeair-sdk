package tv.superawesome.Views{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	public class SAInterstitialAd extends SAView{
		
		// private vars
		private var background: Sprite;
		private var close: Sprite;
		private var webView: StageWebView;
		
		// constructor
		public function SAInterstitialAd(placementId:int=0){
			// call super
			super(new Rectangle(0, 0, 0, 0), placementId);
			
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
			
			// create close button
			close = new Sprite();
			close.addChild(bmp);
			close.addEventListener(MouseEvent.CLICK, closeAction);
			this.addChildAt(close, 1);
		}
		
		public function onResize(...ig): void {
			if (super.ad != null) {
				this.display();
			}
		}
		
		protected override function display(): void {	
			if (this.stage != null) delayedDisplay();
			else this.addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		protected function delayedDisplay(e:Event = null): void {
			this.frame = new Rectangle(0, 0, this.stage.fullScreenWidth, this.stage.fullScreenHeight);
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
			webView.loadString(ad.adHTML);
			webView.viewPort = newR;
			
			// assign new close btn frame
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
			e.preventDefault()
			super.goToURL();
		}
	}
}