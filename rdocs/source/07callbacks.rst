Callbacks
=========

Once an ad starts playing, it will send back callbacks to notify you that it has finished different lifecycle activities.
To respond to them we'll use a similar interface / delegate pattern as with SALoaderInterface.

Standard ad callbacks
^^^^^^^^^^^^^^^^^^^^^

To catch standard ad callbacks:

* your class must implement the **SAAdInterface** interface:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface, SAAdInterface {

        private var bannerAdData: SAAd = null;
        private var banner: SABannerAd = null;

        // rest of the implementation ...
    }

* the class must be set as delegate for your display objects:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface, SAAdInterface {

        // rest of the implementation ...

        public function showBanner() {
            if (bannerAdData != null) {
                var frame = new Rectangle(250, 450, 640, 100);
                banner = new SABannerAd(frame);
                banner.setAd(bannerAdData);
                banner.adDelegate = this;
                banner.play();
            }
        }
    }

* your class must implement the callback methods specified by SAAdInterface:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface, SAAdInterface {

        // rest of the implementation ...

        public function adWasShown(placementId: int): void {
            // called when an ad is first shown
        }

    	public function adFailedToShow(placementId: int): void {
            // called when an ad is not shown
            // because of some internal errors
            // or lack of internet connectivity
        }

    	public function adWasClosed(placementId: int): void {
            // available only for interstitial and
            // fullscreen video ads
            //
            // signals when an ad is closes
        }

    	public function adWasClicked(placementId: int): void {
            // called when an ad is clicked
        }

    	public function adHasIncorrectPlacement(placementId: int): void {
            // called when an ad has an incorrect
            // placement type for the ad it's trying to
            // show
            // e.g. a SAVideoAd object with a bannerAdData
            // SAAd object
        }
    }

Parental gate callbacks
^^^^^^^^^^^^^^^^^^^^^^^

To catch parental gate callbacks:

* Your class must implement the **SAParentalGateInterface**:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface,
                      SAParentalGateInterface {

        private var bannerAdData: SAAd = null;
        private var banner: SABannerAd = null;

        // rest of the implementation ...
    }

* the class must be set as delegate for your display objects:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface,
                      SAParentalGateInterface {

        // rest of the implementation ...

        public function showBanner() {
            if (bannerAdData != null) {
                var frame = new Rectangle(250, 450, 640, 100);
                banner = new SABannerAd(frame);
                banner.setAd(bannerAdData);
                bad.isParentalGateEnabled = true;
                bad.parentalGateDelegate = this;
                banner.play();
            }
        }
    }

* your class must implement the callback methods specified by SAAdInterface:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface,
                      SAParentalGateInterface {

        // rest of the implementation ...

        public function parentalGateWasCanceled(placementId: int): void {
            // this function is called when a
            // parental gate pop-up "cancel" button is pressed
    	}

    	public function parentalGateWasFailed(placementId: int): void {
            // this function is called when a
            // parental gate pop-up "continue" button is
            // pressed and the parental gate
            // failed (because the numbers weren't OK)
    	}

    	public function parentalGateWasSucceded(placementId: int): void {
            // this function is called when a
            // parental gate pop-up "continue" button is
            // pressed and the parental gate succeeded
    	}
    }

Video callbacks
^^^^^^^^^^^^^^^

To catch video ad callbacks (available only for SAVideoAd and SAFullscreenVideoAd objects):

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface,
                      SAVideoAdInterface {

        private var videoAdData: SAAd = null;
        private var video: SAVideoAd = null;

        // rest of the implementation ...
    }

* the class must be set as delegate for your display objects:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface,
                      SAVideoAdInterface {

        // rest of the implementation ...

        public function showVideo() {
            if (videoAdData != null) {
                var frame = new Rectangle(150, 50, 640, 100);
                video = new SAVideoAd(frame);
                video.setAd(videoAdData);
                video.videoAdDelegate = this;
                video.play();
            }
        }
    }

* your class must implement the callback methods specified by SAAdInterface:

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface,
                      SAVideoAdInterface {

        // rest of the implementation ...

        public function adStarted(placementId: int): void {
            // fired when an ad has started
        }

        public function videoStarted(placementId: int): void {
            // fired when a video ad has started
        }

        public function videoReachedFirstQuartile(placementId: int): void {
            // fired when a video ad has reached 1/4 of total duration
        }

        public function videoReachedMidpoint(placementId: int): void {
            // fired when a video ad has reached 1/2 of total duration
        }

        public function videoReachedThirdQuartile(placementId: int): void {
            // fired when a video ad has reached 3/4 of total duration
        }

        public function videoEnded(placementId: int): void {
            // fired when a video ad has ended
        }

        public function adEnded(placementId: int): void {
            // fired when an ad has ended
        }

        public function allAdsEnded(placementId: int): void {
            // fired when all ads have ended
        }
    }
