package tv.superawesome.Views {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import tv.superawesome.Data.Sender.SASender;
	import tv.superawesome.Views.SAVideoAdProtocol;
	
	public class SAVideoAd extends SAView {
		
		// private vars
		private var stream: NetStream;
		private var nc: NetConnection;
		private var videoBtn: Sprite;
		private var video: StageVideo;
		
		// public vars
		public var videoDelegate: SAVideoAdProtocol;
		
		// constructor
		public function SAVideoAd(frame:Rectangle){
			super(frame);
		}
		
		// display and delayed display functions
		public override function play(): void {
			if (stage) delayedDisplay();
			else addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		private function delayedDisplay(e:Event = null): void {
			this.stage.addEventListener( StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY , stageVideoState );
		}
		
		private function stageVideoState( e:StageVideoAvailabilityEvent ):void{
			
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
				more.addEventListener(MouseEvent.CLICK, goToURL);
				this.addChild(more);
				
				// call to success
				success();
			}
		}
		
		private function onStatus(stats: NetStatusEvent): void {
			var code:String = stats.info.code;
			switch (code) {
				case "NetStream.Play.Start":{
					trace("video started");
					
					// post VAST impression
					SASender.sendEventToURL(ad.creative.viewableImpressionURL);
					
					if (videoDelegate != null) {
						videoDelegate.videoStarted(ad.placementId);
					}
					break;
				}
				case "NetStream.Play.Stop": {
					trace("video stopped");
					
					// post VAST impression
					SASender.sendEventToURL(ad.creative.completeURL);
					
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
		
		private function onMetaData( info:Object ):void {
			// do nothing
		}
		
		private function onPlayStatus(info:Object): void {
			// do nothing
		}
	}
}