### Debug

Debugging with Flash AIR will involve using their simulator, which performs OK for most tasks.

### Deployment

Deployment on both iOS and Android platforms involves some careful measure regarding each type of platform.
Remember that both system support multiple resolutions. Super Awesome SDK is built to handle all these resolutions, with some limitations:
  * Banner ads will scale their content so that the ad will always maintain aspect ration
  * Interstitials will always try to cover the whole screen and maintain the Ads aspect ration
  * Videos will not maintain aspect ratio