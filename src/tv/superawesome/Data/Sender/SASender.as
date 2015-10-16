package tv.superawesome.Data.Sender {
	// imports
	import flash.events.Event;
	
	import tv.superawesome.SuperAwesome;
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Network.SANetwork;
	import tv.superawesome.Data.Parser.SASerializer;
	import tv.superawesome.Data.Sender.SAEventType;
	
	public class SASender {
		
		private static function postGenericEventToURL(endpoint: String, type: String, ad: SAAd): void {
			// parse the URL
			var url: String = SuperAwesome.getInstance().getBaseURL() + "/" + endpoint;
			
			// prepare the dictionary
			var dict: Object = SASerializer.serializeAdEssentials(ad);
			
			if (type != SAEventType.NoAd){
				dict.type = (type == SAEventType.viewable_impression ? SAEventType.viewable_impression : "custom."+type);
			}
			
			// add the value
			if (ad.creative.details.value > 0){
				dict.details.value = ad.creative.details.value;
			}
			
			// send the data
			SANetwork.sendPOST(url, dict,  function(e: Event): void {
				// do nothing
			},
			function(): void {
				// do nothing
			});
		}
		
		public static function postEventViewableImpression(ad: SAAd): void {
			SASender.postGenericEventToURL("event", SAEventType.viewable_impression, ad);
		}
		
		public static function postEventAdFailedToView(ad: SAAd): void {
			SASender.postGenericEventToURL("event", SAEventType.AdFailedToView, ad);
		}
		
		public static function postEventAdRate(ad: SAAd, value: int): void {
			var _ad: SAAd = ad;
			_ad.creative.details.value = value;
			SASender.postGenericEventToURL("event", SAEventType.AdRate, _ad);
		}
		
		public static function postEventPGCancel(ad: SAAd): void {
			SASender.postGenericEventToURL("event", SAEventType.AdPGCancel, ad);
		}
		
		public static function postEventPGSuccess(ad: SAAd): void {
			SASender.postGenericEventToURL("event", SAEventType.AdPGSuccess, ad);
		}
		
		public static function postEventPGError(ad: SAAd): void {
			SASender.postGenericEventToURL("event", SAEventType.AdPGError, ad);
		}
		
		public static function postEventClick(ad: SAAd): void {
			SASender.postGenericEventToURL("click", SAEventType.NoAd, ad);
		}
		
	}
}