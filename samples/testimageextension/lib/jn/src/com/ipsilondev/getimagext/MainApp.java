package com.ipsilondev.getimagext;

import java.util.Random;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager;
import org.haxe.lime.HaxeObject;
import android.content.Intent;
import android.util.Log;
import android.content.pm.PackageManager.NameNotFoundException;

import com.ipsilondev.getimagext.IntentManagerZ;

public class MainApp extends org.haxe.lime.GameActivity {
	public static HaxeObject callback;
	public static int typeActivity;
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	public static String getAppDir(){
		FManager fm = new FManager(getInstance().getContext());
		return fm.getDir();
	}
	
	public static void filesIntent(HaxeObject cb, int tp){
		callback = cb;
		typeActivity = tp;		
	//	getInstance().startActivity(new Intent(getInstance().getContext(),IntentManagerZ.class).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK));
		getInstance().startActivityForResult(new Intent(getInstance().getContext(),IntentManagerZ.class).setFlags(Intent.FLAG_ACTIVITY_NEW_TASK),1);
	}
	
	
	
	
	
	

}
