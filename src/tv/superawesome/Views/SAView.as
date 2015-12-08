//
//  SAView.h
//  tv.superawesome.Views
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 02/12/2015.
//
//

package tv.superawesome.Views {
	
	// imports needed for this class
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Sender.SASender;
	import tv.superawesome.Views.Protocols.SAAdProtocol;

	//
	// @brief: base class for Adobe AIR rendering
	public class SAView extends Sprite{
		// delegate
		public var delegate: SAAdProtocol;
		
		// private variables
		protected var ad: SAAd = null;
		
		// frame and aux variables
		public var frame: Rectangle;
		
		// public vars
		public var isParentalGateEnabled: Boolean;
		public var refreshPeriod: int;
		
		// constructor
		public function SAView(frame: Rectangle) {
			this.frame = frame;
		}		
		
		public function setAd(_ad: SAAd): void {
			this.ad = _ad;
		}
		
		// public play functions
		public function play(): void {
			// do nothing	
		}
		
		//
		// @brief: this function is called by descendats of SAView
		// when some the ad is loaded with success
		protected function success(e:Event = null): void {
			SASender.sendEventToURL(ad.creative.viewableImpressionURL);
			
			if (this.delegate != null) {
				this.delegate.adWasShown(this.ad.placementId);
			}
		}
		
		//
		// @brief: this function is called by descendants of SAView
		// when some error happened at Ad data loading
		protected function error(e:ErrorEvent = null): void {
			if (this.delegate != null) {
				this.delegate.adFailedToShow(this.ad.placementId);
			}
		}
		
		//
		// @brief: this function is called by descendants of SAView
		// when going from the ad / app to the linked URL
		protected function goToURL(e:LocationChangeEvent = null): void {
			// call delegate
			if (this.delegate != null) {
				this.delegate.adWasClicked(this.ad.placementId);
			}
			
			if(e != null) {
				e.preventDefault();
				e.stopImmediatePropagation();
			}
			
			if (!this.ad.creative.isFullClickURLReliable) {
				this.ad.creative.fullClickURL = this.ad.creative.trackingURL + "&redir=" + e.location;
			}
			
			var clickURL:URLRequest = new URLRequest(this.ad.creative.fullClickURL);
			navigateToURL(clickURL, "_blank");
		}
	}
}