package tv.superawesome.Data.Parser {
	
	// imports
	import tv.superawesome.Data.Models.SAAd;

	public class SASerializer {

		// function that takes an ad and serializes some ad essentials
		public static function serializeAdEssentials(ad: SAAd): Object {
			var dict: Object = new Object();
			
			if (ad != null) {
				if (ad.placementId != 0) {
					dict.placement = ad.placementId;
				}
				if (ad.lineItemId != -1 ) {
					dict.line_item = ad.lineItemId;
				}
				if (ad.creative != null ) {
					if (ad.creative.creativeId != -1 ){
						dict.creative = ad.creative.creativeId;
					}
				}
				
				return dict;
			}
			
			return null;
		}
	}
	
}