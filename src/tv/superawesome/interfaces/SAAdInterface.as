package tv.superawesome.interfaces {
	
	/**
	 * This interface informs the user about different events in the lifecylce
	 * of a normal Ad;
	 * It has to be implemented as a delegate object by any child of
	 * SAView, meaning any Ad type is valid
	 */
	public interface SAAdInterface {
		/** this function is called when the ad is shown on the screen */
		function adWasShown(placementId: int): void;
		
		/** this function is called when the ad failed to show */
		function adFailedToShow(placementId: int): void;
		
		/**
		 * this function is called when an ad is closed;
		 * only applies to fullscreen ads like interstitials and fullscreen videos
		 */
		function adWasClosed(placementId: int): void;
		
		/** this function is called when an ad is clicked */
		function adWasClicked(placementId: int): void;
		
		/**
		 * this is called in case of incorrect format - e.g. user calls a video
		 * placement for an interstitial, etc
		 */
		function adHasIncorrectPlacement(placementId: int): void;
	}
}