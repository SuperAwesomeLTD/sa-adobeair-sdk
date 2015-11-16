package tv.superawesome.Views{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	public class SABannerAd extends SAView {
		// the loader
		private var background: Sprite;
		private var close: Sprite;
		private var webView: StageWebView;
		
		function SABannerAd(frame: Rectangle) {
			// call to super
			super(frame);
			
			// load external resources 
			[Embed(source = '../../../resources/bg.png')] var BgIconClass:Class;
			var bmp2:Bitmap = new BgIconClass();
			
			// create background
			background = new Sprite();
			background.addChild(bmp2);
			this.addChildAt(background, 0);
			
			// create webview
			webView = new StageWebView();
			webView.addEventListener(Event.COMPLETE, success);
			webView.addEventListener(ErrorEvent.ERROR, error);
			webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, locationChanged);
		}
		
		public override function play(): void {	
			if (this.stage != null) delayedDisplay();
			else this.addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		private function delayedDisplay(): void {
			// update background
			background.x = super.frame.x;
			background.y = super.frame.y;
			background.width = super.frame.width;
			background.height = super.frame.height;
			
			// calc scaling
			var newR: Rectangle = super.arrangeAdInFrame(super.frame);
			newR.x += super.frame.x;
			newR.y += super.frame.y;
			
			// calc the ad
			webView.stage = this.stage;
			webView.viewPort = newR;
			webView.loadString(ad.adHTML);
		}
		
		private function locationChanged(e:LocationChangeEvent): void {
			e.preventDefault()
			super.goToURL();
		}
	}
}