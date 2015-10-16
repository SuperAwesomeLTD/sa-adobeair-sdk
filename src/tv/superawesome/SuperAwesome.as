package tv.superawesome {
	
	public class SuperAwesome {

		// constants
		private static const BASE_URL_STAGING: String = "https://staging.beta.ads.superawesome.tv/v2";
		private static const BASE_URL_DEVELOPMENT: String = "https://dev.ads.superawesome.tv/v2";
		private static const BASE_URL_PRODUCTION: String = "https://ads.superawesome.tv/v2";
		
		// private variables
		private var baseURL: String;
		private var isTestEnabled: Boolean;
		
		// singleton part
		private static var _instance: SuperAwesome;
		
		public function SuperAwesome() {
			if (_instance) {
				throw new Error("Singleton... use getInstance()");
			}
			
			// enable cross domain and default values
			// this.enableCrossDomainFlash();
			this.enableTestMode();
			this.setConfigurationProduction();
			
			// instrance
			_instance = this;
		}

		public static function getInstance(): SuperAwesome {
			if (!_instance) { new SuperAwesome(); }
			return _instance;
		}
		
		// public (useful) functions
		public function version(): String {
			return "3.0f";
		}
		
		public function setConfigurationProduction(): void {
			this.baseURL = SuperAwesome.BASE_URL_PRODUCTION;
		}
		
		public function setConfigurationStaging(): void {
			this.baseURL = SuperAwesome.BASE_URL_STAGING;
		}
		
		public function setConfigurationDevelopment(): void {
			this.baseURL = SuperAwesome.BASE_URL_DEVELOPMENT;
		}
		
		public function getBaseURL(): String {
			return this.baseURL;
		}
		
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