package tv.superawesome.sdk.publisher
{
	public class SABumperPage {
		
		// the static interstitial ad instance
		private static var staticInstance: SABumperPage = null;
		
		// instance vars
		private static var name: String = "SABumperPage";
		
		// func that creates a 
		private static function tryAndCreateOnce (): void {
			if (staticInstance == null) {
				staticInstance = new SABumperPage();
			}
		}
		
		public function SABumperPage() {
			// do nothing
		}
		
		// getters
		public static function overrideName (name: String): void {
			tryAndCreateOnce ();
			SAExtensionContext.current().context().call("SuperAwesomeAIRBumperOverrideName", name);
		}
	}
}