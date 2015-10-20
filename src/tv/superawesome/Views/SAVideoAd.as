package tv.superawesome.Views {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.media.StageWebView;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import tv.superawesome.Views.SAVideoAdProtocol;
	
	public class SAVideoAd extends SAView{
		
		// private vars
		private var stream: NetStream;
		private var nc: NetConnection;
		private var videoBtn: Sprite;
		private var video: StageVideo;
		
		// public vars
		public var videoDelegate: SAVideoAdProtocol;
		
		// constructor
		public function SAVideoAd(frame:Rectangle, placementId:int=0){
			super(frame, placementId);
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
			
			var available:Boolean = e.availability == StageVideoAvailability.AVAILABLE ;
			
			if ( available ) {
				nc = new NetConnection() ;
				nc.connect(null) ;
				stream = new NetStream(nc) ;
				stream.client = this ;
				video = this.stage.stageVideos[0] ;
				video.viewPort = super.frame ;
				video.attachNetStream(null);
				video.attachNetStream( stream ) ;
				
				stream.addEventListener(NetStatusEvent.NET_STATUS, onStatus); 
				stream.play(ad.creative.details.video) ;
				
				var format: TextFormat = new TextFormat();
				format.size = 32.0;
				format.align = flash.text.TextFormatAlign.RIGHT;
				format.color = 0xffffff;
				
				var more: TextField = new TextField();
				more.defaultTextFormat = format;
				more.text = "Learn more";
				more.x = this.frame.x;
				more.y = this.frame.y;
				more.width = this.frame.width;
				more.height = 40.0;
				more.addEventListener(MouseEvent.CLICK, mouseClick);
				this.addChild(more);
				
				// call to success
				success();
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
				case "NetStream.Play.StreamNotFound": {
					trace("video error");
					error();
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
			trace("blaaaa");
			goToURL();
		}
	}
}