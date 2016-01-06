//
//  SAVideoAd.h
//  tv.superawesome.Views
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 02/12/2015.
//
//

package tv.superawesome.Views {
	
	// imports needed
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.events.StageVideoEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import tv.superawesome.Data.Models.SACreativeFormat;
	import tv.superawesome.Data.Sender.SASender;
	import tv.superawesome.Views.Protocols.SAVideoAdProtocol;
	
	//
	// @brief: a descendant of SAView that renders a video ad on screen
	public class SAVideoAd extends SAView {
		
		// private vars
		private var stream: NetStream;
		private var nc: NetConnection;
		private var video: StageVideo;
		
		// public vars
		public var videoDelegate: SAVideoAdProtocol;
		
		// constructor
		public function SAVideoAd(frame:Rectangle){
			super(frame);
		}
		
		// display and delayed display functions
		public override function play(): void {
			// check for wrong format
			if (ad.creative.format != SACreativeFormat.video) {
				if (this.adDelegate != null) {
					this.adDelegate.adHasIncorrectPlacement(ad.placementId);
				}
				return;
			}
			
			// go forward and display the ad
			if (stage) delayedDisplay();
			else addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		// close function
		public override function close(e: MouseEvent = null): void {
			stream.dispose();
			
			video.viewPort = new Rectangle(0, 0, 0, 0);
			video.attachNetStream(null);
			video = null;
			this.parent.removeChild(this);
		}
		
		private function delayedDisplay(e:Event = null): void {
			this.stage.addEventListener( StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY , stageVideoState );
		}
		
		// Stage Video Functions
		private function stageVideoState( e:StageVideoAvailabilityEvent ):void{
			
			var available:Boolean = e.availability == StageVideoAvailability.AVAILABLE ;
			
			if ( available ) {
				// net connection that plays the video
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
				
				// the "more" button
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
				var scope:Object = this;
				more.addEventListener(MouseEvent.CLICK, function (e:MouseEvent = null): void {
					scope.goToURL(null);
				});
				this.addChild(more);
			}
		}
		
		private function onStatus(stats: NetStatusEvent): void {
			var code:String = stats.info.code;
			switch (code) {
				case "NetStream.Play.Start":{
					trace("video started");
					
					// post VAST impression & other success stuff
					success();
					
					if (videoDelegate != null) {
						videoDelegate.videoStarted(ad.placementId);
					}
					break;
				}
				case "NetStream.Play.Stop": {
					trace("video stopped");
					
					// post VAST impression
					SASender.sendEventToURL(ad.creative.videoCompleteURL);
					
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
		
		// functions needed for the video
		public function onMetaData( info:Object ):void {
			// do nothing
		}
		
		public function onPlayStatus(info:Object): void {
			// do nothing
		}
	}
}