package tv.superawesome.Data.Validator {
	
	// imports
	import tv.superawesome.Data.Models.SAAd;
	import tv.superawesome.Data.Models.SACreativeFormat;

	public class SAValidator {
		
		public static function isAdDataValid(ad: SAAd): Boolean {
			
			// 1. if Ad has no Creative, data is not valid
			if (ad.creative == null)
				return false;
			
			if (ad.creative != null) {
				// 2. if format is unknown, data is not valid
				if (ad.creative.format == SACreativeFormat.format_unknown)
					return false;
				
				// 3. if creative has no details, data is not valid
				if (ad.creative.details == null)
					return false;
				
				if (ad.creative.details != null) {
					switch (ad.creative.format) {
						case SACreativeFormat.image_with_link:{
							// 4.1. if Ad is image with link, but no image filed
							// could be found, data is not valid
							if (ad.creative.details.image == null)
								return false;
							break;
						}
						case SACreativeFormat.video:{
							// 4.2. if Ad is video and either the video or the vast
							// tags could not be found, data is not valid
							if (ad.creative.details.video == null)
								return false;
							if (ad.creative.details.vast == null)
								return false;
							break;
						}
						case SACreativeFormat.rich_media:{
							// 4.3. if Ad is rich media and no url can be found,
							// then data is not valid
							if (ad.creative.details.url == null)
								return false;
							break;
						}
						case SACreativeFormat.rich_media_resizing:{
							// 4.4. if Ad is rich media (resizing) and no url can be found,
							// then data is not valid
							if (ad.creative.details.url == null)
								return false;
							break;
						}
						case SACreativeFormat.swf:{
							break;
						}
						case SACreativeFormat.tag:{
							// 4.5. if Ad is tag and no tag can be found,
							// then data is not valid
							if (ad.creative.details.tag == null)
								return false;
							break;
						}
						default:{
							break;
						}
					}
				}
			}
			
			return true;
		}
	}	
}