package tv.superawesome.Views {
//	import com.google.ads.ima.api.AdErrorEvent;
//	import com.google.ads.ima.api.AdEvent;
//	import com.google.ads.ima.api.AdsLoader;
//	import com.google.ads.ima.api.AdsManager;
//	import com.google.ads.ima.api.AdsManagerLoadedEvent;
//	import com.google.ads.ima.api.AdsRenderingSettings;
//	import com.google.ads.ima.api.AdsRequest;
//	import com.google.ads.ima.api.ViewModes;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
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
	
	import tv.superawesome.Data.Sender.SASender;
	import tv.superawesome.Views.SAVideoAdProtocol;
	
	public class SAVideoAd extends SAView{
		
		// private vars
		private var stream: NetStream;
		private var nc: NetConnection;
		private var videoBtn: Sprite;
		private var video: StageVideo;
		
//		private var contentPlayheadTime:Number;
//		private var adsLoader: AdsLoader;
//		private var adsManager: AdsManager;
//		private var videoFrame: Rectangle;
		
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
		
//				videoFrame = super.frame;
//				
//				adsLoader = new AdsLoader();
//				adsLoader.loadSdk();
//				adsLoader.addEventListener(AdsManagerLoadedEvent.ADS_MANAGER_LOADED, adsManagerLoadedHandler);
//				adsLoader.addEventListener(AdErrorEvent.AD_ERROR, adsLoadErrorHandler);
//				
//				var adsRequest: AdsRequest = new AdsRequest();
//				adsRequest.adTagUrl = super.ad.creative.details.vast;
//				adsRequest.linearAdSlotWidth = videoFrame.width;
//				adsRequest.linearAdSlotHeight = videoFrame.height;
//				adsRequest.nonLinearAdSlotWidth = videoFrame.width;
//				adsRequest.nonLinearAdSlotHeight = videoFrame.height;
//				
//				adsLoader.requestAds(adsRequest);
				
				// call to success
				success();
			}
		}
		
//		private function adsManagerLoadedHandler(event:AdsManagerLoadedEvent):void {
//			var adsRenderingSettings:AdsRenderingSettings = new AdsRenderingSettings();
//			
//			var contentPlayhead:Object = {};
//			contentPlayhead.time = function():Number {
//				return contentPlayheadTime * 1000; // convert to milliseconds.
//			};
//			
//			adsManager = event.getAdsManager(contentPlayhead, adsRenderingSettings);
//			
//			if (adsManager) {
//				adsManager.addEventListener(AdEvent.LOADED, adsManagerAdLoadedHandler);
//				adsManager.addEventListener(AdEvent.STARTED, adsManagerStartedHandler);
//				adsManager.addEventListener(AdEvent.ALL_ADS_COMPLETED, allAdsCompletedHandler);
//				adsManager.addEventListener(AdErrorEvent.AD_ERROR, adsManagerPlayErrorHandler);
//				adsManager.addEventListener(AdEvent.CONTENT_PAUSE_REQUESTED, adsManagerContentPauseRequestedHandler);
//				adsManager.addEventListener(AdEvent.CONTENT_RESUME_REQUESTED, adsManagerContentResumeRequestedHandler);
//				adsManager.addEventListener(AdEvent.FIRST_QUARTILE, adsManagerFirstQuartileHandler);
//				adsManager.addEventListener(AdEvent.MIDPOINT, adsManagerMidpointHandler);
//				adsManager.addEventListener(AdEvent.THIRD_QUARTILE, adsManagerThirdQuartileHandler);
//				adsManager.addEventListener(AdEvent.CLICKED, adsManagerOnClick);
//				
//				adsManager.handshakeVersion("1.0");
//				adsManager.init(videoFrame.width, videoFrame.height, ViewModes.IGNORE);
//				
//				adsManager.adsContainer.x = videoFrame.x;
//				adsManager.adsContainer.y = videoFrame.y;
//				
//				DisplayObjectContainer(this.stage).addChild(adsManager.adsContainer);
//				
//				adsManager.start();
//			}
//		}
//		
//		private function adsManagerAdLoadedHandler(event:AdEvent): void {
//			// loaded
//		}
//		
//		private function adsManagerStartedHandler(event:AdEvent): void {
//			if (videoDelegate != null) {
//				videoDelegate.videoStarted(ad.placementId);
//			}
//		}
//		
//		private function adsManagerContentPauseRequestedHandler(event:AdEvent): void {
//			// not in use	
//		}
//		
//		private function adsManagerContentResumeRequestedHandler(event:AdEvent): void {
//			// not in use
//		}
//		
//		private function adsManagerFirstQuartileHandler(event:AdEvent): void {
//			if (videoDelegate != null) {
////				videoDelegate.videoReachedFirstQuartile(ad.placementId);
//			}
//		}
//		
//		private function adsManagerMidpointHandler(event:AdEvent): void {
//			if (videoDelegate != null) {
////				videoDelegate.videoReachedMidpoint(ad.placementId);
//			}
//		}
//		
//		private function adsManagerThirdQuartileHandler(event:AdEvent): void {
//			if (videoDelegate != null) {
////				videoDelegate.videoReachedThirdQuartile(ad.placementId);
//			}
//		}
//		
//		private function allAdsCompletedHandler(event:AdEvent):void {
//			destroyAdsManager();
//			
//			if (videoDelegate != null) {
//				videoDelegate.videoEnded(ad.placementId);
//			}
//		}
//		
//		private function adsLoadErrorHandler(event:AdErrorEvent):void {
////			video.play();
//			error();
//		}
//		
//		private function adsManagerPlayErrorHandler(event:AdErrorEvent):void {
//			destroyAdsManager();
////			videoPlayer.play();
//			error();
//		}
//		
//		private function adsManagerOnClick(event: AdEvent): void {
//			SASender.postEventClick(ad);
//			
//			if (super.delegate != null) {
////				super.delegate.adFollowedURL(super.placementId);
//			}
//		}
//		
//		// some other aux functions
//		
//		private function destroyAdsManager():void {
//			if (adsManager) {
//				if (adsManager.adsContainer.parent &&
//					adsManager.adsContainer.parent.contains(adsManager.adsContainer)) {
//					adsManager.adsContainer.parent.removeChild(adsManager.adsContainer);
//				}
//				adsManager.destroy();
//			}
//		}
		
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