Finally, creating video ads is similar:

```

public function didLoadAd(ad: SAAd): void {
	var video:SAVideoAd = new SAVideoAd(new Rectangle(0, 0, 640, 480));
	video.setAd(ad);
	addChild(video);

	video.play();
}

```
