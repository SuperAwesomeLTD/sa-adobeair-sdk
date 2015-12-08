Once you're done with the setup, you can start loading and displaying ads, which is a two-step process:

First you'll need load the ads, by specifying the placement you want ad data loaded.

In your main class or init function, add the following lines of code:

```

SALoader.getInstance().delegate = this;
SALoader.getInstance().loadAd(5687);

```

This will notify the SDK to begin loading. However, in order to get the ad data once it's been loaded, you'll need to change your class definition to implement the `SALoaderProtocol`.

```

public class Main extends MovieClip implements SALoaderProtocol {
	.....
}

```

The last thing to do is have your Main class implement the two functions required by SALoaderProtocol:

```
public function didLoadAd(ad: SAAd): void {
	var banner: SABannerAd = new SABannerAd(new Rectangle(0, 0, 320, 50));
	banner.setAd(ad);
	addChild(banner);

	banner.play();
}

public function didFailToLoadAdForPlacementId(placementId: int): void {
	// handle error here
}

```

Notice that in our `didLoadAd()` implementation we also created a new SABannerAd object, by calling its constructor, which takes only one parameter, the Rectangle the banner ad will show on.

Then we set the banner's internal ad object with the one returned by the function implementation, and added the banner as a subchild of the scene.

The `play()` function is the one that actually displays the ad. You don't need to call `play()` just now, you may well call it at the press of a button or later in the program's execution. 
