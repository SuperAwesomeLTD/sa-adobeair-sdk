package tv.superawesome.Data.Parser {
	
	// imports
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Models.SACreative;
	import tv.superawesome.Data.Models.SACreativeFormat;
	import tv.superawesome.Data.Models.SADetails;
	import tv.superawesome.Data.Models.SAPlacementFormat;

	// this class has three parsing functions in it
	public class SAParser {
		
		public static function parseAd(dict: Object) : SAAd {
			var ad: SAAd = new SAAd();
			
			ad.error = (dict.error != null ? dict.error : -1);
			ad.lineItemId = (dict.line_item_id != null ? dict.line_item_id : -1);
			ad.campaignId = (dict.campaing_id != null ? dict.campaing_id : -1);
			ad.isTest = (dict.test != null ? dict.test : true);
			ad.isFallback = (dict.is_fallback != null ? dict.is_fallback : false);
			ad.isFill = (dict.is_fill != null ? dict.is_fill : false);
			
			return ad;
		}
		
		public static function parseCreative(cdict: Object): SACreative {
			// do a checkup first
			var creativeObj: Object = cdict.creative;
			if (creativeObj == null){
				return null;
			}
			
			var dict: Object = creativeObj;
			var creative: SACreative = new SACreative();
			
			// do the parsing
			creative.creativeId = (dict.creative_id != null ? dict.creative_id : -1);
			creative.name = (dict.name != null ? dict.name : null);
			creative.cpm = (dict.cpm != null ? dict.cpm : 0);
			creative.impresionURL = (dict.impression_url != null ? dict.impression_url : null);
			creative.clickURL = (dict.click_url != null ? dict.click_url : "http://superawesome.tv");
			creative.approved = (dict.approved != null ? dict.approved : false);
			creative.format = (dict.format != null ? dict.format : SACreativeFormat.format_unknown);
			
			return creative;
		}
		
		public static function parseDetails(ddict: Object): SADetails {
			// first check the dict
			var creativeObj: Object = ddict.creative;
			if (creativeObj == null) {
				return null;
			}
			
			var detailsObj: Object = creativeObj.details;
			if (detailsObj == null) {
				return null;
			}
			
			// do the actual parsing
			var dict: Object = detailsObj;
			var details: SADetails = new SADetails();
			
			details.width = (dict.width != null ? dict.width : 0);
			details.height = (dict.height != null ? dict.height : 0);
			details.image = (dict.image != null ? dict.image : null);
			details.value = (dict.value != null ? dict.value: -1);
			details.name = (dict.name != null ? dict.name : null);
			details.video = (dict.video != null ? dict.video : null);
			details.bitrate = (dict.bitrate != null ? dict.bitrate : 0);
			details.duration = (dict.duration != null ? dict.duration : 0);
			details.vast = (dict.vast != null ? dict.vast : null);
			details.tag = (dict.tag != null ? dict.tag : null);
			details.zip = (dict.zip != null ? dict.zip : null);
			details.url = (dict.url != null ? dict.url : null);
			details.placementFormat = (dict.placement_format != null ? dict.placement_format : null);
			
			return details;
		}		
	}
	
}