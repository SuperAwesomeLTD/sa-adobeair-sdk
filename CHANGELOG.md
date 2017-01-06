CHANGELOG
=========

5.1.7
 - Updated the AIR SDK to be able to override iOS & Android native SDK version & sdk type. This means that all requests from the AIR SDK will be labeled as "air_x.y.z" instead of "android_x.y.z" or "ios_x.y.z", which in turn provide more accurate statistics for reporting.
 - Updated the method calls in each of the AIR-to-native methods so as to correspond to the new Android & iOS modular plugin structure.

5.1.6
 - Updated the main SDK classes to correspond to the new iOS and Android Plugins (for iOS 5.3.15 and Android 5.3.9)
 - Removed some internal enums such as SABannerSize that were causing problems
 - Added default values in the SuperAwesome singleton - now all SDK customizable values are initialised from those values. These should be kept in line with the iOS and Android ones.
