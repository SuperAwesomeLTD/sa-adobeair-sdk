Loading ads
===========

After you've created your Apps and Placements in the dashboard and successfully integrated the SDK in your project,
the next logical step is to actually start showing ads.

For this purpose, the SDK employs a two-step process:
First, you'll need to load ad data for each placement you'll want to display.
Then, once that data is successfully loaded, you can finally show the ad.
The two steps are independent of each other so you can easily pre-load ads for later use, saving performance.

In the code snippet below we'll start by loading data for the test placement **30471**.
A good place to do this is in the constructor of a class descending from **Sprite** (such as AdobeAIRDemo), where
we'll create a **SALoader** object to help us.

SALoader is a SDK class whose sole role is to load, parse, process and validate ad data by comunicating with the native SDK (either iOS or Android).
You'll usually need just one instance of it.

.. code-block:: actionscript

    import tv.superawesome.*

    public class AdobeAIRDemo
           extends Sprite {

        // declare a new SALoader object
        private var loader:SALoader = null;

        public function AdobeAIRDemo() {

            // configure SDK to test mode
            SuperAwesome.getInstance().enableTestMode();

            // create the loader and load ad
            loader = new SALoader();
            loader.loadAd(30471);
        }
    }

The **loadAd(30471)** function loads data asynchronously, so as not to block the main UI thread.
When it's done, it calls two important callback methods, **didLoadAd(SAAd loadedAd)** and **didFailToLoadAdForPlacementId(int placementId)**,
to notify you of either success or failure.
In order to use these callbacks:

* your main class (AdobeAIRDemo) must implement the **SALoaderInterface**

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface

* it must be set as delegate for the SALoader object created earlier

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // declare a new SALoader object
        private var loader:SALoader = null;

        public function AdobeAIRDemo() {

            // configure SDK to test mode
            SuperAwesome.getInstance().enableTestMode();

            // create the loader and load ad
            loader = new SALoader();
            // assign loader's delegate object
            loader.delegate = this;
            loader.loadAd(30471);
        }
    }

* finally, your AdobeAIRDemo class must also implement the two callback methods mentioned above

.. code-block:: actionscript

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // rest of your code, the constructor, etc ...

        public function didLoadAd(ad: SAAd): void {
            // at this moment ad data is ready
            ad.print();
        }

        public function didFailToLoadAd(placementId: int): void {
            // at this moment no ad could be found
        }
    }

You'll notice that didLoadAd(SAAd ad) has a callback parameter of type **SAAd**. The SAAd class contains all the information needed to
actually display an ad, such as format (image, video), dimensions, click URL, video information, creative details, etc.
You can find out all details by calling the **print()** function, as shown in the example.

Saving an Ad for later use
^^^^^^^^^^^^^^^^^^^^^^^^^^

To save ads for later use, you can do something like this:

.. code-block:: actionscript

    import tv.superawesome.*

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // declare a new SALoader object
        private var loader:SALoader = null;

        // declare a SAAd object as a class member variable
        private var bannerAdData: SAAd = null;

        public function AdobeAIRDemo() {

            // configure SDK to test mode
            SuperAwesome.getInstance().enableTestMode();

            // create the loader
            loader = new SALoader();
            // assign loader's delegate object
            loader.delegate = this;
            loader.loadAd(30471);
        }

        public function didLoadAd(ad: SAAd): void {
            // save current loaded ad into
            // class member variable bannerAdData
            bannerAdData = ad;
        }

        public function didFailToLoadAd(placementId: int): void {
            // at this moment no ad could be found
        }
    }

Saving multiple Ads for later use
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Finally, if you want to load multiple ads and save them for later use, you can do as such:

.. code-block:: actionscript

    import tv.superawesome.*

    public class AdobeAIRDemo
           extends Sprite
           implements SALoaderInterface {

        // declare a new SALoader object
        private var loader: SALoader = null;

        // declare a number of SAAd objects
        private var bannerAdData: SAAd = null;
        private var interstitialAdData: SAAd = null;
        private var videoAdData: SAAd = null;

        public function AdobeAIRDemo() {
            // configure SDK to test mode
            SuperAwesome.getInstance().enableTestMode();

            // create the loader and set delegate
            loader = new SALoader();
            loader.delegate = this;

            // load ad data for a banner
            loader.loadAd(30471);
            // and for an interstitial
            banner.loadAd(30473);
            // and for a video
            banner.loadAd(30479);
        }

        public function didLoadAd(ad: SAAd): void {
            if (ad.placementId == 30471) {
                bannerAdData = ad;
            } else if (ad.placementId == 30473) {
                interstitialAdData = ad;
            } else if (ad.placementId == 30479) {
                videoAdData = ad;
            }
        }

        public function didFailToLoadAd(placementId: int): void {
            // at this moment no ad could be found
        }
    }
