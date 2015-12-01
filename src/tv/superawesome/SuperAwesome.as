package tv.superawesome {

	public class SuperAwesome extends SuperAwesomeCommon {
		
		// singleton part
		private static var _instance: SuperAwesome;
		
		public function SuperAwesome() {
			if (_instance) {
				throw new Error("Singleton... use getInstance()");
			}
			
			// enable cross domain and default values
			this.disableTestMode();
			this.setConfigurationProduction();
			
			// instrance
			_instance = this;
		}
		
		public static function getInstance(): SuperAwesome {
			if (!_instance) { new SuperAwesome(); }
			return _instance;
		}
		
		// public (useful) functions
		override public function version(): String {
			return "3.0";
		}
		
		override public function platform(): String {
			return "air";
		}
	}
}