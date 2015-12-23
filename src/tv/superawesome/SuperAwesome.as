//
//  SuperAwesome.h
//  tv.superawesome
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/09/2015.
//
//
package tv.superawesome {

	// 
	// @brief: this class is a descendant of SuperAwesomeCommon
	// that implements AIR SDK specific functionality
	public class SuperAwesome extends SuperAwesomeCommon {
		
		// singleton part
		private static var _instance: SuperAwesome;
		
		// the constructor, which acts as a Singleton
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
		
		// main accessor function
		public static function getInstance(): SuperAwesome {
			if (!_instance) { new SuperAwesome(); }
			return _instance;
		}
		
		// public (useful) functions
		override public function getVersion(): String {
			return "3.1";
		}
		
		override public function getSdk(): String {
			return "air";
		}
	}
}