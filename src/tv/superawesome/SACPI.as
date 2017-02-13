// ActionScript file

package tv.superawesome {
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.StatusEvent;
	
	public class SACPI {
		
		// define a default callback so that it's never null and I don't have
		// to do a check every time I want to call it
		private var installCallback: Function = function(success: Boolean): void{};
	
		// instance vars
		private static var name: String = "SACPI";
		
		// singleton variable
		private static var _instance: SACPI;
		public static function getInstance(): SACPI {
			if (!_instance) { new SACPI(); }
			return _instance;
		}
		
		public function SACPI () {
			super ();
			// add event listener
			SuperAwesome.getInstance().getContext().addEventListener(StatusEvent.STATUS, nativeCallback);
		}
		
		public function handleInstall (callback: Function): void {
			// get a valid cpi callback, no matter what
			installCallback = callback != null ? callback : installCallback;
			
			// call create
			SuperAwesome.getInstance().getContext().call("SuperAwesomeAIRSACPIHandleCPI", name);
		}
		
		public function nativeCallback(event:StatusEvent): void {
			// get data
			var data: String = event.code;
			var content: String = event.level;
			
			// parse data
			var meta: Object = com.adobe.serialization.json.JSON.decode(data);
			var callName:String = null;
			var success:Boolean = false;
			var call:String = null;
			
			// get properties (right way)
			if (meta.hasOwnProperty("name")) {
				callName = meta.name;
			}
			if (meta.hasOwnProperty("success")) {
				success = meta.success;
			}
			if (meta.hasOwnProperty("callback")) {
				call = meta.callback;
			}
			
			// check to see target
			if (callName != null && call != null && callName.indexOf(name) >= 0) {
				
				if (call.indexOf("HandleCPI") >= 0) {
					installCallback (success);
				}
			}
		}
	}
	
}