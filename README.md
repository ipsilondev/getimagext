GetImagExt
==========

OpenFL extension for iOS and android to get the image full path from the camera or gallery sources

To be able to access to image files from sources as camera or gallery in iOS and Android. The extension returns a string in format:

$fullFileName;$ImageOrientation

the $fullFileName is the full path to the file, so it can be read from haxe with Sys.io for example. For this, on android and ios it require to create a temporal folder in the app directory in the device, so it has extra function that also return the app directory and can be used in your app to read/write new files from haxe directly.

Lib folder contain the extensions:
jn: the java source files for android
native: has the extension for ios

Made by **[Ipsilon Developments Inc.](http://www.ipsilondev.com)** released under **BSD license**

Like our **[Facebook](http://www.facebook.com/ipsilondev)** page to get news about our releases

Or Follow us on **[Twitter](https://twitter.com/ipsilondev)**

You can also contact us at **info [AT] ipsilondev.com**

### Supports

Tested on android 2.3 and android 4.1. On iOS tested on ipad and iphones with iOS 6 and iOS 7.
In the case of iOS 6 in ipad OR ipad with iOS 7 in landscape mode (when you set the project.xml in landscape) it will show the camera roll as a popup, as doesn't work in full screen mode.

### Known Issues

If you set your project in landscape, it will work on ipad why popupOver can be used to show the camera roll.
**But on iphone, the not supported orientation in views will CRASH the app !!!**. I'm not a iOS expert so i don't know this can be solved. if you know how, submit a pull request :)


How to use
==========

### Android

1) copy lib folder to your root project directory, you can erase the native folder inside if you are not planning to use it for ios

2) copy the AndroidManifest.xml template form lime sources (usually located in HaxeToolkit/haxe/lib/lime/templates/android/template or get it directly from the repository at here: https://github.com/openfl/lime/blob/master/templates/android/template/AndroidManifest.xml ) in the root directory of the project.

3) edit that AndroidManifest.xml and add before the MainActivity:

	<activity android:name="com.ipsilondev.getimagext.IntentManagerZ" android:screenOrientation="portrait" android:configChanges="locale"></activity>

then, on the permission section, at the bottom, add:

	<uses-feature android:name="android.hardware.camera"></uses-feature>
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/> 


4) open your project.xml and add:

<!-- including java files for the android extension -->
	<java path="lib/jn/src" if="android"></java>
	<template path="AndroidManifest.xml" if="android" />

5) be sure to add the JNI import and get the functions with JNI:

	import openfl.utils.JNI;

	//this returns the app directory
	getDirFunc = JNI.createStaticMethod("com/ipsilondev/getimagext/MainApp", "getAppDir", "()Ljava/lang/String;", true);
	//this initialize the camera, the gallery or a chooser intent depeding the parameter passed
	filesIntentFunc = JNI.createStaticMethod("com/ipsilondev/getimagext/MainApp", "filesIntent", "(Lorg/haxe/lime/HaxeObject;I)V",true);

6) when you want to show the gallery, the chooser intent or the camera, call the function like this:

	Lib.postUICallback( function()
	{
	//camera and all other image supported apps intent
	var ar:Array<Dynamic> = [instance, 1];
	//camera directly	
	//var ar:Array<Dynamic> = [instance, 2];
	//gallery/apps sources	
	//var ar:Array<Dynamic> = [instance,3];
	
	filesIntentFunc(ar);
	
	} );
		
instance variable is the current class instantiated, and should contain the callback function that receive the path to the file and orientation

7) be sure to declare a function named deviceGalleryFileSelectCallback in the class that would be "instance" 

	public function deviceGalleryFileSelectCallback(i:String):Void {
		var elems:Array<String> = i.split(";");
		fileDir.text = "path = "+elems[0];
		orientation.text = "orientation = "+elems[1];
	}
	
And you are done ! now you can read the file and do whatever you want with it.

### iOS

1) copy the lib folder, you can erase the jn folder that is inside if you are not going to use it.

2) inside the lib/native/ios folder there is a com folder, cut it and put it where your haxe source files are

3) import the haxe class to execute the ios functions

	#if ios
	import com.ipsilondev.getimagext.IOS_Native;
	#end

the macros are important, why if not the execution on any other platform will fail

4) then, in any part when you want to show the camera or the gallery, execute this code:

	#if ios
	iOSGetImgExt = IOS_Native;
    	if (iOSGetImgExt.checkAppDirectory()) {
			appDir.text = iOSGetImgExt.getAppDir();
			//iOSGetImgExt.initCamera(deviceGalleryFileSelectCallback);
			iOSGetImgExt.initGallery(deviceGalleryFileSelectCallback);
		}else {
			appDir.text = "can´t create tmp directory";
	}
	#end

is important to check the app directory first, and do not call the function if that is not possible.

.initCamera and .initGallery received the callback function directly as parameter, and it will return to that function the string with the full path and the orientation.

And you are Done !
