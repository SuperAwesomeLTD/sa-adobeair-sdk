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
	import tv.superawesome.Data.VAST.SAVASTParser;
	import tv.superawesome.Data.VAST.SAVASTProtocol;
	import tv.superawesome.Views.SAVideoAdProtocol;
	
	public class SAVideoAd extends SAView implements SAVASTProtocol {
		
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
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(new URLRequest (super.ad.creative.details.vast));
			xmlLoader.addEventListener(Event.COMPLETE, processXML);
		}
		
		private function processXML(e:Event):void {
			var myXML: XML = new XML(e.target.data);
			
			var parser: SAVASTParser = new SAVASTParser();
			parser.delegate = this;
			parser.simpleVASTParse(myXML);
		}
		
		public function didParseVAST(clickURL: String, impressionURL: String, completeURL: String): void {
			this.ad.creative.clickURL = clickURL;
			this.ad.creative.impresionURL = impressionURL;
			this.ad.creative.completeURL = completeURL;
			
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
			var code:String = stats.info.code;
			switch (code) {
				case "NetStream.Play.Start":{
					trace("video started");
					
					// post VAST impression
					SASender.postGeneric(ad.creative.impresionURL);
					
					if (videoDelegate != null) {
						videoDelegate.videoStarted(ad.placementId);
					}
					break;
				}
				case "NetStream.Play.Stop": {
					trace("video stopped");
					
					// post VAST impression
					SASender.postGeneric(ad.creative.completeURL);
					
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
			// do nothing
		}
		
		public function onPlayStatus(info:Object): void {
			// do nothing
		}
		
		public function mouseClick(event: MouseEvent): void {
			if (this.delegate != null) {
				this.delegate.adFollowedURL(super.ad.placementId);
			}
			
			trace("going to " + ad.creative.clickURL);
			var clickURL: URLRequest = new URLRequest(this.ad.creative.clickURL);
			navigateToURL(clickURL, "_blank");
		}
	}
}