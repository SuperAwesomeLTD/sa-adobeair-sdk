package tv.superawesome {
	/** imports needed for this class */
	import com.adobe.serialization.json.JSON;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import tv.superawesome.interfaces.SALoaderInterface;
	import tv.superawesome.interfaces.SAViewInterface;
	
	/**
	 * Extension-like implementation of the SALoader class
	 */
	public class SALoader extends EventDispatcher implements SAViewInterface {
		
		/** private vars of different sorts */
		private var extContext:ExtensionContext;
		private static var index: int = 0;
		private var name: String = null; 
		private var placementId: int = 0;
		
		/** public delegate */
		public var delegate:SALoaderInterface = null;
		
		/** constructor */
		public function SALoader() {
			super();
			this.name = "SALoader_" + (++SALoader.index);
			extContext = ExtensionContext.createExtensionContext("tv.superawesome.plugins.air", "" );
			if ( !extContext ) {
				throw new Error( "SuperAwesome native extension is not supported on this platform." );
			}
			
			/** add the event listener for the SALoader class */
			extContext.addEventListener(StatusEvent.STATUS, nativeCallback);
		}
		
		/** 
		 * main loading function - that technically should dispatch an event 
		 * to the iOS / Android SDK, and through a callback, get back ad json data
		 */
		public function loadAd(placementId: int): void {
			this.placementId = placementId;
			var isTestingEabled: Boolean = SuperAwesome.getInstance().isTestingEnabled();
			var config: int = SuperAwesome.getInstance().getConfiguration();
			
			/** send external event to SA */
			extContext.call("loadAd", this.name, this.placementId, isTestingEabled, config);
		}
		
		/** <SAViewInterface>  **/
		public function setAd(ad: SAAd): void { /** stub */ }
		public function getAd(): SAAd { return null; }
		public function play (): void { /** stub */ }
		public function close(): void { /** stub */ }
		
		public function nativeCallback(event:StatusEvent): void {
			/** get data */
			var data: String = event.code;
			var content: String = event.level;
			
			/** make sense of the data */
			var meta: Object = com.adobe.serialization.json.JSON.decode(data);
			var name: String = meta.name;
			var func: String = meta.func;
			var placement: int = parseInt(meta.placementId);
			
			/** first make sure the event is for this object */
			if (name.indexOf(this.name) >= 0) {
				/** success case */
				if (func.indexOf("didLoadAd") >= 0 && delegate != null) {
					var ad:SAAd = new SAAd();
					ad.adJson = event.level;
					ad.placementId = placement;
					delegate.didLoadAd(ad);
				} 
				/** error case */
				if (func.indexOf("didFailToLoadAdForPlacementId") >= 0 && delegate != null) {
					delegate.didFailToLoadAd(placement);
				}
			}
		}
	}
}