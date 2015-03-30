Find your App ID and Placement ID on the [dashboard](http://dashboard.superawesome.tv) and use the DisplayAd class to display an ad.

The following code snippet shows a 320x50 display ad at the 0,0 position:

```
import tv.superawesome.DisplayAd;
import flash.geom.Rectangle;

var vp:Rectangle = new Rectangle(0,0,640,100);
var ad:DisplayAd = new DisplayAd(this.stage, vp, __APP_ID__, __PLACEMENT_ID__);
```