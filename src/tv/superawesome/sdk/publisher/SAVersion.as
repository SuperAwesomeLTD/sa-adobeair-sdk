// ActionScript file
package tv.superawesome.sdk.publisher {

	import tv.superawesome.sdk.publisher.SAExtensionContext;
	
	public class SAVersion {
	
		// version & sdk
		private static const version: String = "6.1.0";
		private static const sdk: String = "air";
		
		// getters
		public static function setVersionInNative (): void {
			SAExtensionContext.current().context().call("SuperAwesomeAIRVersionSetVersion", version, sdk);
		}
		
		private static function getVersion(): String {
			return version;
		}
		
		private static function getSdk(): String {
			return sdk;
		}
		
		public static function getSdkVersion(): String {
			return getSdk() + "_" + getVersion();
		}
	}
}
