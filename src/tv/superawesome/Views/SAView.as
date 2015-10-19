// ActionScript file

package tv.superawesome.Views {
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import tv.superawesome.Data.Loader.SALoader;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Sender.SASender;

	public class SAView extends Sprite{
		// delegate
		public var delegate: SAViewProtocol;
		
		// private variables
		private var placementId: int;
		protected var ad: SAAd = null;
		
		// frame and aux variables
		protected var frame: Rectangle;
		
		// public vars
		public var isParentalGateEnabled: Boolean;
		public var refreshPeriod: int;
		
		// constructor
		public function SAView(frame: Rectangle, placementId: int = 0) {
			this.frame = frame;
			this.placementId = placementId;
		}		
		
		public function setAd(_ad: SAAd): void {
			this.ad = _ad;
		}
		
		// public play functions
		public function playPreloaded(): void {
			if (this.ad == null) {
				if (this.delegate != null) {
					this.delegate.adFailedToShow(this.placementId);
				}
				return;
			}
			
			this.display();
		}
		
		public function playInstant(): void {
			// because ActionScript
			var localDisplay: Function = this.display;
			
			// load an Ad
			SALoader.getInstance().loadAd(this.placementId, function (_ad: SAAd): void {
				ad = _ad;
				localDisplay();
			},
				function(): void {
					// do nothing
				});
		}
		
		// Display function and it's sister funcs
		protected function display(): void {
			// do nothing
		}
		
		protected function arrangeAdInFrame(frame: Rectangle): Rectangle {
			
			var SW: Number = frame.width;
			var SH: Number = frame.height;
			var AW: Number = ad.creative.details.width;
			var AH: Number = ad.creative.details.height;
			if (AW == 1 || AW == 0) { AW = SW; }
			if (AH == 1 || AH == 0) { AH = SH; }
			
			var dW: Number = Math.min((SW/AW), 1);
			var dH: Number = Math.min((SH/AH), 1);
			var dT: Number = Math.min(dW, dH);
			
			var nW: Number = AW * dT;
			var nH: Number = AH * dT;
			var nX: Number = (SW - nW) / 2.0;
			var nY: Number = (SH - nH) / 2.0;
			
			return new Rectangle(nX, nY, nW, nH);
		}
		
		protected function success(e:Event = null): void {
			SASender.postEventViewableImpression(ad);
			
			if (this.delegate != null) {
				this.delegate.adWasShown(this.placementId);
			}
		}
		
		protected function error(e:ErrorEvent = null): void {
			SASender.postEventAdFailedToView(ad);
			
			if (this.delegate != null) {
				this.delegate.adFailedToShow(this.placementId);
			}
		}
		
		protected function goToURL(): void {
			SASender.postEventClick(ad);
			
			if (this.delegate != null) {
				this.delegate.adFollowedURL(this.placementId);
			}
			
			var clickURL: URLRequest = new URLRequest(this.ad.creative.clickURL);
			navigateToURL(clickURL, "_blank");
		}
	}
}