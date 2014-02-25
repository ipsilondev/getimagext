package com.ipsilondev.getimagext;


import cpp.Lib;


class IOS_Native 
{ // Start class iOS_Native.
	
	
	
	public static function getAppDir () : String 
	{
		
		return getAppDirFunc();
		
	}
	
	public static function checkAppDirectory () : Bool 
	{
		
		return checkAppDirectoryFunc();
		
	}
	
	public static function initGallery(func:String->Void):Void {
		initGalleryFunc(func);
	}
    public static function initCamera(func:String->Void):Void{
        initCameraFunc(func);
    }
	
	private static var initCameraFunc = Lib.load("iosnative","iOSNative_init_camera",1);
	private static var initGalleryFunc = Lib.load("iosnative","iOSNative_init_gallery",1);
	private static var checkAppDirectoryFunc = Lib.load("iosnative","iOSNative_check_app_directory",0);
	private static var getAppDirFunc = Lib.load("iosnative","iOSNative_get_app_dir",0);
	
} // End class iOS_Native.