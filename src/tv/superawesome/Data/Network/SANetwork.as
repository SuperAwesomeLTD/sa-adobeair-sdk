package tv.superawesome.Data.Network {
	
	// imports
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	public class SANetwork {
		
		// the main sendGET function, that parametrizes some request things
		public static function sendGET(endpoint: String, queryDict: Object, success: Function, error: Function): void {
			// form the full GET-ified endpoint
			var getEndpoint: String = endpoint;
			if (queryDict != null) {
				getEndpoint += "?";

				for (var i:* in queryDict) { 
					getEndpoint += i + "=" + queryDict[i] + "&" ; 
				}
				
				getEndpoint = getEndpoint.substring(0, getEndpoint.length - 1);
			}
			
			trace("GET : " + getEndpoint);
			
			// form the request and loader
			var request: URLRequest = new URLRequest(getEndpoint);
			
			// make the actual request
			var loader: URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, success);
			loader.addEventListener(IOErrorEvent.IO_ERROR, error);
			loader.load(request);
		}
		
		// the main sendPOST function, that parametrizes some request things
		public static function sendPOST(endpoint: String, postParams: Object, success: Function, error: Function): void {
			
			// form the request variables (for POST)
			var requestVars:URLVariables = new URLVariables();
			if (postParams != null) {
				for (var i:* in postParams) { 
					requestVars[i] = postParams[i];
				}
				
			}
			
			trace("POST: " + endpoint);
			
			// form the actual request
			var request: URLRequest = new URLRequest(endpoint);
			request.data = requestVars;
			request.method = URLRequestMethod.POST;
			
			// load the request
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, success);
			loader.addEventListener(IOErrorEvent.IO_ERROR, error);
			loader.load(request);
		}
	}
	
}