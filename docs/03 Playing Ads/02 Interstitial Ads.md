
Creating interstitial ads is similar.

Your `Main` class will still need to implement the SALoaderProtocol, and in the class constructor or in another init function you will have to call:

```
SALoader.getInstance().loadAd(5692);

```

Then creating an interstitial once it's loaded is a simple as having the specific `didLoadAd()` implementation:

```

public function didLoadAd(ad: SAAd): void {
	var interstitial:SAInterstitialAd = new SAInterstitialAd();
	interstitial.setAd(ad);
	addChild(interstitial);

	interstitial.play();
}

```

Notice the SAInterstitialAd constructor takes no parameters.