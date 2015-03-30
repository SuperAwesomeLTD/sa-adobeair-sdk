Find your App ID and Placement ID on the [dashboard](http://dashboard.superawesome.tv) and use the VideoAd class to display an ad.

The following code snippet shows a fullscreen video ad:

```
import tv.superawesome.VideoAd;
import flash.geom.Rectangle;
import flash.events.Event;

var vp:Rectangle = new Rectangle(0,0,this.stage.width,this.stage.height);
var ad:VideoAd = new VideoAd(this.stage, vp, __APP_ID__, __PLACEMENT_ID__);
ad.addEventListener(Event.COMPLETE, onComplete);

function onComplete(e:Event){
	trace("Video Ad finished");
}
```

Replace the `__APP_ID__` and `__PLACEMENT_ID__` with your own to get this code working.

Your app can receive completed and error notificications from video ads. Just add an event listener and pass a callback to get these notifications.