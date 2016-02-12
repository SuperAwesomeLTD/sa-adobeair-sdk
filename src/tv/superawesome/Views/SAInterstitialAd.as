//
//  SAInterstitialAd.h
//  tv.superawesome.Views
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 02/12/2015.
//
//

package tv.superawesome.Views{
	
	// imports
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import tv.superawesome.Data.Models.SACreativeFormat;
	
	//
	// @brief: Class that both extends SAView (to get access to a lot of
	// the useful functions provided by this) and uses a SABannerAd
	// to render an interstitial ad
	public class SAInterstitialAd extends SAView{
		
		// private vars
		private var background: Sprite = new Sprite();
		private var closeBtn: Sprite = new Sprite();
		private var banner:SABannerAd = new SABannerAd(new Rectangle(0, 0, 0, 0));
		
		// external resources
		[Embed(source = '../../../resources/bg.png')] private var BgIconClass:Class;
		private var bmp2:Bitmap = new BgIconClass();
		
		// external resources
		[Embed(source = '../../../resources/close.png')] private var CancelIconClass:Class;
		private var bmp: Bitmap = new CancelIconClass();
		
		// constructor
		public function SAInterstitialAd(){
			// call super
			super(new Rectangle(0, 0, 0, 0));
		}
		
		// on Resize - is called when rotating the phone, for example
		public function onResize(...ig): void {
			if (super.ad != null) {
				// update frame
				this.frame = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
				
				// rearrange background
				background.x = super.frame.x;
				background.y = super.frame.y;
				background.width = super.frame.width;
				background.height = super.frame.height;
				
				// rearrange close btn
				var cS: Number = Math.min(this.frame.width, this.frame.height) * 0.15;
				closeBtn.x = this.frame.width - cS / 2.0;
				closeBtn.y = 0;
				closeBtn.width = cS / 2.0;
				closeBtn.height = cS / 2.0;
			
				// rearrange banner
				var tW: Number = super.frame.width * 0.85;
				var tH: Number = super.frame.height * 0.85;
				var tX: Number = ( super.frame.width - tW ) / 2;
				var tY: Number = ( super.frame.height - tH) / 2;
				banner.frame = new Rectangle(tX, tY, tW, tH);
				if (banner != null){
					banner.play();
				}
			}
		}
		
		// override of play function
		public override function play(): void {	
			// check for wrong format
			if (ad.creative.format == SACreativeFormat.video) {
				if (this.adDelegate != null) {
					this.adDelegate.adHasIncorrectPlacement(ad.placementId);
				}
				return;
			}
			
			if (this.stage != null) delayedDisplay();
			else this.addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		private function delayedDisplay(e:Event = null): void {
			
			// get the new frame
			this.frame = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			
			// add resize listener
			this.stage.addEventListener(Event.RESIZE, onResize);
			
			// create the elements background
			background.addChild(bmp2);
			this.addChildAt(background, 0);
			
			banner.setAd(ad);
			banner.adDelegate = this.adDelegate;
			this.addChild(banner);
			if (banner != null) {
				banner.play();	
			}
			
			closeBtn.addEventListener(MouseEvent.CLICK, close);
			closeBtn.addChild(bmp);
			this.addChildAt(closeBtn, 1);
			
			// call on resize to resize them all
			this.onResize();
		}
		
		//
		// This function closes the interstitial
		public override function close(event: MouseEvent = null): void {
			// remove this
			this.stage.removeEventListener(Event.RESIZE, onResize);
			
			// call remove child
			banner.stop();
			parent.removeChild(this);
			
			// call delegate
			if (super.adDelegate != null) {
				super.adDelegate.adWasClosed(ad.placementId);
			}
		}
	}
}