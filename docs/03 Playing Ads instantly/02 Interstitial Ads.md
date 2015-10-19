Creating interstitial ads is similar.

Just add the following lines of code to your `MyAIRProject()` function:

```
var iad:SAInterstitialAd = new SAInterstitialAd(5692);
addChild(iad);
iad.playInstant();

```

Notice that an Interstitial Ad does not need specifying a rectanlge, since it automatically covers the whole screen, as a popup. Again, since test mode is enabled, we can use the `5692` test placement, but it's advised to use the one received got from the Dashboard.

Finally, to be able to see the Ad, we need to add it as a child of the scene and call `playInstant()` to send a signal to the SDK to load and present the ad.