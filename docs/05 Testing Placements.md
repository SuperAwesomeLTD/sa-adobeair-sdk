Our SDK has a test mode flag that if set, causes your placements to display our demo ads. This way you can easily test the production and the development version of your app separately. To enable test mode call the following method:

```
SuperAwesome.sharedInstance().enableTestMode();
```

We also provide some demo placements that can be used for testing. These placements have a 100% fill rate.

| Name | Size | Description | Placement ID |
|-------------------------|
Standard Mobile | 320x50px | Mobile banner | 30471 |
SM Mobile | 300x50px | Small mobile banner | 30476 |
Interstitial | 320x480px | Mobile fullscreen (portrait) | 30473 |
Interstitial LS | 480x320px | Mobile fullscreen (landscape) | 30474 |
Leaderboard | 728x90px | Tablet banner | 30475 |
MPU | 300x250px | Smaller tablet banner | 30472 |
LG Interstitial | 768x1024px | Tablet fullscreen (portrait) | 30477 |
LG Interstitial LS | 1024x768px | Tablet fullscreen (landscape) | 30478 |
Video Preroll | Flexible | Mobile & tablet video | 30479 |
Gamewall | Flexible | Gamewall | N/A |