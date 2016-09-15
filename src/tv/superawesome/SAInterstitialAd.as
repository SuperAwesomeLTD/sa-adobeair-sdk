package tv.superawesome {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import tv.superawesome.enums.SAConfiguration;
	import tv.superawesome.enums.SAEvent;
	import tv.superawesome.enums.SALockOrientation;
	
	public class SAInterstitialAd extends EventDispatcher {
		
		// static vars
		private static var extContext: ExtensionContext;
		
		private static var staticInstance: SAInterstitialAd = null;
		private static var isParentalGateEnabled: Boolean = true;
		private static var shouldLockOrientation: Boolean = false;
		private static var lockOrientation: int = SALockOrientation.ANY;
		private static var configuration: int = SAConfiguration.PRODUCTION;
		private static var isTestingEnabled: Boolean = false;
		private static var callback: Function = function(pId: int, evt: int): void{};
		
		// instance vars
		private static var name: String = "SAInterstitialAd";
		
		// func that creates a 
		private static function tryAndCreateOnce (): void {
			if (staticInstance == null) {
				staticInstance = new SAInterstitialAd();
			}
		}
		
		// constructor
		public function SAInterstitialAd () {
			// create extension context
			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.air", "" );
			if ( !extContext ) {
				throw new Error( "SuperAwesome native extension is not supported on this platform." );
			}
			
			// add event listener
			extContext.addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call to create the instance
			extContext.call("SuperAwesomeAIRSAInterstitialAdCreate");
		}
		
		////////////////////////////////////////////////////////////
		// Interstitial specific methods
		////////////////////////////////////////////////////////////
		
		public static function load (placementId: int) : void {
			tryAndCreateOnce ();
			extContext.call(
				"SuperAwesomeAIRSAInterstitialAdLoad", 
				placementId, 
				configuration, 
				isTestingEnabled
			);
		}
		
		public static function play (placementId: int): void {
			tryAndCreateOnce ();
			extContext.call(
				"SuperAwesomeAIRSAInterstitialAdPlay", 
				placementId, 
				isParentalGateEnabled, 
				shouldLockOrientation, 
				lockOrientation
			);
		}
		
		public static function hasAdAvailable (placementId: int): Boolean {
			tryAndCreateOnce ();
			var adAvailable: Boolean = extContext.call("SuperAwesomeAIRSAInterstitialAdHasAdAvailable", placementId) as Boolean;
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
			if (callName != null && call != null && callName.indexOf(SAInterstitialAd.name) >= 0) {
				
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