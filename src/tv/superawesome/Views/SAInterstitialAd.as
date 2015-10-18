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
			var newR: Rectangle = super.arrangeAdInFrame(super.frame);
			newR.x += super.frame.x + 35;
			newR.y += super.frame.y + 35;
			newR.width -= 70;
			newR.height -= 70;
			webView.stage = this.stage;
			webView.loadString(ad.adHTML);
			webView.viewPort = newR;
			
			// assign new close btn frame
			close.x = super.frame.width-35;
			close.y = 5;
			close.width = 30;
			close.height = 30;
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