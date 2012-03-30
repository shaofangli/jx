package jx.common.listeners;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class AppListener implements ServletContextListener{
	
	private static Properties pops = null;
	private static ServletContext sct = null;
	private static String log4jrpath = null;
	private static AppBean appBean = new AppBean();
	
	private static final Log log = LogFactory.getLog(AppListener.class);
	
	public void contextDestroyed(ServletContextEvent sc) {
		log.debug("contextDestroyed..");
		try {
			pops.clear();
			sc.getServletContext().removeAttribute("w_appAdd");
			finalize();
		} catch (Exception e) {
			log.error("contextDestroyed:"+e.getMessage());
		} catch (Throwable e) {
			log.error("contextDestroyed:"+e.getMessage());
		}finally{
			pops = null;
			sct = null;
			log4jrpath = null;
		}
	}

	public void contextInitialized(ServletContextEvent sc) {
		log.debug("contextInitialized..");
		FileInputStream fis = null;
		try{
			if(pops == null)
				pops = new Properties();
			if(sct == null)
				sct = sc.getServletContext();
			if(log4jrpath ==null)
				log4jrpath = sct.getRealPath("/WEB-INF/classes/log4j.properties");
			
			fis = new FileInputStream(log4jrpath);
			pops.load(fis);
			
			sc.getServletContext().setAttribute("w_appAdd", appBean);
		}catch(Exception x){
			log.error("contextInitialized:"+x.getMessage());
		}finally{
			if(fis!=null){
				try {
					fis.close();
				} catch (IOException e) {
					log.error("contextInitialized:"+e.getMessage());
				}finally{
					fis=null;
				}
			}
		}
	}
	
	public static void setAppValue(){
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(log4jrpath);
			pops.store(fos, null);
		} catch (FileNotFoundException e) {
			log.error("setAppValue:"+e.getMessage());
		} catch (IOException e) {
			log.error("setAppValue:"+e.getMessage());
		}finally{
			if(fos!=null){
				try {
					fos.close();
				} catch (IOException e) {
					log.error("setAppValue:"+e.getMessage());
				}finally{
					fos=null;
				}
			}
		}
	}
	
	public static String getAppValue(String key){
		return pops.getProperty(key);
	}

	public static Properties getPops() {
		return pops;
	}

}
