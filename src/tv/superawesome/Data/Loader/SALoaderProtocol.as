package tv.superawesome.Data.Loader {
	import tv.superawesome.Data.Models.SAAd;
	
	public interface SALoaderProtocol {
		// the two functions
		function didPreloadAd(ad: SAAd, placementId:int): void;
		function didFailToPreloadAdForPlacementId(placementId:int): void;
	}
}