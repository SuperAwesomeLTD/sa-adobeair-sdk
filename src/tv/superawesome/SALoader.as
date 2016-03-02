package tv.superawesome {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * Extension-like implementation of the SALoader class
	 */
	public class SALoader extends EventDispatcher {
		
		/** private vars of different sorts */
		private var extContext:ExtensionContext;
		private static var index: int = 0;
		private var name: String = null; 
		private var plaementId: int = 0;
		
		/** constructor */
		public function SALoader() {
			super();
			this.name = "SALoader_" + (++SALoader.index);
			extContext = ExtensionContext.createExtensionContext("tv.superawesome", "" );
			if ( !extContext ) {
				throw new Error( "Volume native extension is not supported on this platform." );
			}
		}
		
		/** 
		 * main loading function - that technically should dispatch an event 
		 * to the iOS / Android SDK, and through a callback, get back ad json data
		 */
		public function loadAd(placementId: int): void {
			var isTestingEabled: Boolean = SuperAwesome.getInstance().isTestingEnabled();
			var config: int = SuperAwesome.getInstance().getConfiguration();
			
			/** send external event to SA */
			extContext.call("SuperAwesomeAIRLoadAd", this.name, this.plaementId, isTestingEabled, config);
		}
	}
}