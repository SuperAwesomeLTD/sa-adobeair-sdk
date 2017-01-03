package tv.superawesome {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.StatusEvent;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.enums.SABannerPosition;
	import tv.superawesome.enums.SAConfiguration;
	import tv.superawesome.enums.SAEvent;

	public class SABannerAd  {
		
		// index
		private static var index: int = 0;
		
		// name of the ad
		private var name: String = null;
		
		// define a default callback so that it's never null and I don't have
		// to do a check every time I want to call it
		private var callback: Function = function(pId: int, evt: int): void{};
		
		// assign default values to all of these fields
		private var isParentalGateEnabled: Boolean 	= SuperAwesome.getInstance().defaultParentalGate();
		private var bannerWidth: int				= SuperAwesome.getInstance().defaultBannerWidth();
		private var bannerHeight: int 				= SuperAwesome.getInstance().defaultBannerHeight();
		private var color:Boolean 					= SuperAwesome.getInstance().defaultBgColor();
		private var position:int 					= SuperAwesome.getInstance().defaultBannerPosition();
		private var configuration: int		 		= SuperAwesome.getInstance().defaultConfiguration();
		private var isTestingEnabled: Boolean 		= SuperAwesome.getInstance().defaultTestMode();
		 
		// constructor
		public function SABannerAd () {
			// initial setup
			super ();
			this.name = "SABannerAd_" + (++SABannerAd.index);
			
			// add event listener
			SuperAwesome.getInstance().getContext().addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call create
			SuperAwesome.getInstance().getContext().call("SuperAwesomeAIRSABannerAdCreate", this.name);
 		}
		
		////////////////////////////////////////////////////////////
		// Banner specific methods
		////////////////////////////////////////////////////////////
		
		public function load (placementId: int) : void {
			SuperAwesome.getInstance().getContext().call(
				"SuperAwesomeAIRSABannerAdLoad", 
				this.name,
				placementId, 
				configuration, 
				isTestingEnabled
			);
		}
		
		public function hasAdAvailable (): Boolean {
			var adAvailable:Boolean = SuperAwesome.getInstance().getContext().call(
				"SuperAwesomeAIRSABannerAdHasAdAvailable", 
				this.name) as Boolean;
			return adAvailable;
		}
		
		public function play (): void {
			SuperAwesome.getInstance().getContext().call(
				"SuperAwesomeAIRSABannerAdPlay", 
				this.name,
				isParentalGateEnabled, 
				position, 
				bannerWidth,
				bannerHeight,
				color
			);
		}
		
		public function close (): void {
			SuperAwesome.getInstance().getContext().call(
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
		
		public function disabledParentalGate (): void {
			isParentalGateEnabled = false;
		}
		
		public function enabledTestMode (): void {
			isTestingEnabled = true;
		}
		
		public function disabledTestMode (): void {
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