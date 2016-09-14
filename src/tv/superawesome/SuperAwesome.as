package tv.superawesome {
	public class SuperAwesome {
		
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
			
			// instrance 
			_instance = this;
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
	}
}