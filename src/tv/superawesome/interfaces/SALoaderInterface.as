package tv.superawesome.interfaces {
	
	import tv.superawesome.SAAd;
	
	/**
	 * SALoader interface defines two main functions that a SDK user might
	 * implement if he wants to preload Ads
	 * This protocol is implemented by a SALoader class delegate
	 */
	public interface SALoaderInterface {
		/**
		 * function that gets called when an Ad is succesfully called
		 * Returns a valid SAAd object
		 */
		function didLoadAd(ad: SAAd): void;
		
		/**
		 * Function that gets called when an Ad has failed to load
		 * It returns a placementId of the failing ad through callback
		 */
		function didFailToLoadAd(placementId: int): void;
	}
}