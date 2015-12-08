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
	
	//
	// @brief: Class that both extends SAView (to get access to a lot of
	// the useful functions provided by this) and uses a SABannerAd
	// to render an interstitial ad
	public class SAInterstitialAd extends SAView{
		
		// private vars
		private var background: Sprite;
		private var close: Sprite;
		private var banner:SABannerAd;
		
		// constructor
		public function SAInterstitialAd(){
			// call super
			super(new Rectangle(0, 0, 0, 0));
		}
		
		// on Resize - is called when rotating the phone, for example
		public function onResize(...ig): void {
			if (super.ad != null) {
				this.play();
			}
		}
		
		// override of play function
		public override function play(): void {	
			if (this.stage != null) delayedDisplay();
			else this.addEventListener(Event.ADDED_TO_STAGE, delayedDisplay);
		}
		
		private function delayedDisplay(e:Event = null): void {
			
			this.frame = new Rectangle(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			this.stage.addEventListener(Event.RESIZE, onResize);
			
			////////////////////////////////////////////////
			// 1. create background
			if (background == null) {
				[Embed(source = '../../../resources/bg.png')] var BgIconClass:Class;
				var bmp2:Bitmap = new BgIconClass();
				
				background = new Sprite();
				background.addChild(bmp2);
				this.addChildAt(background, 0);
			}
			
			background.x = super.frame.x;
			background.y = super.frame.y;
			background.width = super.frame.width;
			background.height = super.frame.height;
			
			////////////////////////////////////////////////
			// 2. create banner
			if (banner == null) {
				banner = new SABannerAd(new Rectangle(0, 0, 0, 0));
				banner.setAd(ad);
				banner.adDelegate = this.adDelegate;
				this.addChild(banner);
			}
			
			var tW: Number = super.frame.width * 0.85;
			var tH: Number = super.frame.height * 0.85;
			var tX: Number = ( super.frame.width - tW ) / 2;
			var tY: Number = ( super.frame.height - tH) / 2;
			banner.frame = new Rectangle(tX, tY, tW, tH);
			banner.play();
		
			////////////////////////////////////////////////
			// 3. create close button
			if (close == null) {
				[Embed(source = '../../../resources/close.png')] var CancelIconClass:Class;
				var bmp: Bitmap = new CancelIconClass();
				
				close = new Sprite();
				close.addEventListener(MouseEvent.CLICK, closeAction);
				close.addChild(bmp);
				this.addChildAt(close, 1);
			}
			
			var cS: Number = Math.min(super.frame.width, super.frame.height) * 0.15;
			close.x = super.frame.width - cS / 2.0;
			close.y = 0;
			close.width = cS / 2.0;
			close.height = cS / 2.0;
		}
		
		//
		// This function closes the interstitial
		private function closeAction(event: MouseEvent): void {
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