package tv.superawesome {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import tv.superawesome.enums.SABannerPosition;
	import tv.superawesome.enums.SAConfiguration;
	import tv.superawesome.enums.SAOrientation;
	
	public class SuperAwesome {
		
		// the extension context
		private var extContext: ExtensionContext; 
		
		// define a default callback so that it's never null and I don't have
		// to do a check every time I want to call it
		private var cpiCallback: Function = function(success: Boolean): void{};
		
		// instance vars
		private static var name: String = "SAAIRSuperAwesome";
		
		// version & sdk
		private const version: String = "5.1.7";
		private const sdk: String = "air";
		
		// singleton variable
		private static var _instance: SuperAwesome;
		public static function getInstance(): SuperAwesome {
			if (!_instance) { new SuperAwesome(); }
			return _instance;
		}
		
		// constructor for static
		public function SuperAwesome() {
			if (_instance) {
				throw new Error("Singleton... use getInstance()");
			}
			
			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.air", "" );
			if ( !extContext ) {
				throw new Error( "SuperAwesome native extension is not supported on this platform." );
			}
			
			// add event listener
			extContext.addEventListener(StatusEvent.STATUS, nativeCallback);
			
			// call the version method
			extContext.call("SuperAwesomeAIRSuperAwesomeSetVersion", version, sdk);
			
			// instrance 
			_instance = this;
		}
		
		// getters
		
		private function getVersion(): String {
			return version;
		}
		
		private function getSdk(): String {
			return sdk;
		}
		
		public function getSdkVersion(): String {
			return getSdk() + "_" + getVersion();
		}
		
		public function getContext () : ExtensionContext {
			return extContext;
		}
		
		public function handleCPI (callback: Function): void {
			cpiCallback = callback != null ? callback : cpiCallback;
			extContext.call("SuperAwesomeAIRSuperAwesomeHandleCPI");
		}
		
		// default values
		
		public function defaultPlacementId (): int {
			return 0;
		}
		
		public function defaultTestMode (): Boolean {
			return false;
		}
		
		public function defaultParentalGate (): Boolean {
			return true;
		}
		
		public function defaultConfiguration (): int {
			return SAConfiguration.PRODUCTION;
		}
		
		public function defaultOrientation (): int {
			return SAOrientation.ANY;
		}
		
		public function defaultCloseButton (): Boolean {
			return false;
		}
		
		public function defaultSmallClick (): Boolean {
			return false;
		}
		
		public function defaultCloseAtEnd (): Boolean {
			return true;
		}
		
		public function defaultBackButton (): Boolean {
			return false;
		}
		
		public function defaultBgColor (): Boolean {
			return false;
		}
		
		public function defaultBannerPosition (): int {
			return SABannerPosition.BOTTOM;
		}
		
		public function defaultBannerWidth (): int {
			return 320;
		}
		
		public function defaultBannerHeight (): int {
			return 50;
		}
		
		////////////////////////////////////////////////////////////
		// Callback
		////////////////////////////////////////////////////////////
		
		public function nativeCallback(event:StatusEvent): void {
			// get data
			var data: String = event.code;
			var content: String = event.level;
			
			// parse data
			var meta: Object = com.adobe.serialization.json.JSON.decode(data);
			var callName:String = null;
			var success:Boolean = false;
			var call:String = null;
			
			// get properties (right way)
			if (meta.hasOwnProperty("name")) {
				callName = meta.name;
			}
			if (meta.hasOwnProperty("success")) {
				success = meta.success;
			}
			if (meta.hasOwnProperty("callback")) {
				call = meta.callback;
			}
			
			// check to see target
			if (callName != null && call != null && callName.indexOf(name) >= 0) {
				
				if (call.indexOf("HandleCPI") >= 0) {
					this.cpiCallback (success);
				}
			}
		}
	}
}