The Super Awesome SDK supports preloading of ads. This means that you can load most of the Ad data beforehand and display the ad when it's convenient.

To be able to preload ads though, you will need to do some setup.

### Implementing the SA Loader Protocol

The first step is to declare our `Main` class as implementing the `SALoaderProtocol`, which is a custom SuperAwesome interface:

```
public class Main extends MovieClip implements SALoaderProtocol {
	.....
}
```

The `SALoaderProtocol` defines two functions that any class must implement. Therefore, add the following code inside Main's definition:

```
public function didPreloadAd(ad: SAAd, placementId:int): void {
	// empty implementation for now
}

public function didFailToPreloadAdForPlacementId(placementId: int): void {
	// empty implementation for now
}

```

### Preloading ads

Once that is done, in our `Main` class' constructor you should add code to preload ads:

```
public function Main() {
	...

	// this code calls the SALoader singleton to preload data for one Ad placement 
	SALoader.getInstance().preloadAd(5687);

	// here we're declaring Main as a delegate for SALoader, meaning it will
	// implement SALoader's SALoaderProtocol functions (the one we defined earlier)
	SALoader.getInstance().delegate = self;

	// declare a banner ad, but don't play it just yet
	// also don't specify a placement_id, it's an optional parameter when preloading
	// ads, and will be overwriten later 
	var r1: Rectangle = new Rectangle(0, 0, 320, 50);
	bannerad = new SABannerAd(r1);

}

```

Finally, we will use the two functions we just implemented, part of SALoaderProtocol, to see when an ad
has been loaded and act on it.

```
public function didPreloadAd(ad: SAAd, placementId:int): void {
	// check to see if the right placement was loaded
	if (placementId == 5687) {	
		// use the special setAd() function of each SuperAwesome Ad object to assign the
		// loaded Ad
		bannerad.setAd(ad);

		// use the playPreloader() function to display the ad; This function assumes
		// that bannerad has a valid add assigned
		bannerad.playPreloaded();

		// and add the banner ad as a child to the current scene
		addChild(bannerad);
	}
}
```

These steps apply equally to Interstitial and Video Ads.