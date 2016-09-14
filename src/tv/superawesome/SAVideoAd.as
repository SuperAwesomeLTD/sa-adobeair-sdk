package tv.superawesome{ 
//	import com.adobe.serialization.json.JSON;
//	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import tv.superawesome.enums.SAConfiguration;
	import tv.superawesome.enums.SAEvent;
	import tv.superawesome.enums.SALockOrientation;

//	import flash.geom.Rectangle;
//	
//	import tv.superawesome.SAAd;
//	import tv.superawesome.interfaces.SAAdInterface;
//	import tv.superawesome.interfaces.SAParentalGateInterface;
//	import tv.superawesome.interfaces.SAVideoAdInterface;
//	import tv.superawesome.interfaces.SAViewInterface;
//	
//	/**
//	 * Extension-like implementation of the SAVideoAd class
//	 */
	public class SAVideoAd  {
		
		// private static vars
		private static var extContext: ExtensionContext;
		
		private static var staticInstance: SAVideoAd = null;
		private static var isParentalGateEnabled: Boolean = true;
		private static var shouldLockOrientation: Boolean = false;
		private static var lockOrientation: int = SALockOrientation.ANY;
		private static var configuration: int = SAConfiguration.PRODUCTION;
		private static var shouldShowCloseButton: Boolean = true;
		private static var shouldShowSmallClickButton: Boolean = false;
		private static var shouldAutomaticallyCloseAtEnd: Boolean = true;
		private static var isTestingEnabled: Boolean = false;
		private static var callback: Function = function(pId: int, evt: int): void{};
		
		// instance vars
		private static var name: String = "SAVideoAd";
		
		// func that creates a 
		private static function tryAndCreateOnce (): void {
			if (staticInstance == null) {
				staticInstance = new SAVideoAd();
			}
		}
		
		// constructor
		public function SAVideoAd () {
			// create extension context
			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.air", "" );
			if ( !extContext ) {
				throw new Error( "SuperAwesome native extension is not supported on this platform." );
			}
			
			// add callback
			extContext.addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call to create the instance
			extContext.call("SuperAwesomeAIRSAVideoAdCreate");
		}
		
		////////////////////////////////////////////////////////////
		// Interstitial specific methods
		////////////////////////////////////////////////////////////
		
		public static function load (placementId: int) : void {
			tryAndCreateOnce ();
			extContext.call(
				"SuperAwesomeAIRSAVideoAdLoad", 
				placementId, 
				configuration, 
				isTestingEnabled
			);
		}
		
		public static function play (placementId: int): void {
			tryAndCreateOnce ();
			extContext.call(
				"SuperAwesomeAIRSAVideoAdPlay", 
				placementId, 
				isParentalGateEnabled, 
				shouldShowCloseButton, 
				shouldShowSmallClickButton, 
				shouldAutomaticallyCloseAtEnd, 
				shouldLockOrientation, 
				lockOrientation
			);
		}
		
		public static function hasAdAvailable (placementId: int): Boolean {
			tryAndCreateOnce ();
			var adAvailable: Boolean = extContext.call("SuperAwesomeAIRSAVideoAdHasAdAvailable", placementId) as Boolean;
			return adAvailable;
		}
		
		////////////////////////////////////////////////////////////
		// Setters and getters
		////////////////////////////////////////////////////////////
		
		public static function setCallback (call: Function): void {
			callback = call != null ? call : callback;
		}
		
		public static function enableParentalGate (): void {
			isParentalGateEnabled = true;
		}
		
		public static function disabledParentalGate (): void {
			isParentalGateEnabled = false;
		}
		
		public static function enabledTestMode (): void {
			isTestingEnabled = true;
		}
		
		public static function disabledTestMode (): void {
			isTestingEnabled  = false; 
		}
		
		public static function enableCloseButton (): void {
			shouldShowCloseButton = true;
		}
		
		public static function disableCloseButton (): void {
			shouldShowCloseButton = false;
		}
		
		public static function enableSmallClickButton (): void {
			shouldShowSmallClickButton = true;
		}
		
		public static function disableSmallClickButton (): void {
			shouldShowSmallClickButton = false;
		}
		
		public static function enableCloseAtEnd (): void {
			shouldAutomaticallyCloseAtEnd = true;
		}
		
		public static function disableCloseAtEnd (): void {
			shouldAutomaticallyCloseAtEnd = false;
		}
		
		public static function setConfigurationProduction (): void {
			configuration = SAConfiguration.PRODUCTION;
		}
		
		public static function setConfigurationStaging (): void {
			configuration = SAConfiguration.STAGING;
		}
		
		public static function setOrientationAny (): void {
			shouldLockOrientation = false;
			lockOrientation = SALockOrientation.ANY;
		}
		
		public static function setOrientationPortrait (): void {
			shouldLockOrientation = true;
			lockOrientation = SALockOrientation.PORTRAIT;
		}
		
		public static function setOrientationLandscape (): void {
			shouldLockOrientation = true;
			lockOrientation = SALockOrientation.LANDSCAPE;
		}
		
		////////////////////////////////////////////////////////////
		// Callback
		////////////////////////////////////////////////////////////
		
		public static function nativeCallback(event:StatusEvent): void {
			// get data
			var data: String = event.code;
			var content: String = event.level;
			
			// parse data
			var meta: Object = com.adobe.serialization.json.JSON.decode(data);
			var callName:String = null;
			var placement:int = 0;
			var call:String = null;
			
			// get properties (right way)
			if (meta.hasOwnProperty("name")) {
				callName = meta.name;
			}
			if (meta.hasOwnProperty("placementId")) {
				placement = meta.placementId;
			}
			if (meta.hasOwnProperty("callback")) {
				call = meta.callback;
			}
			
			// check to see target
			if (callName != null && call != null && callName.indexOf(SAVideoAd.name) >= 0) {
				
				if (call.indexOf ("adLoaded") >= 0) {
					callback (placement, SAEvent.adLoaded);
				}
				if (call.indexOf ("adFailedToLoad") >= 0) {
					callback (placement, SAEvent.adFailedToLoad);
				}
				if (call.indexOf ("adShown") >= 0) {
					callback (placement, SAEvent.adShown);
				}
				if (call.indexOf ("adFailedToShow") >= 0) {
					callback (placement, SAEvent.adFailedToShow);
				}
				if (call.indexOf ("adClicked") >= 0) {
					callback (placement, SAEvent.adClicked);
				}
				if (call.indexOf ("adClosed") >= 0) {
					callback (placement, SAEvent.adClosed);
				}
			}
		}
		
//		/** private vars of different sorts */
//		private var extContext:ExtensionContext;
//		private static var index: int = 0;
//		private var name: String = null; 
//		
//		/** public vars */
//		private var ad:SAAd = null; 
//		public var frame:Rectangle;
//		public var isParentalGateEnabled:Boolean = true;
//		public var shouldShowCloseButton:Boolean = true;
//		public var shouldAutomaticallyCloseAtEnd:Boolean = true;
//		public var shouldShowSmallClickButton:Boolean = false;
//		
//		/** delegates */
//		public var adDelegate:SAAdInterface = null;
//		public var parentalGateDelegate:SAParentalGateInterface = null;
//		public var videoAdDelegate:SAVideoAdInterface = null;
//		
//		public function SAVideoAd(frame: Rectangle) {
//			super();
//			this.frame = frame;
//			this.name = "SAVideoAd_" + (++SAVideoAd.index);
//			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.air", "" );
//			if ( !extContext ) {
//				throw new Error( "SuperAwesome native extension is not supported on this platform." );
//			}
//			
//			/** add the event listener for the SALoader class */
//			extContext.addEventListener(StatusEvent.STATUS, nativeCallback);
//		}
//		
//		/** <SAViewInterface>  **/
//		public function setAd(ad: SAAd): void {
//			this.ad = ad;
//		}
//		
//		public function getAd(): SAAd {
//			return this.ad;
//		}
//		
//		public function play (): void {
//			/** send external event to SA */
//			extContext.call("playVideoAd", this.name, this.ad.placementId, this.ad.adJson, isParentalGateEnabled, shouldShowSmallClickButton,
//							this.frame.x, this.frame.y, this.frame.width, this.frame.height);
//		}
//		
//		public function close(): void {
//			/** send external event to SA */
//			extContext.call("closeVideoAd", this.name);
//		}
//		
//		public function nativeCallback(event:StatusEvent): void {
//			/** get data */
//			var data: String = event.code;
//			var content: String = event.level;
//			
//			/** make sense of the data */
//			var meta: Object = com.adobe.serialization.json.JSON.decode(data);
//			var name: String = meta.name;
//			var func: String = meta.func;
//			
//			/** first make sure the event is for this object */
//			if (name.indexOf(this.name) >= 0) {
//				/** send events to AdDelegate object */
//				if (func.indexOf("adWasShown") >= 0 && adDelegate != null) {
//					adDelegate.adWasShown(ad.placementId);
//				}
//				if (func.indexOf("adFailedToShow") >= 0 && adDelegate != null) {
//					adDelegate.adFailedToShow(ad.placementId);
//				} 
//				if (func.indexOf("adWasClosed") >= 0 && adDelegate != null) {
//					adDelegate.adWasClosed(ad.placementId);
//				}
//				if (func.indexOf("adWasClicked") >= 0 && adDelegate != null) {
//					adDelegate.adWasClicked(ad.placementId);
//				}
//				if (func.indexOf("adHasIncorrectPlacement") >= 0 && adDelegate != null) {
//					adDelegate.adHasIncorrectPlacement(ad.placementId);
//				}
//				/** send events to ParentalGateDelegate object */
//				if (func.indexOf("parentalGateWasCanceled") >= 0 && parentalGateDelegate != null) {
//					parentalGateDelegate.parentalGateWasCanceled(ad.placementId);
//				}
//				if (func.indexOf("parentalGateWasFailed") >= 0 && parentalGateDelegate != null) {
//					parentalGateDelegate.parentalGateWasFailed(ad.placementId);
//				}
//				if (func.indexOf("parentalGateWasSucceded") >= 0 && parentalGateDelegate != null) {
//					parentalGateDelegate.parentalGateWasSucceded(ad.placementId);
//				}
//				/** send events to VideoAdDelegate object */
//				if (func.indexOf("adStarted") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.adStarted(ad.placementId);
//				}
//				if (func.indexOf("videoStarted") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.videoStarted(ad.placementId);
//				}
//				if (func.indexOf("videoReachedFirstQuartile") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.videoReachedFirstQuartile(ad.placementId);
//				}
//				if (func.indexOf("videoReachedMidpoint") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.videoReachedMidpoint(ad.placementId);
//				}
//				if (func.indexOf("videoReachedThirdQuartile") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.videoReachedThirdQuartile(ad.placementId);
//				}
//				if (func.indexOf("videoEnded") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.videoEnded(ad.placementId);
//				}
//				if (func.indexOf("adEnded") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.adEnded(ad.placementId);
//				}
//				if (func.indexOf("allAdsEnded") >= 0 && videoAdDelegate != null) {
//					videoAdDelegate.allAdsEnded(ad.placementId);
//				}
//			}
//		}
	}
}