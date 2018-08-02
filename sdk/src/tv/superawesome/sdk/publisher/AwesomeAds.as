package tv.superawesome.sdk.publisher {

import com.adobe.serialization.json.JSON;

import flash.events.StatusEvent;

import tv.superawesome.sdk.publisher.enums.GetIsMinorModel;

public class AwesomeAds {

        // the static interstitial ad instance
        private static var staticInstance: AwesomeAds = null;

        // instance vars
        private static var name: String = "AwesomeAds";

        // define a default callback so that it's never null and I don't have
        // to do a check every time I want to call it
        private static var callback: Function = function(model: GetIsMinorModel): void{};

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
            SAExtensionContext.current().context().call("SuperAwesomeAIRAwesomeAdsInit", loggingEnabled);
        }

        public static function triggerAgeCheck (dateOfBirth: String, call: Function): void {
            tryAndCreateOnce();
            callback = call != null ? call : callback;
            SAExtensionContext.current().context().call("SuperAwesomeAIRAwesomeAdsTriggerAgeCheck", dateOfBirth);
        }

        ////////////////////////////////////////////////////////////
        // Callback
        ////////////////////////////////////////////////////////////

        public static function nativeCallback(event:StatusEvent): void {
            // get data
            var data: String = event.code;

            // parse data
            var meta: Object = com.adobe.serialization.json.JSON.decode(data);
            var callName:String = null;

            // get properties (right way)
            if (meta.hasOwnProperty("name")) {
                callName = meta.name;
            }

            if (callName != null && callName.indexOf(AwesomeAds.name) >= 0) {

                var isMinor: Boolean = false;
                var age: int = 0;
                var consentAgeForCountry: int = 0;
                var country: String = null;

                if (meta.hasOwnProperty("isMinor")) {
                    isMinor = meta.isMinor;
                }
                if (meta.hasOwnProperty("age")) {
                    age = meta.age;
                }
                if (meta.hasOwnProperty("consentAgeForCountry")) {
                    consentAgeForCountry = meta.consentAgeForCountry;
                }
                if (meta.hasOwnProperty("country")) {
                    country = meta.country;
                }

                var response: GetIsMinorModel = new GetIsMinorModel(country, consentAgeForCountry, age, isMinor);

                // send callback
                callback(response);
            }
        }
    }
}
