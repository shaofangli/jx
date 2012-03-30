package jx.common.tools;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
 
public class EncodeURI {
 
	public static void main(String args[]) throws UnsupportedEncodingException {
		//String str = "http://passport.cnblogs.com/activate.aspx?id1="+encode("lsf");
//		String str = "\\zhong中文!@#~$%^&*()_+ ";
//		System.out.println(encode(str));
		System.out.println(URLEncoder.encode("ActivationUsr中文","UTF8"));
	}
	
	public static String encode(String str) throws UnsupportedEncodingException{
		String isoStr = new String(str.getBytes("UTF8"), "ISO-8859-1");		
		char[] chars = isoStr.toCharArray();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < chars.length; i++) {
			if ((chars[i] <= 'z' && chars[i] >= 'a')
					|| (chars[i] <= 'Z' && chars[i] >= 'A') || chars[i] == '-'
					|| chars[i] == '_' || chars[i] == '.' || chars[i] == '!'
					|| chars[i] == '~' || chars[i] == '*' || chars[i] == '\''
					|| chars[i] == '(' || chars[i] == ')' || chars[i] == ';'
					|| chars[i] == '/' || chars[i] == '?' || chars[i] == ':'
					|| chars[i] == '@' || chars[i] == '&' || chars[i] == '='
					|| chars[i] == '+' || chars[i] == '$' || chars[i] == ','
					|| chars[i] == '#') {
				sb.append(chars[i]);
			} else {
				sb.append("%");
				sb.append(Integer.toHexString(chars[i]));
			}
		}
		return sb.toString();
	}
}
