// ActionScript file
package tv.superawesome.sdk.publisher {
	
	import flash.external.ExtensionContext;
	
	public class SAExtensionContext {
		
		// the extension context
		private var extContext: ExtensionContext; 
			
		// singleton variable
		private static var _instance: SAExtensionContext;
		public static function current(): SAExtensionContext {
			if (!_instance) { _instance = new SAExtensionContext(); }
			return _instance;
		}
		
		// constructor for static
		public function SAExtensionContext() {
			if (_instance) {
				throw new Error("Singleton... use getInstance()");
			}
			
			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.publisher.air", "" );
			if ( !extContext ) {
				throw new Error( "SuperAwesome native extension is not supported on this platform." );
			}
			
			// instrance 
			_instance = this;
		}
		
		public function context () : ExtensionContext {
			return extContext;
		}
	}
}