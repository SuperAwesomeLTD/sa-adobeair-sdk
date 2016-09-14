package tv.superawesome {
	import com.adobe.serialization.json.JSON;
	
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import tv.superawesome.enums.SABannerColor;
	import tv.superawesome.enums.SABannerPosition;
	import tv.superawesome.enums.SABannerSize;
	import tv.superawesome.enums.SAConfiguration;
	import tv.superawesome.enums.SAEvent;

//	import flash.external.ExtensionContext;
//	import flash.geom.Rectangle;
//	
//	import tv.superawesome.SAAd;
//	import tv.superawesome.interfaces.SAAdInterface;
//	import tv.superawesome.interfaces.SAParentalGateInterface;
//	import tv.superawesome.interfaces.SAViewInterface;
//	
//	/**
//	 * Extension-like implementation of the SABannerAd class
//	 */
	public class SABannerAd  {
		
		// index
		private static var index: int = 0;
		
		// static vars
		private var extContext: ExtensionContext;
		
		private var name: String = null;
		
		private static var isParentalGateEnabled: Boolean = true;
		private var size:int = SABannerSize.LEADER_320_50;
		private var color:int = SABannerColor.GRAY;
		private var position:int = SABannerPosition.TOP;
		private var configuration: int = SAConfiguration.PRODUCTION;
		private var isTestingEnabled: Boolean = false;
		private var callback: Function = function(pId: int, evt: int): void{};
		 
		// constructor
		public function SABannerAd () {
			// initial setup
			super ();
			this.name = "SABannerAd_" + (++SABannerAd.index);
			
			// create the context
			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.air", "" );
			if ( !extContext ) {
				throw new Error( "SuperAwesome native extension is not supported on this platform." );
			}
			
			// add event listener
			extContext.addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call create
			extContext.call("SuperAwesomeAIRSABannerAdCreate", this.name);
 		}
		
		////////////////////////////////////////////////////////////
		// Banner specific methods
		////////////////////////////////////////////////////////////
		
		public function load (placementId: int) : void {
			extContext.call(
				"SuperAwesomeAIRSABannerAdLoad", 
				this.name,
				placementId, 
				configuration, 
				isTestingEnabled
			);
		}
		
		public function hasAdAvailable (): Boolean {
			var adAvailable:Boolean = extContext.call("SuperAwesomeAIRSABannerAdHasAdAvailable", this.name) as Boolean;
			return adAvailable;
		}
		
		public function play (): void {
			extContext.call(
				"SuperAwesomeAIRSABannerAdPlay", 
				this.name,
				isParentalGateEnabled, 
				position, 
				size,
				color
			);
		}
		
		public function close (): void {
			extContext.call(
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
			size = SABannerSize.LEADER_300_50;
		}
		
		public function setSize_320_50 () : void {
			size = SABannerSize.LEADER_320_50;
		}
		
		public function setSize_728_90 (): void {
			size = SABannerSize.LEADER_720_90;
		}
		
		public function setSize_300_250 (): void {
			size = SABannerSize.MPU_300_250;
		}
		
		public function setPositionTop (): void {
			position = SABannerPosition.TOP;
		}
		
		public function setPositionBottom (): void {
			position = SABannerPosition.BOTTOM;
		}
		
		public function setColorTransparent (): void {
			color = SABannerColor.TRANSPARENT;
		}
		
		public function setColorGray (): void {
			color = SABannerColor.GRAY;
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
		
//		
//		/** private vars of different sorts */
//		private var extContext:ExtensionContext;
//		private static var index: int = 0;
//		private var name: String = null; 
//		
//		/** public vars */
//		private var ad:SAAd = null; 
//		public var isParentalGateEnabled:Boolean = true;
//		public var frame:Rectangle;
//		
//		/** delegates */
//		public var adDelegate:SAAdInterface = null;
//		public var parentalGateDelegate:SAParentalGateInterface = null;
//		
//		public function SABannerAd(frame: Rectangle) {
//			super();
//			this.frame = frame;
//			this.name = "SABannerAd_" + (++SABannerAd.index);
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
//			extContext.call("playBannerAd", this.name, this.ad.placementId, this.ad.adJson, isParentalGateEnabled, 
//							this.frame.x, this.frame.y, this.frame.width, this.frame.height);
//		}
//		
//		public function close(): void {
//			/** send external event to SA */
//			extContext.call("closeBannerAd", this.name);
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
//			}
//		}
	}
}