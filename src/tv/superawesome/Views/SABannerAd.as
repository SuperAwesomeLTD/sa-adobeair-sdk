package tv.superawesome.Views{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	public class SABannerAd extends SAView {
		// the loader
		private var imgLoader: Loader = new Loader();
		private var bg: Sprite;
		private var st: Stage;
		private var webView: StageWebView;
		
		function SABannerAd(st: Stage, frame: Rectangle, placementId: int = 0) {
			this.st = st;
			super(frame, placementId);
		}
		
		protected override function display(): void {
			// 1. background
			bg = new Sprite();
			bg.x = 0;
			bg.y = 0;
			st.addChild(bg);
			
			// 2. add real bg
			var bdrm: Sprite = new Sprite();
			[Embed(source = '../../../resources/bg.png')] var BgIconClass:Class;
			var bmp2:Bitmap = new BgIconClass();
			bdrm.addChild(bmp2);
			bdrm.x = super.frame.x;
			bdrm.y = super.frame.y;
			bdrm.width = super.frame.width;
			bdrm.height = super.frame.height;
			bg.addChild(bdrm);
			
			// 2. calc scaling
			var newR: Rectangle = super.arrangeAdInFrame(super.frame);
			newR.x += super.frame.x;
			newR.y += super.frame.y;
			
			// calc the ad
			webView = new StageWebView();
			webView.stage = st;
			webView.viewPort = newR;
			webView.loadString(ad.adHTML);
			webView.addEventListener(Event.COMPLETE, success);
			webView.addEventListener(ErrorEvent.ERROR, error);
			webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, locationChanged);
		}
		
		private function locationChanged(e:LocationChangeEvent): void {
			e.preventDefault()
			super.goToURL();
		}
	}
}