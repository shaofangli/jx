package jx.common.tools;

import com.uwyn.jhighlight.renderer.Renderer;
import com.uwyn.jhighlight.renderer.XhtmlRendererFactory;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.modeler.Registry;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.management.MBeanServer;
import javax.management.ObjectName;
import javax.management.MalformedObjectNameException;
import java.io.*;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import java.util.Set;
import java.util.regex.Pattern;

public class Utils {

	private static final Log log = LogFactory.getLog(Utils.class);
    private static Pattern p = Pattern.compile("\\s*|\t|\r|\n");
    private static Pattern htmlp = Pattern.compile("<.+?>",Pattern.DOTALL);
    
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static int calcPoolUsageScore(int max, int busy, int total) {
        return max > 0 ? (busy + Math.max(0, (total - busy) / 3)) * 100 / max : 0;
    }

    public static void copyFile(File src, File dest) throws IOException {

        dest.getParentFile().mkdirs();

        if (dest.exists()) {
            dest.delete();
        }

        FileInputStream fis = new FileInputStream(src);
        try {
            byte buffer[] = new byte[65535];

            FileOutputStream fos = new FileOutputStream(dest);
            try {
                int ln;
                while ((ln = fis.read(buffer)) > 0) {
                    fos.write(buffer, 0, ln);
                }
            } finally {
                fos.close();
            }
        } finally {
            fis.close();
        }
    }

    public static String readFile(File file, String charsetName) throws IOException {
        String result = null;
        FileInputStream fis = new FileInputStream(file);
        try {
            result = readStream(fis, charsetName);
        } finally {
            fis.close();
        }
        return result;
    }

    public static String readStream(InputStream is, String charsetName) throws IOException {

        //
        // use system's default encoding if the passed encoding is unsupported
        //
        Charset charset = Charset.forName(System.getProperty("file.encoding"));
        if (Charset.isSupported(charsetName)) {
            charset = Charset.forName(charsetName);
        }

        StringBuffer out = new StringBuffer();
        BufferedReader r = new BufferedReader(new InputStreamReader(is, charset), 4096);
        try {
            String b;
            while ((b = r.readLine()) != null) {
                out.append(b).append("\n");
            }
        } finally {
            r.close();
        }

        return out.toString();
    }

    public static void delete(File f) {
        if (f != null && f.exists()) {
            if (f.isDirectory()) {
                File files[] = f.listFiles();
                for (int i = 0; i < files.length; i++) {
                    delete(files[i]);
                }
            }
            if (!f.delete()) {
                log.debug("Cannot delete " + f.getAbsolutePath());
            }
        } else {
            log.debug(f + " does not exist");
        }
    }

    public static int toInt(String num, int defaultValue) {
        try {
            return Integer.parseInt(num);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public static int toIntHex(String num, int defaultValue) {
        try {
            if (num != null && num.startsWith("#")) num = num.substring(1);
            return Integer.parseInt(num, 16);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public static int toInt(Integer num, int defaultValue) {
        return num == null ? defaultValue : num.intValue();
    }

    public static long toLong(Long num, long defaultValue) {
        return num == null ? defaultValue : num.longValue();
    }

    public static String getJSPEncoding(InputStream is) throws IOException {

        String encoding = null;
        String contentType = null;

        Tokenizer jspTokenizer = new Tokenizer();
        jspTokenizer.addSymbol("\n", true);
        jspTokenizer.addSymbol(" ", true);
        jspTokenizer.addSymbol("\t", true);
        jspTokenizer.addSymbol(new TokenizerSymbol("dir", "<%@", "%>", false, false, true, false));

        StringTokenizer directiveTokenizer = new StringTokenizer();
        directiveTokenizer.addSymbol("\n", true);
        directiveTokenizer.addSymbol(" ", true);
        directiveTokenizer.addSymbol("\t", true);
        directiveTokenizer.addSymbol("=");
        directiveTokenizer.addSymbol("\"", "\"", false);
        directiveTokenizer.addSymbol("'", "'", false);

        StringTokenizer contentTypeTokenizer = new StringTokenizer();
        contentTypeTokenizer.addSymbol(" ", true);
        contentTypeTokenizer.addSymbol(";", true);


        Reader reader = new InputStreamReader(is, "ISO-8859-1");
        try {
            jspTokenizer.setReader(reader);
            while (jspTokenizer.hasMore()) {
                Token token = jspTokenizer.nextToken();
                if ("dir".equals(token.getName())) {
                    directiveTokenizer.setString(token.getInnerText());
                    if (directiveTokenizer.hasMore() && directiveTokenizer.nextToken().getText().equals("page")) {
                        while (directiveTokenizer.hasMore()) {
                            Token dTk = directiveTokenizer.nextToken();
                            if ("pageEncoding".equals(dTk.getText())) {
                                if (directiveTokenizer.hasMore() && "=".equals(directiveTokenizer.nextToken().getText()))
                                {
                                    if (directiveTokenizer.hasMore()) {
                                        encoding = directiveTokenizer.nextToken().getInnerText();
                                        break;
                                    }
                                }
                            } else if ("contentType".equals(dTk.getText())) {
                                if (directiveTokenizer.hasMore() && "=".equals(directiveTokenizer.nextToken().getText()))
                                {
                                    if (directiveTokenizer.hasMore()) {
                                        contentType = directiveTokenizer.nextToken().getInnerText();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } finally {
            reader.close();
        }

        if (encoding == null && contentType != null) {
            contentTypeTokenizer.setString(contentType);
            while (contentTypeTokenizer.hasMore()) {
                String token = contentTypeTokenizer.nextToken().getText();
                if (token.startsWith("charset=")) {
                    encoding = token.substring("charset=".length());
                    break;
                }
            }
        }

        return encoding != null ? encoding : "ISO-8859-1";
    }

    public static void sendFile(HttpServletRequest request, HttpServletResponse response, File file) throws IOException {
        OutputStream out = response.getOutputStream();
        RandomAccessFile raf = new RandomAccessFile(file, "r");
        try {
            long fileSize = raf.length();
            long rangeStart = 0;
            long rangeFinish = fileSize - 1;

            // accept attempts to resume download (if any)
            String range = request.getHeader("Range");
            if (range != null && range.startsWith("bytes=")) {
                String pureRange = range.replaceAll("bytes=", "");
                int rangeSep = pureRange.indexOf("-");

                try {
                    rangeStart = Long.parseLong(pureRange.substring(0, rangeSep));
                    if (rangeStart > fileSize || rangeStart < 0) rangeStart = 0;
                } catch (NumberFormatException e) {
                    // ignore the exception, keep rangeStart unchanged
                }

                if (rangeSep < pureRange.length() - 1) {
                    try {
                        rangeFinish = Long.parseLong(pureRange.substring(rangeSep + 1));
                        if (rangeFinish < 0 || rangeFinish >= fileSize) rangeFinish = fileSize - 1;
                    } catch (NumberFormatException e) {
                        // ignore the exception
                    }
                }
            }

            // set some headers
            response.setContentType("application/x-download");
            response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
            response.setHeader("Accept-Ranges", "bytes");
            response.setHeader("Content-Length", Long.toString(rangeFinish - rangeStart + 1));
            response.setHeader("Content-Range", "bytes " + rangeStart + "-" + rangeFinish + "/" + fileSize);

            // seek to the requested offset
            raf.seek(rangeStart);

            // send the file
            byte buffer[] = new byte[4096];

            long len;
            int totalRead = 0;
            boolean nomore = false;
            while (true) {
                len = raf.read(buffer);
                if (len > 0 && totalRead + len > rangeFinish - rangeStart + 1) {
                    // read more then required?
                    // adjust the length
                    len = rangeFinish - rangeStart + 1 - totalRead;
                    nomore = true;
                }

                if (len > 0) {
                    out.write(buffer, 0, (int) len);
                    totalRead += len;
                    if (nomore) break;
                } else {
                    break;
                }
            }
        } finally {
            raf.close();
        }
    }

    public static Thread getThreadByName(String name) {
        if (name != null) {
            //
            // get top ThreadGroup
            //
            ThreadGroup masterGroup = Thread.currentThread().getThreadGroup();
            while (masterGroup.getParent() != null) {
                masterGroup = masterGroup.getParent();
            }


            Thread threads[] = new Thread[masterGroup.activeCount()];
            int numThreads = masterGroup.enumerate(threads);

            for (int i = 0; i < numThreads; i++) {
                if (threads[i] != null && name.equals(threads[i].getName())) {
                    return threads[i];
                }
            }
        }
        return null;
    }

    public static String highlightStream(String name, InputStream input, String rendererName, String encoding) throws IOException {

        Renderer jspRenderer = XhtmlRendererFactory.getRenderer(rendererName);
        if (jspRenderer != null) {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            jspRenderer.highlight(name, input, bos, encoding, true);

            ByteArrayInputStream bis = new ByteArrayInputStream(bos.toByteArray());

            Tokenizer tokenizer = new Tokenizer(new InputStreamReader(bis, encoding));
            tokenizer.addSymbol(new TokenizerSymbol("EOL", "\n", null, false, false, true, false));
            tokenizer.addSymbol(new TokenizerSymbol("EOL", "\r\n", null, false, false, true, false));

            //
            // JHighlight adds HTML comment as the first line, so if
            // we number the lines we could end up with a line number and no line
            // to avoid that we just ignore the first line alltogether.
            //
            StringBuffer buffer = new StringBuffer();
            long counter = 0;
            while (tokenizer.hasMore()) {
                Token tk = tokenizer.nextToken();
                if ("EOL".equals(tk.getName())) {
                    counter++;
                    buffer.append(tk.getText());
                } else if (counter > 0) {
                    buffer.append("<span class=\"codeline\">");
                    buffer.append("<span class=\"linenum\">");
                    buffer.append(leftPad(Long.toString(counter), 6, "&nbsp;"));
                    buffer.append("</span>");
                    buffer.append(tk.getText());
                    buffer.append("</span>");
                }
            }
            return buffer.toString();
        }
        return null;
    }

    public static String leftPad(String s, int len, String fill) {
        StringBuffer sb = new StringBuffer(len);
        if (s.length() < len) {
            for (int i = s.length(); i < len; i++) {
                sb.append(fill);
            }
        }
        sb.append(s);
        return sb.toString();
    }

    public static List getNamesForLocale(String baseName, Locale locale) {
        List result = new ArrayList(3);
        String language = locale.getLanguage();
        String country = locale.getCountry();
        String variant = locale.getVariant();
        StringBuffer temp = new StringBuffer(baseName);

        if (language.length() > 0) {
            temp.append('_').append(language);
            result.add(0, temp.toString());
        }

        if (country.length() > 0) {
            temp.append('_').append(country);
            result.add(0, temp.toString());
        }

        if (variant.length() > 0) {
            temp.append('_').append(variant);
            result.add(0, temp.toString());
        }

        return result;
    }

    public static boolean isThreadingEnabled() {
        try {
            MBeanServer mBeanServer = new Registry().getMBeanServer();
            ObjectName threadingOName = new ObjectName("java.lang:type=Threading");
            Set s = mBeanServer.queryMBeans(threadingOName, null);
            return s != null && s.size() > 0;
        } catch (MalformedObjectNameException e) {
        	log.error("isThreadingEnabled:"+e.getMessage());
            return false;
        }
    }
    
    public static long getidate(String inputdt) {
		   long i = -1;
		   Calendar cal  = null;
		   try {
			   	  cal  = Calendar.getInstance();
				  
				  i = (Math.abs(sdf.parse(inputdt).getTime()-sdf.parse(cal.getTime().toLocaleString()).getTime())/(1000 * 60 * 60 * 24));  
				  //System.out.println("相差" + i + "天");
		   } catch (Exception e){
			   log.error("getidate:"+e.getMessage());
		   }
		   return i;
    }
    
    public static String htmlspecialchars(String str) {
    	str = str.replaceAll("&", "&amp;");
    	str = str.replaceAll("<", "&lt;");
    	str = str.replaceAll(">", "&gt;");
    	str = str.replaceAll("\"", "&quot;");
    	return str;
    }
    /** 
    * 判断字符串是否是整数 
    */ 
    public static boolean isInteger(String value) { 
    try { 
    Integer.parseInt(value); 
    return true; 
    } catch (NumberFormatException e) { 
    return false; 
    } 
    } 

    /** 
    * 判断字符串是否是浮点数 
    */ 
    public static boolean isDouble(String value) { 
    try { 
    Double.parseDouble(value); 
    if (value.contains(".")) 
    return true; 
    return false; 
    } catch (NumberFormatException e) { 
    return false; 
    } 
    } 

    /** 
    * 判断字符串是否是数字 
    */ 
    public static boolean isNumber(String value) { 
    return isInteger(value) || isDouble(value); 
    } 

    public static boolean stringNotEmptOrNull(String obj) {
        try {
            if(obj != null && obj.trim().length() > 0)
            	return true;
            else
            	return false;
        } catch (Exception e) {
            return false;
        }
    }
    
    public static String stringIsEmptOrNull(String obj) {
        try {
            if(obj != null && obj.trim().length() > 0)
            	return obj.trim();
            else
            	return "";
        } catch (Exception e) {
            return "";
        }
    }
    /**
     * 
     * @param args 参数列表:如({xm,id,jh});
     * @param arg0
     * @param sql:固定sql;v0: where / '' ;v1: = / like ;  v2: and / or
     * @return xm=arg0[0] and id =arg0[1] and jh = arg0[2]
     */
    public static String getWhereString(String[] args,HttpServletRequest arg0,String before,String v0,String v1,String v2,String end){
    	StringBuffer whereSql = null;
    	try {
    		 if(args != null)
    			 whereSql = new StringBuffer();
    		 else
    			 return null;
             for(int i=0;i<args.length;i++)
             {
            	 String tmparg = args[i].indexOf('.')==-1?args[i]:args[i].substring(args[i].indexOf('.')+1);
            	 if(!stringIsEmptOrNull(arg0.getParameter(tmparg)).equals(""))
            	 {
            		 whereSql.append(((args[i].lastIndexOf("rq")!=-1)?"to_char("+args[i]+",'yyyy-mm-dd HH24:Mi:ss') ":args[i]+" ")+v1+" '"+(v1.indexOf("like")!=-1?"%":"")+stringIsEmptOrNull(arg0.getParameter(tmparg))+(v1.indexOf("like")!=-1?"%":"")+"' "+v2+" ");
            	 }else
            		 continue;
             }
             if(whereSql.length() ==0)
            	 return before+end;
             else
            	 return before+v0+whereSql.toString().substring(0,whereSql.lastIndexOf(" "+v2+" "))+end;
        } catch (Exception e) {
        	log.error("getWhereString:"+e.getMessage());
        	return before+end;
        }
    }
	   
	/**
	 * Remove all spaces */
    public static String removeAllspaces(String instr){
	    return p.matcher(instr).replaceAll("");
    }
    /**
	 * Remove all htmltag */
    public static String removeAllHtmltg(String instr){
	    return htmlp.matcher(instr).replaceAll("");
    }
    /**
	    * Generate a random string*/
	   public static String getRandomString(String prefix,String postfix,String inregx,int length){
		   
		    if(inregx == null || "".equals(inregx.trim())){
			   inregx = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		    }
		    
		    Random random = new Random();
			StringBuffer sb = new StringBuffer(0);

			for (int i = 0; i < length; ++i)
			{
				int number = random.nextInt(inregx.length());

				sb.append(inregx.charAt(number));
			}
			
			if(prefix != null && !"".equals(prefix)){
				sb.insert(0, prefix);
			}
			if(postfix != null && !"".equals(postfix)){
				sb.insert(sb.length(), postfix);
			}
			return sb.toString();
	   }
	   /**
	    * 
	    * @param flg		标识符,i/d/u/s 分别代表增删改查
	    * @param tablenm	操作的表名
	    * @param colms		操作的列名 xm,xb,yx=1 1 表示yx使用自定义的参数索引为1,其余的用getParam获得;
	    * @param where		操作的where语句列 与 colms 一样
	    * @param req		
	    * @param objs
	    * @return			一个是?所对应的value值的list，一个是返回sql用objs.get(0)获得;
	    * @throws Exception
	    */
	   public static ArrayList getSqlParamList(char flg,String tablenm,String colms,String where,String other,HttpServletRequest req,List objs) throws Exception{
			ArrayList parm = new ArrayList();
			
			
			StringBuffer sql = new StringBuffer();
			
			String colsql = null;
			String wheresql = null;
			if(flg == 'u' || flg == 'i'){
				  colsql = parscw(flg,1,colms,  parm,  req,  objs);
			}
			if(flg != 'i'){
				  wheresql = parscw(flg,2,where,  parm,  req,  objs);
			}
			
			switch(flg)
            {
            	case 's': sql.append("select "+colms.replaceAll("(=(\\{|\\[)\\w+(\\}|\\]))|(=\\w+)", "")+" from "+tablenm+( (wheresql==null)?"":(" where "+wheresql)));break;
            	case 'u': sql.append("update "+tablenm+" set "+colsql+(wheresql==null?"":(" where "+wheresql)));break;
            	case 'i': sql.append("insert into "+tablenm+ (colsql == null?"":"("+colms.replaceAll("(=(\\{|\\[)\\w+(\\}|\\]))|(=\\w+)", "")+")")+" values("+colsql+")");break;
            	case 'd': sql.append("delete from "+tablenm+(wheresql==null?"":(" where "+wheresql)));break;
            }
			if(other != null && other.trim().length() > 0)
				sql.append(" "+other);
				
			objs.clear();
			objs.add(sql.toString());
			//System.out.println("-->"+sql.toString());
			return parm;
	  }
	   public static String getSqlParamString(char flg,String tablenm,String colms,String where,String other) throws Exception{
			StringBuffer sql = new StringBuffer();
			
			String colsql = null;
			String wheresql = null;
			if(flg == 'u' || flg == 'i'){
				  colsql = parscw(flg,1,colms,  null,  null,  null);
			}
			if(flg != 'i'){
				  wheresql = parscw(flg,2,where,  null,  null,  null);
			}
			
			switch(flg)
           {
           	case 's': sql.append("select "+colms.replaceAll("(=(\\{|\\[)\\w+(\\}|\\]))|(=\\w+)", "")+" from "+tablenm+( (wheresql==null)?"":(" where "+wheresql)));break;
           	case 'u': sql.append("update "+tablenm+" set "+colsql+(wheresql==null?"":(" where "+wheresql)));break;
           	case 'i': sql.append("insert into "+tablenm+ (colsql == null?"":"("+colms.replaceAll("(=(\\{|\\[)\\w+(\\}|\\]))|(=\\w+)", "")+")")+" values("+colsql+")");break;
           	case 'd': sql.append("delete from "+tablenm+(wheresql==null?"":(" where "+wheresql)));break;
           }
			if(other != null && other.trim().length() > 0)
				sql.append(" "+other);
			
			return sql.toString();
	  }
	   
	 private static String parscw(char flg,int cw,String parStr,List parm,HttpServletRequest req,List objs){
		 
		 if(parStr == null || parStr.trim().length() == 0)
			 return null;
		 
		 if(cw==2 && (parStr.indexOf(" and ") != -1 || parStr.indexOf(" or ") != -1 || 
				 parStr.indexOf(" order by ") != -1 || parStr.indexOf(" having ") != -1))
			 return parStr;
		 
		 StringBuffer sql = new StringBuffer();
		 
		 String[] reqprms = parStr.indexOf(',')==-1? new String[]{parStr}:parStr.split(",");
		 String subvalue = null;
		 for(String tmp : reqprms){
				
				subvalue = tmp.substring(tmp.indexOf("=")+1, tmp.length());//Integer.parseInt(tmp.substring(tmp.indexOf("=")+1, tmp.length()));
				
				if(subvalue.indexOf("[") != -1 || subvalue.indexOf("{") != -1){
					if(subvalue.indexOf("[") != -1 &&  parm != null){
						parm.add(objs.get(Integer.parseInt(subvalue.substring(1,subvalue.length()-1))));
					}
					if(subvalue.indexOf("{") != -1 &&  parm != null){
						parm.add(req.getParameter(subvalue.substring(1,subvalue.length()-1)));
					}
					
					if(flg == 'i'){
						if(reqprms.length > 1)
							sql.append("?,");
						else
							sql.append("?");
					}
					if(flg == 'u' && cw == 1){
						 if(reqprms.length > 1)
							 sql.append(tmp.substring(0, tmp.indexOf("=")+1)+"?,");
						 else
							 sql.append(tmp.substring(0, tmp.indexOf("=")+1)+"?");
					}
					if(cw == 2){
						sql.append(tmp.substring(0, tmp.indexOf("=")+1)+"? and ");
					}
				}else{
					if(cw == 1){
						if(reqprms.length > 1)
							sql.append(tmp+",");
						else
							sql.append(tmp);
					}
					if(cw == 2){
							sql.append(tmp+" and ");
					}
				}
			}
		
		 if(cw ==2){
			 return sql.substring(0, sql.lastIndexOf(" and "));
		 }else{
			 return (reqprms.length > 1)?sql.substring(0,sql.length()-1):sql.toString();
		 }
	 }
	 
	 public static void main(String[] args) throws Exception{
		 
		   //String d = "zh,xm,mm,xb,yx,dh,csrq,mmbhwt,mmbhda,zcsj=0,zhdl=0,jsdh=1";
		   
		  // System.out.println("zh={zh},xm={xm},mm={mm},xb={xb},yx={yx},dh={dh},mmbhwt={mmbhwt},mmbhda={mmbhda},jsdh=0,csrq=[0]".replaceAll("(=(\\{|\\[)\\w+(\\}|\\]))|(=\\w+)", ""));
		   
//		   HttpServletRequest arg0 = null;
//		   ArrayList myprm = new ArrayList();
//       	   myprm.add(1);
//       	   myprm.add(2);
//       	   Utils.getSqlParamList('i',"jx_m_yh","a.sfjh=[0]","b.zh=[1]",arg0, myprm);
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
	 }
				   
}
