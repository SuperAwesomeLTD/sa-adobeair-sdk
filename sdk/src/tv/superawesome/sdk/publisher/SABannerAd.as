package tv.superawesome.sdk.publisher {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.StatusEvent;
	
	import tv.superawesome.sdk.publisher.SAExtensionContext;
	import tv.superawesome.sdk.publisher.SAVersion;
	import tv.superawesome.sdk.publisher.enums.SABannerPosition;
	import tv.superawesome.sdk.publisher.enums.SAConfiguration;
	import tv.superawesome.sdk.publisher.enums.SAEvent;
	import tv.superawesome.sdk.publisher.SADefaults;

	public class SABannerAd  {
		
		// index
		private static var index: int = 0;
		
		// name of the ad
		private var name: String = null;
		
		// define a default callback so that it's never null and I don't have
		// to do a check every time I want to call it
		private var callback: Function = function(pId: int, evt: int): void{};
		
		// assign default values to all of these fields
		private var isParentalGateEnabled: Boolean 	= SADefaults.defaultParentalGate();
		private var isBumperPageEnabled: Boolean 	= SADefaults.defaultBumperPage();
		private var bannerWidth: int				= SADefaults.defaultBannerWidth();
		private var bannerHeight: int 				= SADefaults.defaultBannerHeight();
		private var color:Boolean 					= SADefaults.defaultBgColor();
		private var position:int 					= SADefaults.defaultBannerPosition();
		private var configuration: int		 		= SADefaults.defaultConfiguration();
		private var isTestingEnabled: Boolean 		= SADefaults.defaultTestMode();
		 
		// constructor
		public function SABannerAd () {
			// initial setup
			super ();
			this.name = "SABannerAd_" + (++SABannerAd.index);
			
			// just set version
			SAVersion.setVersionInNative();
			
			// add event listener
			SAExtensionContext.current().context().addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call create
			SAExtensionContext.current().context().call("SuperAwesomeAIRSABannerAdCreate", this.name);
 		}
		
		////////////////////////////////////////////////////////////
		// Banner specific methods
		////////////////////////////////////////////////////////////
		
		public function load (placementId: int) : void {
			SAExtensionContext.current().context().call(
				"SuperAwesomeAIRSABannerAdLoad", 
				this.name,
				placementId, 
				configuration, 
				isTestingEnabled
			);
		}
		
		public function hasAdAvailable (): Boolean {
			var adAvailable:Boolean = SAExtensionContext.current().context().call(
				"SuperAwesomeAIRSABannerAdHasAdAvailable", 
				this.name) as Boolean;
			return adAvailable;
		}
		
		public function play (): void {
			SAExtensionContext.current().context().call(
				"SuperAwesomeAIRSABannerAdPlay", 
				this.name,
				isParentalGateEnabled, 
				isBumperPageEnabled,
				position, 
				bannerWidth,
				bannerHeight,
				color
			);
		}
		
		public function close (): void {
			SAExtensionContext.current().context().call(
				"SuperAwesomeAIRSABannerAdClose",
				this.name
			);
		}
		
		////////////////////////////////////////////////////////////
		// Setters and getters
		////////////////////////////////////////////////////////////
		
		public function setCallback (call: Function): void {
			callback = call != null ? call : callback;
		}
		
		public function enableParentalGate (): void {
			isParentalGateEnabled = true;
		}
		
		public function disableParentalGate (): void {
			isParentalGateEnabled = false;
		}
		
		public function enableBumperPage (): void {
			isBumperPageEnabled = true;
		}
		
		public function disableBumperPage (): void {
			isBumperPageEnabled = false;
		}
		
		public function enableTestMode (): void {
			isTestingEnabled = true;
		}
		
		public function disableTestMode (): void {
			isTestingEnabled  = false; 
		}
		
		public function setConfigurationProduction (): void {
			configuration = SAConfiguration.PRODUCTION;
		}
		
		public function setConfigurationStaging (): void {
			configuration = SAConfiguration.STAGING;
		}
		
		public function setSize_300_50 (): void {
			bannerWidth = 300;
			bannerHeight = 50;
		}
		
		public function setSize_320_50 () : void {
			bannerWidth = 320;
			bannerHeight = 50;
		}
		
		public function setSize_728_90 (): void {
			bannerWidth = 728;
			bannerHeight = 90;
		}
		
		public function setSize_300_250 (): void {
			bannerWidth = 300;
			bannerHeight = 250;
		}
		
		public function setPositionTop (): void {
			position = SABannerPosition.TOP;
		}
		
		public function setPositionBottom (): void {
			position = SABannerPosition.BOTTOM;
		}
		
		public function setColorTransparent (): void {
			color = true;
		}
		
		public function setColorGray (): void {
			color = false;
		}

		////////////////////////////////////////////////////////////
		// Callback
		////////////////////////////////////////////////////////////
		
		private function nativeCallback(event:StatusEvent): void {
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
			if (callName != null && call != null && callName.indexOf(this.name) >= 0) {
				
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