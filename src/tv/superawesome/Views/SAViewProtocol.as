package tv.superawesome.Views {
	
	// protocol implementation
	public interface SAViewProtocol {
		
		function adWasShown(placementId: int): void;
		function adFailedToShow(placementId: int): void;
		function adWasClosed(placementId: int): void;
		function adFollowedURL(placementId: int): void;
	}
	
}

