To begin using the SDK, you need to change some parts of your `MyAIRProject.as` file, in order to import the tv.superawesome. package and setup some global variables:

```
package  {
	// imports needed files for AIR
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	// import all classes from the SuperAwesome package
	import tv.superawesome.*;
	
	// main class - always extends from MovieClip
	public class MyAIRProject extends Sprite {
		
		
		public function MyAIRProject() {

			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			// Configures SuperAwesome SDK to production mode
			SuperAwesome.getInstance().setConfigurationProduction();

			// enables or disabled test mode
			SuperAwesome.getInstance().enableTestMode();
		}
	}
	
}
```

The SuperAwesome SDK can be setup in two ways: Production and Staging, by using:

```
SuperAwesome.getInstance().setConfigurationProduction();
SuperAwesome.getInstance().setConfigurationStaging();

```

And you can also enable or disable test mode globally, by using:

```
SuperAwesome.getInstance().enableTestMode();
SuperAwesome.getInstance().disableTestMode();

```

By default the environment is setup with Production Mode and Test Mode disabled.



