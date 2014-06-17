package com.ipsilondev.testimageextension;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.text.TextField;
import openfl.utils.JNI;
#if ios
import com.ipsilondev.getimagext.IOS_Native;
#end

/**
 * ...
 * @author Ipsilon Developments
 */

class Main extends Sprite 
{
	var inited:Bool;
	//variable that holds the static function that init the desired activity (source chooser, camera or gallery) ANDROID
	public static var filesIntentFunc:Dynamic;
    //variable that holds the static function that returns the app directory ANDROID
	public static var getDirFunc:Dynamic;
	//variable that holds the current instance to pass it to the java function. ANDROID
	public static var instance:Dynamic;
	
	//variable to access ios methods IOS
	public static var iOSGetImgExt:Dynamic;
	
	//just for testing purposes
	private var fileDir:TextField;
	private var orientation:TextField;
	private var appDir:TextField;
	
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		fileDir = new TextField();
		fileDir.width = 300;
		addChild(fileDir);
		orientation = new TextField();
		orientation.y = 30;
		addChild(orientation);
		appDir = new TextField();
		appDir.y = 60;
		appDir.width = 300;
		addChild(appDir);

		
		instance = this;
		#if android
		Lib.trace("lala 1");
		getDirFunc = JNI.createStaticMethod("com/ipsilondev/getimagext/MainApp", "getAppDir", "()Ljava/lang/String;", true);
		Lib.trace("lala 2");
		appDir.text = "appDir = "+getDirFunc();
		filesIntentFunc = JNI.createStaticMethod("com/ipsilondev/getimagext/MainApp", "filesIntent", "(Lorg/haxe/lime/HaxeObject;I)V",true);
		Lib.postUICallback( function()
		{
			//camera and all other image supported apps intent
				var ar:Array<Dynamic> = [instance, 1];
			//camera directly	
			//	var ar:Array<Dynamic> = [instance, 2];
			//gallery/apps sources	
			//	var ar:Array<Dynamic> = [instance,3];
				filesIntentFunc(ar);
				
		} );
		#end
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
		
		
		
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
	public function deviceGalleryFileSelectCallback(i:String):Void {
		var elems:Array<String> = i.split(";");
		fileDir.text = "path = "+elems[0];
		orientation.text = "orientation = "+elems[1];
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
