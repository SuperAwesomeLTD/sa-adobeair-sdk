Configuring the SDK
===================

Once you've integrated the SuperAwesome SDK, you can access all functionality by including the SuperAwesome library in any actionscript file you want
to use it.

.. code-block:: actionscript

    import tv.superawesome.*

or including one of the relevant headers

.. code-block:: actionscript

    import tv.superawesome.SuperAwesome;
    import tv.superawesome.SALoader;
    import tv.superawesome.SAAd;
    import tv.superawesome.SABannerAd;
    import tv.superawesome.SAVideoAd;
    import tv.superawesome.SAFullscreenVideoAd;
    import tv.superawesome.SAInterstitialAd;
    import tv.superawesome.interfaces.SALoaderInterface;
    import tv.superawesome.interfaces.SAAdInterface;
    import tv.superawesome.interfaces.SAParentalGateInterface;
    import tv.superawesome.interfaces.SAVideoAdInterface;

There are also a few global SDK parameters you can change according to your needs:

=============  ==============  =======
Parameter      Values          Meaning
=============  ==============  =======
Configuration  | Production *  | Should the SDK get ads from
               | Staging       | the production or test server.
                               | Test placements are all on production.

Test mode      | Enabled       | Should the SDK serve test ads. For test
               | Disabled *    | placements (30471, 30476, etc) must be Enabled.
=============  ==============  =======
 * = denotes default values

You can leave these settings as they are or change them to fit your testing or production needs, as follows:

.. code-block:: actionscript

    // Import all the SuperAwesome SDK library
    // with all subsequent namespaces
    import tv.superawesome.*

    //
    // AdobeAIRDemo is a generic Flash Builder
    // Mobile Project that will be exported to
    // either Android or iOS
    public class AdobeAIRDemo
            extends Sprite {

        public function AdobeAIRDemo() {

            SuperAwesome.getInstance().setConfigurationProduction();
            // SuperAwesome.getInstance().setConfigurationStaging();

            SuperAwesome.getInstance().enableTestMode();
            // SuperAwesome.getInstance().disableTestMode();
        }
    }
