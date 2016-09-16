package tv.superawesome {
	
	import flash.external.ExtensionContext;
	
	public class SuperAwesome {
		
		// the extension context
		private var extContext: ExtensionContext; 
		
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
			
			// instrance 
			_instance = this;
		}
		
		// getters
		
		private function getVersion(): String {
			return "5.0.1";
		}
		
		private function getSdk(): String {
			return "air";
		}
		
		public function getSdkVersion(): String {
			return getSdk() + "_" + getVersion();
		}
		
		public function getContext () : ExtensionContext {
			return extContext;
		}
	}
}