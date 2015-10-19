Once you've setup everything, the easiest way to load ads is by loading them instantly.
For example, if you want to display a Banner Ad in your application:

```
var vp:Rectangle = new Rectangle(0,0,320,50);
var ad:SABannerAd = new SABannerAd(vp, 5687);
addChild(ad);
ad.playInstant();

```

You first create a rectangle that should be the size of the Ad you specified in the dashboard. Then create a new `BannerAd` object, using the rectangle and a PlacementId. 
Since we enabled test mode in the previous section, it is alright to use `5687` as a PlacementId, but you should use the one obtained in the Dashboard for real ads.

Finally, to be able to see the Ad, we need to add it as a child of the scene and call `playInstant()` to send a signal to the SDK to load and present the ad.