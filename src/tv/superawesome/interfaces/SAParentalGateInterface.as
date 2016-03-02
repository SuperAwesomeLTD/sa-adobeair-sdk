package tv.superawesome.interfaces {
	/**
	 * A custom protocol that defines functions that respond to parental gate
	 * actions
	 */
	public interface SAParentalGateInterface {
		/** this function is called when a parental gate pop-up "cancel" button is pressed */
		function parentalGateWasCanceled(placementId: int): void;
		
		/**
		 * this function is called when a parental gate pop-up "continue" button is
		 * pressed and the parental gate failed (because the numbers weren't OK)
		 */
		function parentalGateWasFailed(placementId: int): void;
		
		/** 
		 * this function is called when a parental gate pop-up "continue" button is
		 * pressed and the parental gate succedded
		 */
		function parentalGateWasSucceded(placementId: int): void;
	}
}