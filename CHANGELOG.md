CHANGELOG
=========

6.1.1
 - Updated to work with iOS 6.1.2 and Android 6.1.1
 - Small bug fixes

6.1.0
 - Updated to work with iOS and Android 6.1.0
 - Added a Bumper Page that can overlap any ad (video, banner, interstitial, app wall)
 - Separated Parental Gate into separate library

6.0.3
 - Updated to work with Android 6.0.4
 - Fixes a bug in SABannerAd related to playing an ad and quickly closing it before rendering

6.0.2
 - Updated to work with Android 6.0.3
 - In that I reverted MoPub adapter to have classic class path

6.0.1
 - Update to work with Android 6.0.2

6.0.0
 - Added support for iOS 6.0.0 and Android 6.0.0
 - Split the SDK into Publishers and Advertisers SDKs (another separate one)
 - Changed the namespacing convention from SuperAwesome to tv.superawesome.sdk.publisher
 - Got rid of the SuperAwesome base class and now I have SADefines and SAVersion

5.5.2
 - Added support for iOS 5.7.2 and Android 5.7.4
 - Fixed a bug that caused video & interstitial ads that failed to load once, sending the adFailedToLoad callback event, start always sending adAlreadyLoaded on subsequent failed loads

5.5.1
 - Added support for iOS 5.7.1 and Android 5.7.3
 - Added support for the adEmpty callback

5.5.0
 - Added support for iOS & Android 5.7.0 version, which:
 - Adds support for AdMob
 - Fixed bugs in iOS & Android related to banners, padlocks, etc
 - Refactores the MoPub plugin to have the same naming convention as the AdMob, Unity and AIR plugins

5.4.0
 - Update the Adobe AIR SDK to work with the Android (5.6.0) and iOS (5.6.0) SDKs
 - Add MRAID support for banner & interstitial ads
 - Update MOAT version to latest supported

5.3.5
 - Updated the Adobe AIR SDK to work wiith the Android (5.5.7) and iOS (5.5.8) SDKs
 - Added camel & snake case options when parsing the SACreative object - for click, impression and install
 - Added the osTarget parameter to the SACreative
 - Fixed some bugs occuring for SAEvents / SAVideoAd / SAInterstitialAd/ SAAppWall on Android

5.3.4
 - Updated the Adobe AIR SDK to work with the new Android (5.5.6) and iOS (5.5.5) SDKs. This fixes a smal
l error when the video player tries to play a non-video creative but doesn't auto-close.

5.3.3
 - Updated the Adobe AIR SDK to work with the new Android (5.5.4) and iOS (5.5.4) SDKs that load data in webviews using a base url as well

5.3.2
 - Updated the AIR SDK to work with the new Android (5.5.3) and iOS (5.5.3) SDKs that add support for scrollable interstitial ads

5.3.1
 - Updated the AIR SDK to communicate with the new Android (5.5.2) and iOS (5.5.2) SDKs that add improvements to the modelspace and eventing systems

5.3.0
 - Updated the AIR SDK to communicate with the new Android (5.5.0) and iOS (5.5.0) SDKs
 - Added a separate SACPI class (singleton) to handle all CPI:
    - communicating with native methods
    - receiving a callback with a "success" parameter
    - also removed any reference of CPI in the SuperAwesome class (singleton)
 - Contains changes done in the 5.5.0 versions of the native SDKs:
    - reworked CPI
    - reworked events
    - reworked video player (for Android)
    - improvements & bug fixes

5.2.2
 - Updated the AIR SDK to communicate with the new Android (5.4.8) and iOS (5.4.1) SDKs
 - Banner ads don't fire up an "adClosed" event on first load
 - On iOS the "setOrientationLandscape" and "setOrientationPortrait" methods will take into account the available orientations the app provides
 - The video ad close button will appear by default after 15 seconds of content playing

5.2.1
 - Updated the AIR SDK to communicate with the new Android (5.4.8) SDK. 
 - That removed the need to add layout and drawable resources to the build and changed slightly the Android manifest to change in your AIR project.
 - As a consequence all the UI elements are generated in code, even images (through base64 encoded strings).
 - This also adds a new and improved video player that is much more versatile.

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
