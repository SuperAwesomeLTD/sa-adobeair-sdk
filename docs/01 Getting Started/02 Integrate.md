### Download the necessary files

The new Adobe AIR SDK (v3 Beta) is compiled into a .swc file that you can download from here:
* [SuperAwesome_AIR.swc](https://github.com/SuperAwesomeLTD/sa-adobeair-sdk/blob/v3_beta/bin/SuperAwesome_AIR.swc?raw=true).

This will allow you to add Banner, Interstitial and Video Ads to your project.

Once you've downloaded these files, you need to add it to your project.


### Setup the Adobe Flash Builder Environment

Create a new Action Script Mobile Project (Adobe AIR) in Adobe Flash Builder (or use your existing one). This can be situated anywhere on your hard drive, such as:

  * C:/Workspace/MyAIRProject/
  * /Users/myuser/Workspace/MyAIRProject/

We'll refer to this location from now on simply as `/project_root`. There should be two important files in this folder:
  * `MyAIRProject.as` - or a similary named file, that acts as the main class of the application.
  * `MyAIRProject-app.xml`
as well as other files needed by Flash Builder.

![](img/project_source.png "Project setup")

### Adding the SDK

In Flash Builder, right-click on your project and select `Properties`. In the window that appears, select `ActionScript Build Path` and then the `Library path` tab. 
Once there, click on the `Add SWC` button and browse to where you downloaded the `SuperAwesome_AIR_v3Beta.swc` file, select it and click OK.

It's a good idea to save the .swc file somewhere save, maybe inside a `libs` subfolder in `/project_root`. 

![](img/project_withlib.png "Project with library reference")
