package tv.superawesome.Views{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	public class SAInterstitialAd extends SAView{
		
		private var bg: Sprite;
		private var st: Stage;
		private var webView: StageWebView;
		
		public function SAInterstitialAd(st: Stage, placementId:int=0){
			this.st = st;
			super(new Rectangle(0, 0, st.stageWidth, st.stageHeight), placementId);
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
			bg.addChildAt(bdrm, 0);
			
			// 2. calc scaling
			var newR: Rectangle = super.arrangeAdInFrame(super.frame);
			newR.x += super.frame.x + 35;
			newR.y += super.frame.y + 35;
			newR.width -= 70;
			newR.height -= 70;
			
			// calc the ad
			webView = new StageWebView();
			webView.stage = st;
			webView.viewPort = newR;
			webView.loadString(ad.adHTML);
			webView.addEventListener(Event.COMPLETE, success);
			webView.addEventListener(ErrorEvent.ERROR, error);
			webView.addEventListener(LocationChangeEvent.LOCATION_CHANGING, locationChanged);
			
			// 6. the close button
			var spr: Sprite = new Sprite();
			[Embed(source = '../../../resources/close.png')] var CancelIconClass:Class;
			var bmp: Bitmap = new CancelIconClass();
			spr.addChild(bmp);
			spr.x = super.frame.width-35;
			spr.y = 5;
			spr.width = 30;
			spr.height = 30;
			bg.addChildAt(spr, 1);
			spr.addEventListener(MouseEvent.CLICK, close);
			
		}
		
		private function close(event: MouseEvent): void {
			// call remove child
			st.removeChild(bg);
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