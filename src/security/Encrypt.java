package security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Encrypt {
	public static String MD5(String text) {
		MessageDigest md;
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(text.getBytes());
		    byte byteData[] = md.digest();
		    StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++)
	            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		} 
	}
}
