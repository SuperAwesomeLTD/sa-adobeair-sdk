package  {
	
	import flash.display.MovieClip;
	import tv.superawesome.DisplayAd;
	import tv.superawesome.VideoAd;
	import flash.geom.Rectangle;
	import flash.events.*;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class SADemoApp extends MovieClip {
		
		
		public function SADemoApp() {
			// constructor code
			
			//this.stage.scaleMode = StageScaleMode.NO_SCALE;
			//this.stage.align = StageAlign.TOP_LEFT;

			var vp1:Rectangle = new Rectangle(0,860,640,100);
			var ad1:DisplayAd = new DisplayAd(this.stage, vp1, 14, 5246475);

			var vp2:Rectangle = new Rectangle(20,200,600,500);
			var ad2:DisplayAd = new DisplayAd(this.stage, vp2, 14, 5246472);

			playBtn.addEventListener(MouseEvent.CLICK, onBtnClick);

		}
		
		public function onComplete(e:Event){
			trace("Video Ad finished");
		}
		
		public function onBtnClick(playBtn:MouseEvent){
			var vp3:Rectangle = new Rectangle(0,0,this.stage.width,this.stage.height);
			var ad3:VideoAd = new VideoAd(this.stage, vp3, 14, 314228);
			ad3.addEventListener(Event.COMPLETE, onComplete);
		}
	}
	
}
