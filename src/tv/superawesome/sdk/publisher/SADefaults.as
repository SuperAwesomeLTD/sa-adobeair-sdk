// ActionScript file
package tv.superawesome.sdk.publisher {
	
	import tv.superawesome.sdk.publisher.enums.SABannerPosition;
	import tv.superawesome.sdk.publisher.enums.SAConfiguration;
	import tv.superawesome.sdk.publisher.enums.SAOrientation;
	
	public class SADefaults {
		
		// default values
		
		public static function defaultPlacementId (): int {
			return 0;
		}
		
		public static function defaultTestMode (): Boolean {
			return false;
		}
		
		public static function defaultParentalGate (): Boolean {
			return true;
		}
		
		public static function defaultConfiguration (): int {
			return SAConfiguration.PRODUCTION;
		}
		
		public static function defaultOrientation (): int {
			return SAOrientation.ANY;
		}
		
		public static function defaultCloseButton (): Boolean {
			return false;
		}
		
		public static function defaultSmallClick (): Boolean {
			return false;
		}
		
		public static function defaultCloseAtEnd (): Boolean {
			return true;
		}
		
		public static function defaultBackButton (): Boolean {
			return false;
		}
		
		public static function defaultBgColor (): Boolean {
			return false;
		}
		
		public static function defaultBannerPosition (): int {
			return SABannerPosition.BOTTOM;
		}
		
		public static function defaultBannerWidth (): int {
			return 320;
		}
		
		public static function defaultBannerHeight (): int {
			return 50;
		}
		
	}
}