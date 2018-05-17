package tv.superawesome.sdk.publisher {

import com.adobe.serialization.json.JSON;

import flash.events.StatusEvent;

public class AwesomeAds {

    // the static interstitial ad instance
    private static var staticInstance: AwesomeAds = null;

    // instance vars
    private static var name: String = "AwesomeAds";

    // func that creates a
    private static function tryAndCreateOnce (): void {
        if (staticInstance == null) {
            staticInstance = new AwesomeAds();
        }
    }

    // constructor
    public function AwesomeAds () {
        // add event listener
        SAExtensionContext.current().context().addEventListener(StatusEvent.STATUS, nativeCallback);
    }

    public static function initSDK (loggingEnabled: Boolean): void {
//        tryAndCreateOnce();
//        SAExtensionContext.current().context().call("SuperAwesomeAIRAwesomeAdsInit");
    }

    ////////////////////////////////////////////////////////////
    // Callback
    ////////////////////////////////////////////////////////////

    public static function nativeCallback(event:StatusEvent): void {
        // get data
        var data: String = event.code;
        var content: String = event.level;

        // parse data
        var meta: Object = com.adobe.serialization.json.JSON.decode(data);
        var callName:String = null;
        var placement:int = 0;
        var call:String = null;

        // get properties (right way)
        if (meta.hasOwnProperty("name")) {
            callName = meta.name;
        }
        if (meta.hasOwnProperty("placementId")) {
            placement = meta.placementId;
        }
        if (meta.hasOwnProperty("callback")) {
            call = meta.callback;
        }
    }
}
}
