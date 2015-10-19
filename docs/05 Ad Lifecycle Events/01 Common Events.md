Using the same delegate pattern all ads can serve additional events than can be caught and acted upon.

To do this, your `MyAIRProject` class must also implement the `SAViewProtocol` interface:

```
public class MyAIRProject extends Sprite implements SALoaderProtocol, SAViewProtocol {
	...
}
``` 

Then, of course, you need to implement all the functions related to this interface:

```

// this function will be called when a certain Ad has been shown on the screen
public function adWasShown(placementId: int): void {
	
}

// this function will be called when a certain Ad has, for some reason,
// failed to show
public function adFailedToShow(placementId: int): void {
	
}

// this function will be called when an Interstitial or Fullscreen Video Ad
// has been close
public function adWasClosed(placementId: int): void {
	
}

// this function will be called when a user clicks or taps on an Ad and 
// follows the Ads associated URL
public function adFollowedURL(placementId: int): void {
	
}

```

Finally, to complete the code, all ads must assign their `delegate` object to `MyAIRProject`. This means that when an ad launches an adWasShown or adWasClosed event, Main will respond with the functions implemented above.

```
var bannerad: SABannerAd = new SABannerAD(new Rectangle(0, 0, 320, 50), 5687);
bannerad.delegate = this; // where this is MyAIRProject

```