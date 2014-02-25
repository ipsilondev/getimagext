package com.ipsilondev.getimagext;
import android.os.Environment;
import android.util.Log;
import java.io.File;
import android.content.Context;
import android.content.BroadcastReceiver;
import android.content.IntentFilter;
import android.content.Intent;
import java.io.FileNotFoundException;
public class FManager{
	
	public final Context context;
	public String state;
	public Boolean readyToUse = false;
	private BroadcastReceiver mExternalStorageReceiver;
	public static String UPDATE_MEMORY_STATE = "a";
	public final static int TMP = 3;
	
	//public final String 
	public FManager(Context cx){
			context = cx;
	}
	
	public void init(){
		updateMemoryState();
	}
	public void checkDirectories(){

	 File tmp = new File(context.getExternalFilesDir(null),"tmp");
	 if(!tmp.exists()){
		 tmp.mkdir();
	 }
	}
	public String getDir(){
		return context.getExternalFilesDir(null).getAbsolutePath();
	}
	public File getTmpFile(){
		 File tmp = new File(context.getExternalFilesDir(null),"tmp/tmpImage.jpg");
		 File finalTmp = new File(context.getExternalFilesDir(null),"tmp/tmpImage.jpg");;
		 if(tmp.exists()){
			 tmp.delete();
		 }
		 tmp = new File(context.getExternalFilesDir(null),"tmp/");
		 try{
			 finalTmp = File.createTempFile("tmpImage", ".jpg", tmp);			 
		 }catch(Exception e)
		    {
			 Log.w("error tmp file","error creating tmp file");
		    }
		 return finalTmp;
	}
	
	public void updateMemoryState(){
		state = Environment.getExternalStorageState();
	    if (Environment.MEDIA_MOUNTED.equals(state)) {
	    	readyToUse = true;	
	    	checkDirectories();
	    } else if (Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
	    	readyToUse = false;	
	    } else {
	    	readyToUse = false;	
	    }
	    //context.sendBroadcast(new Intent(FManager.class.getName()));
	}

}
