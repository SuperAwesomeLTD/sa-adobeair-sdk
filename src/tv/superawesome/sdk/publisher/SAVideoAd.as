package tv.superawesome.sdk.publisher { 

	import com.adobe.serialization.json.JSON;
	
	import flash.events.StatusEvent;
	
	import tv.superawesome.sdk.publisher.SAExtensionContext;
	import tv.superawesome.sdk.publisher.SAVersion;
	import tv.superawesome.sdk.publisher.enums.SAConfiguration;
	import tv.superawesome.sdk.publisher.enums.SAEvent;
	import tv.superawesome.sdk.publisher.enums.SAOrientation;
	import tv.superawesome.sdk.publisher.SADefaults;

	public class SAVideoAd  {
		
		// the static video ad instance
		private static var staticInstance: SAVideoAd = null;
		
		// define a default callback so that it's never null and I don't have
		// to do a check every time I want to call it
		private static var callback: Function = function(pId: int, evt: int): void{};
		
		// assign default values to all of these fields
		private static var isParentalGateEnabled: Boolean 		  = SADefaults.defaultParentalGate();
		private static var orientation: int 					  = SADefaults.defaultOrientation();
		private static var configuration: int 					  = SADefaults.defaultConfiguration();
		private static var shouldShowCloseButton: Boolean 		  = SADefaults.defaultCloseButton();
		private static var shouldShowSmallClickButton: Boolean 	  = SADefaults.defaultSmallClick();
		private static var shouldAutomaticallyCloseAtEnd: Boolean = SADefaults.defaultCloseAtEnd();
		private static var isBackButtonEnabled: Boolean 	      = SADefaults.defaultBackButton();
		private static var isTestingEnabled: Boolean 			  = SADefaults.defaultTestMode();
		
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
			// just set version
			SAVersion.setVersionInNative();
			
			// add event listener
			SAExtensionContext.current().context().addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call to create the instance
			SAExtensionContext.current().context().call("SuperAwesomeAIRSAVideoAdCreate");
		}
		
		////////////////////////////////////////////////////////////
		// Interstitial specific methods
		////////////////////////////////////////////////////////////
		
		public static function load (placementId: int) : void {
			tryAndCreateOnce ();
			SAExtensionContext.current().context().call(
				"SuperAwesomeAIRSAVideoAdLoad", 
				placementId, 
				configuration, 
				isTestingEnabled
			);
		}
		
		public static function play (placementId: int): void {
			tryAndCreateOnce ();
			SAExtensionContext.current().context().call(
				"SuperAwesomeAIRSAVideoAdPlay", 
				placementId, 
				isParentalGateEnabled, 
				shouldShowCloseButton, 
				shouldShowSmallClickButton, 
				shouldAutomaticallyCloseAtEnd, 
				orientation,
				isBackButtonEnabled
			);
		}
		
		public static function hasAdAvailable (placementId: int): Boolean {
			tryAndCreateOnce ();
			var adAvailable: Boolean = SAExtensionContext.current().context().call(
				"SuperAwesomeAIRSAVideoAdHasAdAvailable", 
				placementId) as Boolean;
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
		
		public static function disableParentalGate (): void {
			isParentalGateEnabled = false;
		}
		
		public static function enableTestMode (): void {
			isTestingEnabled = true;
		}
		
		public static function disableTestMode (): void {
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
			orientation = SAOrientation.ANY;
		}
		
		public static function setOrientationPortrait (): void {
			orientation = SAOrientation.PORTRAIT;
		}
		
		public static function setOrientationLandscape (): void {
			orientation = SAOrientation.LANDSCAPE;
		}
		
		public static function enableBackButton (): void {
			isBackButtonEnabled = true;
		}
		
		public static function disableBackButton (): void {
			isBackButtonEnabled = false;
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
				if (call.indexOf ("adEmpty") >= 0) {
					callback (placement, SAEvent.adEmpty);
				}
				if (call.indexOf ("adFailedToLoad") >= 0) {
					callback (placement, SAEvent.adFailedToLoad);
				}
				if (call.indexOf("adAlreadyLoaded") >= 0) {
					callback (placement, SAEvent.adAlreadyLoaded);
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
				if (call.indexOf ("adEnded") >= 0) {
					callback (placement, SAEvent.adEnded);
				}
				if (call.indexOf ("adClosed") >= 0) {
					callback (placement, SAEvent.adClosed);
				}
			}
		}
	}
}