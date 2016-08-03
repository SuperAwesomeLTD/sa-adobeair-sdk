package tv.superawesome {
	public class SuperAwesome {
		
		/** constants */
		private const CONFIGURATION_PRODUCTION: int = 0;
		private const CONFIGURATION_STAGING: int = 1;
		
		/** variables */
		private var isTestEnabled: Boolean;
		private var configuration: int;
		
		/** singleton part */
		private static var _instance: SuperAwesome;
		public static function getInstance(): SuperAwesome {
			if (!_instance) { new SuperAwesome(); }
			return _instance;
		}
		
		/** the constructor, which acts as a Singleton */
		public function SuperAwesome() {
			if (_instance) {
				throw new Error("Singleton... use getInstance()");
			}
			
			this.setConfigurationProduction();
			this.disableTestMode();
			
			/** instrance */
			_instance = this;
		}
		
		// setters
		
		public function setConfiguration(config: int): void {
			if (config == CONFIGURATION_PRODUCTION) {
				setConfigurationProduction ();
			} else {
				setConfigurationStaging ();
			}
		}
		
		public function setConfigurationProduction(): void {
			configuration = CONFIGURATION_PRODUCTION;
		}
		
		public function setConfigurationStaging(): void {
			configuration = CONFIGURATION_STAGING;
		}
		
		public function setTestMode(testMode: Boolean): void {
			this.isTestEnabled = testMode;
		}
		
		public function enableTestMode(): void {
			this.isTestEnabled = true;
		}
		
		public function disableTestMode(): void {
			this.isTestEnabled = false;
		}
		
		// getters
		
		private function getVersion(): String {
			return "3.2.3";
		}
		
		private function getSdk(): String {
			return "air";
		}
		
		public function getSdkVersion(): String {
			return getSdk() + "_" + getVersion();
		}
		
		public function getConfiguration(): int {
			return configuration;
		}
		
		public function isTestingEnabled(): Boolean {
			return this.isTestEnabled;
		}
	}
}