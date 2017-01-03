package tv.superawesome{ 

	import com.adobe.serialization.json.JSON;
	
	import flash.events.StatusEvent;
	
	import tv.superawesome.enums.SAConfiguration;
	import tv.superawesome.enums.SAEvent;
	import tv.superawesome.enums.SAOrientation;

	public class SAVideoAd  {
		
		// the static video ad instance
		private static var staticInstance: SAVideoAd = null;
		
		// define a default callback so that it's never null and I don't have
		// to do a check every time I want to call it
		private static var callback: Function = function(pId: int, evt: int): void{};
		
		// assign default values to all of these fields
		private static var isParentalGateEnabled: Boolean 		  = SuperAwesome.getInstance().defaultParentalGate();
		private static var orientation: int 					  = SuperAwesome.getInstance().defaultOrientation();
		private static var configuration: int 					  = SuperAwesome.getInstance().defaultConfiguration();
		private static var shouldShowCloseButton: Boolean 		  = SuperAwesome.getInstance().defaultCloseButton();
		private static var shouldShowSmallClickButton: Boolean 	  = SuperAwesome.getInstance().defaultSmallClick();
		private static var shouldAutomaticallyCloseAtEnd: Boolean = SuperAwesome.getInstance().defaultCloseAtEnd();
		private static var isBackButtonEnabled: Boolean 	      = SuperAwesome.getInstance().defaultBackButton();
		private static var isTestingEnabled: Boolean 			  = SuperAwesome.getInstance().defaultTestMode();
		
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
			// add callback
			SuperAwesome.getInstance().getContext().addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call to create the instance
			SuperAwesome.getInstance().getContext().call("SuperAwesomeAIRSAVideoAdCreate");
		}
		
		////////////////////////////////////////////////////////////
		// Interstitial specific methods
		////////////////////////////////////////////////////////////
		
		public static function load (placementId: int) : void {
			tryAndCreateOnce ();
			SuperAwesome.getInstance().getContext().call(
				"SuperAwesomeAIRSAVideoAdLoad", 
				placementId, 
				configuration, 
				isTestingEnabled
			);
		}
		
		public static function play (placementId: int): void {
			tryAndCreateOnce ();
			SuperAwesome.getInstance().getContext().call(
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
			var adAvailable: Boolean = SuperAwesome.getInstance().getContext().call(
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
			orientation = SAOrientation.ANY;
		}
		
		public static function setOrientationPortrait (): void {
			orientation = SAOrientation.PORTRAIT;
		}
		
		public static function setOrientationLandscape (): void {
			orientation = SAOrientation.LANDSCAPE;
		}
		
		public static function enabledBackButton (): void {
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
	}
}