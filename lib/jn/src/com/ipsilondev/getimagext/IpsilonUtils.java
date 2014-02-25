package com.ipsilondev.getimagext;

import java.util.Random;

public class IpsilonUtils {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	
	public static String getRandomStr(int qty){
		String d = "abcdfghijklmnopqrtuvwxyz";
		Random rand = new Random();
		int i = 0;
		int n = 0;
		String f = "";
		while(i<qty){
			n = rand.nextInt(24 - 0 + 1) + 0;
			f +=d.substring(n, n+1);
			i++;
		}
		return f;
	}

}
