CHANGELOG
=========

5.2.0
 - Updated the AIR SDK to communicate with the new iOS (5.4.0) and Android (5.4.0) SDKs
 - Those added support for a new WebPlayer that scales the ad using native code matrix manipulation
 - Also added support for the adEnded event, fired when a video ad ends (but not necessarily closes)
 - Added support for the adAlreadyLoaded event, fired when an Interstitial, Video or AppWall tries to load ad data for an already existing placement
 - Added support for the clickCounterUrl; that's been added as part of the native Ad Creative model class and is now fired when a user clicks an ad.

5.1.8
 - Updated the AIR SDK to communicate with the new iOS (5.3.17) and Android (5.3.13) SDKs.
 - Removed the staging CPI method from the SuperAwesome singleton class
 - All CPI calls now interact with both iOS and Android
 - All CPI calls now have a callback that lets the SDK user know if the Ad Server considered the install event to be valid or not.
 - Refactored some navtive method calls.

5.1.7
 - Updated the AIR SDK to be able to override iOS & Android native SDK version & sdk type. This means that all requests from the AIR SDK will be labeled as "air_x.y.z" instead of "android_x.y.z" or "ios_x.y.z", which in turn provide more accurate statistics for reporting.
 - Updated the method calls in each of the AIR-to-native methods so as to correspond to the new Android & iOS modular plugin structure.

5.1.6
 - Updated the main SDK classes to correspond to the new iOS and Android Plugins (for iOS 5.3.15 and Android 5.3.9)
 - Removed some internal enums such as SABannerSize that were causing problems
 - Added default values in the SuperAwesome singleton - now all SDK customizable values are initialised from those values. These should be kept in line with the iOS and Android ones.
