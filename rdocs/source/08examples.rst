Full Examples
=============

Simple Example
^^^^^^^^^^^^^^

The first example shows how you can add a video ad in your app with just a
few lines of code.

.. code-block:: actionscript

    package {

        import flash.display.Sprite;
        import flash.display.StageAlign;
        import flash.display.StageScaleMode;
        import flash.geom.Rectangle;
        import tv.superawesome.*;

        public class AdobeAIRDemo
               extends Sprite
               implements SALoaderInterface {

            // declare the three main variables
            // needed by SuperAwesome to load & display
            // an Ad
            private var loader: SALoader = null;
            private var video: SAVideoAd = null;
            private var adData: SAAd = null;

            public function AdobeAIRDemo() {

                // set stage
                stage.align = StageAlign.TOP_LEFT;
                stage.scaleMode = StageScaleMode.NO_SCALE;

                // config SuperAwesome
                SuperAwesome.getInstance().setConfigurationProduction();
                SuperAwesome.getInstance().enableTestMode();

                // load the ad
                loader = new SALoader();
                loader.delegate = this;
                loader.loadAd(30479);
            }

            // implementation of the SALoaderInterface
            public function didLoadAd(ad: SAAd): void {
                // handle success
                adData = ad;

                var frame = new Rectangle(0, 50, 640, 400);
                video = new SAVideoAd(frame);
                video.setAd(adData);
                video.play();
            }

            public function didFailToLoadAd(placementId: int): void {
                // failure
            }
        }
    }

Complex Example
^^^^^^^^^^^^^^^

This example shows how you can add different types of ads and make them respond to
multiple callbacks.

.. code-block:: actionscript

    package {

        import flash.display.Sprite;
        import flash.display.StageAlign;
        import flash.display.StageScaleMode;
        import flash.geom.Rectangle;
        import tv.superawesome.*;

        public class AdobeAIRDemo
               extends Sprite
               implements SALoaderInterface,
                          SAAdInterface,
                          SAParentalGateInterface,
                          SAVideoAdInterface {

            // loader
            private var loader: SALoader = null;

            // ad data
            private var bannerAdData: SAAd = null;
            private var interstitialAdData: SAAd = null;
            private var videoAdData: SAAd = null;

            // display objects
            private var banner: SABannerAd = null;
            private var interstitial: SAInterstitialAd = null;
            private var fvideo: SAFullscreenVideoAd = null;

            public function AdobeAIRDemo() {
                // set stage
                stage.align = StageAlign.TOP_LEFT;
                stage.scaleMode = StageScaleMode.NO_SCALE;

                // config SuperAwesome
                SuperAwesome.getInstance().setConfigurationProduction();
                SuperAwesome.getInstance().enableTestMode();

                // load the ad
                loader = new SALoader();
                loader.delegate = this;
                loader.loadAd(30471);
                loader.loadAd(30473);
                loader.loadAd(30479);
            }

            //
            // three function to display ads -
            // these should be connected to buttons
            public function showBanner(): void {
                var frame = new Rectangle(0, 0, 320, 50);

                // it's good practice to always check
                // that the ad data is not null
                if (bannerAdData) {
                    banner = new SABannerAd(frame);
                    banner.setAd(bannerAdData);
                    banner.adDelegate = this;
                    banner.isParentalGateEnabled = true;
                    banner.parentalGateDelegate = this;
                    banner.play();
                }
            }

            public function showInterstitial(): void {
                if (interstitialAdData) {
                    interstitial = new SAInterstitialAd();
                    interstitial.setAd(interstitialAdData);
                    interstitial.play();
                }
            }

            public function showVideo(): void {
                if (videoAdData) {
                    fvideo = new SAFullscreenVideoAd();
                    fvideo.setAd(ad);
                    fvideo.videoAdDelegate = this;
                    fvideo.shouldShowCloseButton = true;
                    fvideo.shouldAutomaticallyCloseAtEnd = true;
                    fvideo.isParentalGateEnabled = false;
                    fvideo.play();
                }
            }

            //
            // SAAdInterface implementation
            public function adWasShown(placementId: int): void {
                trace("Ad " + placementId + " Was shown");
            }

            public function adFailedToShow(placementId: int): void {}
            public function adWasClosed(placementId: int): void {}
            public function adWasClicked(placementId: int): void {}
            public function adHasIncorrectPlacement(placementId: int): void {}

            //
            // SAParentalGateInterface implementation
            public function parentalGateWasCanceled(placementId: int): void {}
            public function parentalGateWasFailed(placementId: int): void {}
            public function parentalGateWasSucceded(placementId: int): void {}

            //
            // SAVideoAdInterface implementation
            public function adStarted(placementId: int): void {}
            public function videoStarted(placementId: int): void {}
            public function videoReachedFirstQuartile(placementId: int): void {}

            public function videoReachedMidpoint(placementId: int): void {
                trace("Reached midpoint with " + placementId);
            }

            public function videoReachedThirdQuartile(placementId: int): void {}
            public function videoEnded(placementId: int): void {}
            public function adEnded(placementId: int): void {}

            public function allAdsEnded(placementId: int): void {
                trace("All video ads ended!");
            }
        }
    }
