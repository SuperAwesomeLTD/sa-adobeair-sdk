package tv.superawesome {
	import com.adobe.serialization.json.JSON;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import tv.superawesome.SAAd;
	import tv.superawesome.interfaces.SAAdInterface;
	import tv.superawesome.interfaces.SAParentalGateInterface;
	import tv.superawesome.interfaces.SAVideoAdInterface;
	import tv.superawesome.interfaces.SAViewInterface;
	
	/**
	 * Extension-like implementation of the SAFullscreenVideoAd class
	 */
	public class SAFullscreenVideoAd extends EventDispatcher implements SAViewInterface {
		
		/** private vars of different sorts */
		private var extContext:ExtensionContext;
		private static var index: int = 0;
		private var name: String = null; 
		
		/** public vars */
		private var ad:SAAd = null; 
		public var isParentalGateEnabled:Boolean = true;
		public var shouldShowCloseButton:Boolean = true;
		public var shouldAutomaticallyCloseAtEnd:Boolean = true;
		public var shouldShowSmallClickButton:Boolean = false;
		public var shouldLockOrientation:Boolean = false;
		public var lockOrientation:int = SALockOrientation.ANY;
		
		/** delegates */
		public var adDelegate:SAAdInterface = null;
		public var parentalGateDelegate:SAParentalGateInterface = null;
		public var videoAdDelegate:SAVideoAdInterface = null;
		
		/** constructor */
		public function SAFullscreenVideoAd() {
			super();
			this.name = "SAFullscreenVideoAd_" + (++SAFullscreenVideoAd.index);
			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.air", "" );
			if ( !extContext ) {
				throw new Error( "SuperAwesome native extension is not supported on this platform." );
			}
			
			/** add the event listener for the SALoader class */
			extContext.addEventListener(StatusEvent.STATUS, nativeCallback);
		}
		
		/** <SAViewInterface>  **/
		public function setAd(ad: SAAd): void {
			this.ad = ad;
		}
		
		public function getAd(): SAAd {
			return this.ad;
		}
		
		public function play (): void {
			/** send external event to SA */
			extContext.call("playFullscreenVideoAd", this.name, this.ad.placementId, this.ad.adJson, 
							isParentalGateEnabled, shouldShowCloseButton, shouldAutomaticallyCloseAtEnd,
							shouldShowSmallClickButton, shouldLockOrientation, lockOrientation);
		}
		
		public function close(): void {
			/** send external event to SA */
			extContext.call("closeFullscreenVideoAd", this.name);
		}
		
		public function nativeCallback(event:StatusEvent): void {
			/** get data */
			var data: String = event.code;
			var content: String = event.level;
			
			/** make sense of the data */
			var meta: Object = com.adobe.serialization.json.JSON.decode(data);
			var name: String = meta.name;
			var func: String = meta.func;
			
			/** first make sure the event is for this object */
			if (name.indexOf(this.name) >= 0) {
				/** send events to AdDelegate object */
				if (func.indexOf("adWasShown") >= 0 && adDelegate != null) {
					adDelegate.adWasShown(ad.placementId);
				}
				if (func.indexOf("adFailedToShow") >= 0 && adDelegate != null) {
					adDelegate.adFailedToShow(ad.placementId);
				} 
				if (func.indexOf("adWasClosed") >= 0 && adDelegate != null) {
					adDelegate.adWasClosed(ad.placementId);
				}
				if (func.indexOf("adWasClicked") >= 0 && adDelegate != null) {
					adDelegate.adWasClicked(ad.placementId);
				}
				if (func.indexOf("adHasIncorrectPlacement") >= 0 && adDelegate != null) {
					adDelegate.adHasIncorrectPlacement(ad.placementId);
				}
				/** send events to ParentalGateDelegate object */
				if (func.indexOf("parentalGateWasCanceled") >= 0 && parentalGateDelegate != null) {
					parentalGateDelegate.parentalGateWasCanceled(ad.placementId);
				}
				if (func.indexOf("parentalGateWasFailed") >= 0 && parentalGateDelegate != null) {
					parentalGateDelegate.parentalGateWasFailed(ad.placementId);
				}
				if (func.indexOf("parentalGateWasSucceded") >= 0 && parentalGateDelegate != null) {
					parentalGateDelegate.parentalGateWasSucceded(ad.placementId);
				}
				/** send events to VideoAdDelegate object */
				if (func.indexOf("adStarted") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.adStarted(ad.placementId);
				}
				if (func.indexOf("videoStarted") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.videoStarted(ad.placementId);
				}
				if (func.indexOf("videoReachedFirstQuartile") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.videoReachedFirstQuartile(ad.placementId);
				}
				if (func.indexOf("videoReachedMidpoint") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.videoReachedMidpoint(ad.placementId);
				}
				if (func.indexOf("videoReachedThirdQuartile") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.videoReachedThirdQuartile(ad.placementId);
				}
				if (func.indexOf("videoEnded") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.videoEnded(ad.placementId);
				}
				if (func.indexOf("adEnded") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.adEnded(ad.placementId);
				}
				if (func.indexOf("allAdsEnded") >= 0 && videoAdDelegate != null) {
					videoAdDelegate.allAdsEnded(ad.placementId);
				}
			}
		}
	}
}