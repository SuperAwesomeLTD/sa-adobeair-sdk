package tv.superawesome.interfaces {
	
	/** imports needed for this interface */
	import flash.events.StatusEvent;
	import tv.superawesome.SAAd;
	
	/**
	 * Interface for all view-types
	 */
	public interface SAViewInterface {
		/** function that sets an ad */
		function setAd(ad: SAAd): void;
		
		/** function that gets an view's ad */
		function getAd(): SAAd;
		
		/** function that plays the ad - sends the signal to native code to play */
		function play (): void;
		
		/** function that closes the ad */
		function close(): void;
		
		/** native callback function */
		function nativeCallback(event:StatusEvent): void ;
	}
}