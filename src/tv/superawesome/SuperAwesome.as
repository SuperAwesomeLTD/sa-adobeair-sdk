package tv.superawesome {
	public class SuperAwesome {
		
		/** constants */
		private const BASE_URL_STAGING: String = "https://ads.staging.superawesome.tv/v2";
		private const BASE_URL_DEVELOPMENT: String = "https://ads.dev.superawesome.tv/v2";
		private const BASE_URL_PRODUCTION: String = "https://ads.superawesome.tv/v2";
		
		private var baseUrl: String;
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
		
		/** functions to get info about the current SDK */
		private function getVersion(): String {
			return "3.2.1";
		}
		
		private function getSdk(): String {
			return "air";
		}
		
		public function getSdkVersion(): String {
			return getSdk() + "_" + getVersion();
		}
		
		/** config functions */
		public function setConfigurationProduction(): void {
			configuration = SAConfiguration.PRODUCTION;
			baseUrl = BASE_URL_PRODUCTION;
		}
		
		public function setConfigurationStaging(): void {
			configuration = SAConfiguration.STAGING;
			baseUrl = BASE_URL_STAGING;
		}
		
		public function setConfigurationDevelopment(): void {
			configuration = SAConfiguration.DEVELOPMENT;
			baseUrl = BASE_URL_DEVELOPMENT;
		}
		
		public function getBaseURL(): String {
			return baseUrl;
		}
		
		public function getConfiguration(): int {
			return configuration;
		}
		
		/** testing functions */
		public function enableTestMode(): void {
			this.isTestEnabled = true;
		}
		
		public function disableTestMode(): void {
			this.isTestEnabled = false;
		}
		
		public function isTestingEnabled(): Boolean {
			return this.isTestEnabled;
		}
	}
}