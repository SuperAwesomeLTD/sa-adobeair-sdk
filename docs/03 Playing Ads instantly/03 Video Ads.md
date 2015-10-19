Next, to add a Video Ad change the `MyAIRProject()` function in `MyAIRProject.as` to contain the following code:

```
var vp2: Rectangle = new Rectangle(0,60,400,300);
var vad: SAVideoAd = new SAVideoAd(vp2, 5740);
addChild(vad);
vad.playInstant();

```

What this does is define a new Rectangle and then create a new `VideoAd` object using the rectangle and a test `5740` PlacementId.

The video ad will only play once the `playInstant()` function is called. 
