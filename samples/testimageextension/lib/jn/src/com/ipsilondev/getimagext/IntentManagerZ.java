package com.ipsilondev.getimagext;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.ProgressBar;
import android.util.Log;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.ComponentName;
import android.os.Parcelable;
import java.util.List;
import java.util.ArrayList;
import android.provider.MediaStore;
import java.io.FileNotFoundException;
import java.io.IOException;
import android.net.Uri;
import java.io.File;
import android.media.ExifInterface;
import android.database.Cursor;
import org.haxe.lime.HaxeObject;
import android.content.Context;
import org.haxe.lime.GameActivity;

import com.ipsilondev.getimagext.FManager;
import com.ipsilondev.getimagext.MainApp;

public class IntentManagerZ  extends Activity {
	/**
	 * @param args
	 */
	public static IntentManagerZ instance = null;
	private static final int CAMERA_REQUEST = 1888; 
	public static final int VIEW_NUM = 6;
	private static Uri tmpURI;
	private static File tmpFILE;
//	public FManager filemanager;
	public int resultInt = 0;
	public int resultOrientation = 0;
	static HaxeObject callback;
	public Context c;
	public void main(String[] args) {
		// TODO Auto-generated method stub
	}
	@Override
	public void onCreate(Bundle savedInstanceState) {
	    super.onCreate(savedInstanceState);
	    c = getApplicationContext();
	    instance = this;
	    LinearLayout ll = new LinearLayout(c);
	    LayoutParams lp = new LayoutParams(LayoutParams.FILL_PARENT, 
        LayoutParams.FILL_PARENT);
	    ll.setLayoutParams(lp);
	    ll.setOrientation(LinearLayout.VERTICAL);
	    ll.setGravity(Gravity.CENTER_HORIZONTAL);
	    ll.setVerticalGravity(Gravity.CENTER_VERTICAL);
	    ProgressBar bar = new ProgressBar(c,null,android.R.attr.progressBarStyleInverse);
	    ll.addView(bar);
	    setContentView(ll);
	    makeIntent();
	    // TODO Auto-generated method stub
	}
	
	
	public static IntentManagerZ getInstance()
	{
		return instance;
	}
	public void makeIntent(){
		FManager filemanager = new FManager(c);
		filemanager.init();
		final Intent captureIntent; 
		final Intent galleryIntent;
		final Intent chooserIntent;
		final List<Intent> cameraIntents;
	    final PackageManager packageManager;
	    final List<ResolveInfo> listCam;

	    //final Intent captureIntent = new Intent(c,android.provider.MediaStore.class);
	    //captureIntent.setAction(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
	    if(MainApp.typeActivity==1){			
	    captureIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
	    tmpFILE = filemanager.getTmpFile();	    
	    tmpURI = Uri.fromFile(tmpFILE);
	    captureIntent.putExtra(MediaStore.EXTRA_OUTPUT, tmpURI);
	    
	    cameraIntents = new ArrayList<Intent>();
	    packageManager = c.getPackageManager();
	    listCam = packageManager.queryIntentActivities(captureIntent, 0);
		for(ResolveInfo res : listCam) {
	        final String packageName = res.activityInfo.packageName;
	        final Intent intent = new Intent(captureIntent);
	        intent.setComponent(new ComponentName(res.activityInfo.packageName, res.activityInfo.name));
	        intent.setPackage(packageName);
	        cameraIntents.add(intent);
	    }
	    galleryIntent = new Intent();
	    galleryIntent.setType("image/*");
	    galleryIntent.setAction(Intent.ACTION_GET_CONTENT);
		// Chooser of filesystem options.
	    chooserIntent = Intent.createChooser(galleryIntent, "Select Source");

	    // Add the camera options.
	    chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, cameraIntents.toArray(new Parcelable[]{}));
	    //resultInt = 0;
	    instance.startActivityForResult(chooserIntent, CAMERA_REQUEST);

	    }else if(MainApp.typeActivity==2){
	    captureIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
	    tmpFILE = filemanager.getTmpFile();	    
	    tmpURI = Uri.fromFile(tmpFILE);
	    captureIntent.putExtra(MediaStore.EXTRA_OUTPUT, tmpURI);
		instance.startActivityForResult(captureIntent, CAMERA_REQUEST);
		}else if(MainApp.typeActivity==3){
	    // Filesystem.
	    galleryIntent = new Intent();
	    galleryIntent.setType("image/*");
	    galleryIntent.setAction(Intent.ACTION_GET_CONTENT);
		instance.startActivityForResult(galleryIntent, CAMERA_REQUEST);
		}
		
	    

	}
	
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (requestCode == CAMERA_REQUEST && resultCode == RESULT_OK) {

	        	final String action = data.getAction();
	        	if(action!=null){
	        		
	        		resultOrientation =  getFileOrientation(tmpFILE.getAbsolutePath());
		        	MainApp.callback.call("deviceGalleryFileSelectCallback", new Object[] {""+tmpFILE.getAbsolutePath()+";"+resultOrientation});
	   		 	}else{
	   		 		String fileStr = getFullPathUri(data.getData());
	   		 		resultOrientation = getFileOrientation(fileStr); 
		        	MainApp.callback.call("deviceGalleryFileSelectCallback", new Object[] {""+fileStr+";"+resultOrientation});

	   		 	}
	        }
		
		 		finish();
	    }
	
	 public int getFileOrientation(Uri l){
		 ExifInterface exif;   
		 String[] proj = { MediaStore.Images.Media.DATA };
     	 Cursor cursor = getContentResolver().query(l, proj, null, null, null);
		    int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
	        cursor.moveToFirst();
	        String fileOrient = "";
	        int degreesOrient = 0;
	        try{
	        	exif = new ExifInterface(cursor.getString(column_index));
	        	fileOrient = exif.getAttribute(ExifInterface.TAG_ORIENTATION);
	        }catch (IOException ex){
	        	
	        }
	        if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_90){
	        	degreesOrient = 90;
     	}
	        else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_180){
	        degreesOrient = 180;
     	}else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_270){		
	        	degreesOrient = 270;
	        }
	        return degreesOrient;
	 }
	 
	 public int getFileOrientation(File l){
		 ExifInterface exif;   
	        String fileOrient = "";
	        int degreesOrient = 0;
	        try{
	        	exif = new ExifInterface(l.getAbsolutePath());
	        	fileOrient = exif.getAttribute(ExifInterface.TAG_ORIENTATION);
	        }catch (IOException ex){
	        	
	        }
	        if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_90){
	        	degreesOrient = 90;
     	}
	        else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_180){
	        degreesOrient = 180;
     	}else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_270){		
	        	degreesOrient = 270;
	        }
	        return degreesOrient;
	 }
	 
	 public int getFileOrientation(String q){
		 ExifInterface exif;   
	        String fileOrient = "";
	        int degreesOrient = 0;
	        try{
	        	exif = new ExifInterface(q);
	        	fileOrient = exif.getAttribute(ExifInterface.TAG_ORIENTATION);
	        }catch (IOException ex){
	        	
	        }
	        if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_90){
	        	degreesOrient = 90;
     	}
	        else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_180){
	        degreesOrient = 180;
     	}else if(Integer.parseInt(fileOrient)==ExifInterface.ORIENTATION_ROTATE_270){		
	        	degreesOrient = 270;
	        }
	        return degreesOrient;
	 }
	 public String getFullPathUri(Uri l){
		 String[] proj = { MediaStore.Images.Media.DATA };
     	 Cursor cursor = getContentResolver().query(l, proj, null, null, null);
		    int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
	        cursor.moveToFirst();
	        return cursor.getString(column_index);
	 }
	
	public static int sum(){
		return 10;
	}
}
