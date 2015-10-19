package tv.superawesome.Views {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import tv.superawesome.Views.SAVideoAdProtocol;
	
	public class SAVideoAd extends SAView{
		
		// private vars
		protected var stream:NetStream ;
		protected var nc:NetConnection;
		private var video:StageVideo ;
		
		// public vars
		public var videoDelegate: SAVideoAdProtocol;
		
		// constructor
		public function SAVideoAd(frame:Rectangle, placementId:int=0){
			super(frame, placementId);
			this.addEventListener(MouseEvent.CLICK, mouseClick);
		}
		
		// display and delayed display functions
		protected override function display(): void {
			if (stage) delayedDisplay();
			else addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		protected function delayedDisplay(e:Event = null): void {
			this.stage.addEventListener( StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY , stageVideoState );
		}
		
		protected function stageVideoState( e:StageVideoAvailabilityEvent ):void{
			
			// calc scaling
//			var newR: Rectangle = super.arrangeAdInFrame(super.frame);
//			newR.x += super.frame.x;
//			newR.y += super.frame.y;
//			
//			trace(newR.x + " " + newR.y + " " + newR.width + " " + newR.height);
			
			var available:Boolean = e.availability == StageVideoAvailability.AVAILABLE ;
			
			if ( available ) {
				nc = new NetConnection() ;
				nc.connect(null) ;
				stream = new NetStream(nc) ;
				stream.client = this ;
				video = this.stage.stageVideos[0] ;
				video.viewPort = this.frame ;
				video.attachNetStream(null);
				video.attachNetStream( stream ) ;
				
				stream.addEventListener(NetStatusEvent.NET_STATUS, onStatus); 
				stream.play(ad.creative.details.video) ;
			}
		}
		
		public function onStatus(stats: NetStatusEvent): void {
			trace("stats " + stats);
			var code:String = stats.info.code;
			switch (code) {
				case "NetStream.Play.Start":{
					trace("video started");
					if (videoDelegate != null) {
						videoDelegate.videoStarted(ad.placementId);
					}
					break;
				}
				case "NetStream.Play.Stop": {
					trace("video stopped");
					if (videoDelegate != null) {
						videoDelegate.videoEnded(ad.placementId);
					}
					break;
				}
			}
		}
		
		public function onMetaData( info:Object ):void {
//			trace("metadata");
		}
		
		public function onPlayStatus(info:Object): void {
//			trace("play status");
		}
		
		public function mouseClick(event: MouseEvent): void {
			goToURL();
		}
	}
}