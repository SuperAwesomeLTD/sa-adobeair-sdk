package tv.superawesome.Views {
	
	// protocol implementation
	public interface SAAdProtocol {
		
		function adWasShown(placementId: int): void;
		function adFailedToShow(placementId: int): void;
		function adWasClosed(placementId: int): void;
		function adWasClicked(placementId: int): void;
	}
	
}

