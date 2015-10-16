package tv.superawesome.Views {
	public interface SAVideoAdProtocol {
		function videoStarted(placementId: int): void;
		function videoEnded(placementId:int): void;
	}
}

