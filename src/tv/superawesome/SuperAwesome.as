package tv.superawesome {
	
	import flash.external.ExtensionContext;
	
	import tv.superawesome.enums.SABannerPosition;
	import tv.superawesome.enums.SAConfiguration;
	import tv.superawesome.enums.SAOrientation;
	
	public class SuperAwesome {
		
		// the extension context
		private var extContext: ExtensionContext; 
		
		// version & sdk
		private const version: String = "5.3.2";
		private const sdk: String = "air";
		
		// singleton variable
		private static var _instance: SuperAwesome;
		public static function getInstance(): SuperAwesome {
			if (!_instance) { _instance = new SuperAwesome(); }
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
	}
}
