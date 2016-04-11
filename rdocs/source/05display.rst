Display Ads
===========

In the next sections we'll see how to display banners, inline video ads, interstitials and fullscreen video ads.

We'll assume we have the same setup as the previous section, but we'll also add
four SuperAwesome display objects that we'll want to show at the press of a button
in our app.

.. code-block:: actionscript

    import tv.superawesome.*

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // the loader object
        private var loader: SALoader = null;

        // ad data
        private var bannerAdData: SAAd = null;
        private var interstitialAdData: SAAd = null;
        private var videoAdData: SAAd = null;

        // the four display objects
        private var banner: SABannerAd = null;
        private var interstitial: SAInterstitialAd = null;
        private var video: SAVideoAd = null;
        private var fvideo: SAFullscreenVideoAd = null;
    }

Banner ads
^^^^^^^^^^

To following code snippet shows you how to add a **SABannerAd** object to your app.

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // load ad data here ...

        public function showBanner() {
            if (bannerAdData != null) {
                var frame = new Rectangle(250, 450, 640, 100);
                banner = new SABannerAd(frame);
                banner.setAd(bannerAdData);
                banner.play();
            }
        }
    }

Notice that the SABannerAd class is calling the Android or iOS native components to display on screen, so there's no need for
you to add it as a child to the scene.

The two functions to pay attention here are **setAd(SAAd ad)** and **play()**.

* **setAd(SAAd ad)** takes a SAAd object as parameter, in this case bannerAdData. It tells the banner what ad data to try to display.
* **play()** actually starts the display process on screen.

In-Line Video ads
^^^^^^^^^^^^^^^^^

**SAVideoAd** gets initialized and added in a similar way:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // load ad data here ...

        public function showInLineVideo() {
            if (videoAdData != null) {
                var frame = new Rectangle(250, 450, 640, 100);
                video = new SAVideoAd(frame);
                video.setAd(videoAdData);
                vidoe.play();
            }
        }
    }

As with SABannerAd, the SAVideoAd object must not be added to the view hierarchy, since it calls native methods.
It also implements the same two functions: setAd(SAAd ad) and play().

Interstitial ads
^^^^^^^^^^^^^^^^

Interstitial ads are represented by objects of type **SAInterstitialAd**.

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // load ad data here ...

        public function showInterstitial() {
            if (interstitialAdData != null) {
                interstitial = new SAInterstitialAd();
                interstitial.setAd(interstitialAdData);
                interstitial.play();
            }
        }
    }

Again, notice the presence of setAd(SAAd ad) and play() - they perform the same role as for banner or video ads.
The difference here is that the SAInterstitialAd constructor does not take a Rect object as parameter. That's because
interstitial as shown as fullscreen ads, on top of any existing content.
For Android a new Activity will be launched and for iOS a new View Controller.
Interstitial ads have their own SDK-provided close button.

Fullscreen video ads
^^^^^^^^^^^^^^^^^^^^

Finally, fullscreen video ads are represented by **SAFullscreenVideoAd**.

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // load ads here ... 

        public function showVideo() {
            if (videoAdData != null) {
                fvideo = new SAFullscreenVideoAd();
                fvideo.setAd(ad);
                fvideo.shouldShowCloseButton = true;
                fvideo.shouldAutomaticallyCloseAtEnd = true;
                fvideo.play();
            }
        }
    }

They're similar to interstitial ads, but notice there are two parameters you can set, **shouldShowCloseButton** and
**shouldAutomaticallyCloseAtEnd**.
