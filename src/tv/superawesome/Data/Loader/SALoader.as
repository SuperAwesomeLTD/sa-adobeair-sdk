package tv.superawesome.Data.Loader {
	
	// imports
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.system.Security;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Formatter.SAFormatter;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Network.SANetwork;
	import tv.superawesome.Data.Parser.SAParser;
	import tv.superawesome.Data.Validator.SAValidator;

	// loader
	public class SALoader {
		// the delegate
		public var delegate: SALoaderProtocol;
		
		// singleton part
		private static var _instance: SALoader;
		
		public function SALoader() {
			if (_instance) {
				throw new Error("Singleton... use getInstance()");
			}
			
			// instrance
			_instance = this;
		}

		public static function getInstance(): SALoader {
			if (!_instance) { new SALoader(); }
			return _instance;
		}
		
		// function that preloads ads
		public function preloadAdForPlacementId(placementId: int): void {
			this.loadAd(placementId, function(ad: SAAd): void {
				if (SALoader.getInstance().delegate != null) {
					SALoader.getInstance().delegate.didPreloadAd(ad, placementId);
				}
			},
			function(): void {
				if (SALoader.getInstance().delegate != null) {
					SALoader.getInstance().delegate.didFailToPreloadAdForPlacementId(placementId);
				}
			});
		}
		
		// function that loads an ad
		public function loadAd(placementId: int, gotad: Function, error: Function): void {
			// form the URL
			var endpoint: String = SuperAwesome.getInstance().getBaseURL() + "/ad/" + placementId;
			var dict: Object = new Object();
			dict.test = SuperAwesome.getInstance().isTestingEnabled();
			
			// allow cross domain
//			var crossDomainURL: String = SuperAwesome.getInstance().getBaseURL().replace("/v2","") + "/crossdomain.xml";
//			Security.allowDomain("*");
//			Security.loadPolicyFile(crossDomainURL);
//			trace(crossDomainURL);
			
			// send a get to load the actual AD
			SANetwork.sendGET(endpoint, dict, function(e: Event): void { 
				// start the heavy lifting
				var config: Object = com.adobe.serialization.json.JSON.decode(e.target.data);
				
				if (config) {
					// form the ad
					var ad: SAAd = SAParser.parseAd(config);
					ad.placementId = placementId;
					ad.creative = SAParser.parseCreative(config);
					if (ad.creative) {
						ad.creative.details = SAParser.parseDetails(config);
					}
					
					if (SAValidator.isAdDataValid(ad) == true) {
						ad.adHTML = SAFormatter.formatCreativeDataIntoAdHTML(ad.creative);
						if (gotad != null) gotad(ad);
					}
				}
				else {
					// call error
					if (error != null) error();
				}
			}, 
			function(): void { 
				// call error
				if (error != null) error();
			});
		}		
	}
}