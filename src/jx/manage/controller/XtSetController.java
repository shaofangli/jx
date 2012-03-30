package jx.manage.controller;

import java.io.IOException;
import java.io.Writer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Properties;
import jx.common.controller.JxQxMultiController;
import jx.common.db.Database;
import jx.common.models.PageInfo;
import jx.common.tools.FinallData;
import jx.common.listeners.AppListener;
import jx.manage.bean.LogConfig;
import jx.web.bean.User;

public class XtSetController extends JxQxMultiController{
	private static final Log log = LogFactory.getLog(XtSetController.class);
	
	public  ModelAndView updateAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		 
		//System.out.println("updateAction.. ");
        Properties p = null;
        Enumeration en  = null;
        String rtmp = null;
        try {
        	en  = arg0.getParameterNames();
        	p = AppListener.getPops();
        	
        	while(en.hasMoreElements()){
        		rtmp = en.nextElement().toString();
        		if(!"method".equals(rtmp) && !"_".equals(rtmp)){
        			p.setProperty(rtmp,arg0.getParameter(rtmp));
        		}
        		rtmp = null;
        	}
        	p.setProperty("wz_whrzh", ((User)arg0.getSession().getAttribute("usr")).getZh());
        	AppListener.setAppValue();
        	out.write("保存设置成功！");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("updateAction:"+ex.getMessage());
        } finally {
        	if(out != null)
        		out.close();
        	p = null;
        	en = null;
        	out = null;
        }
        return  null;
	}
	
	public  ModelAndView selectAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		
		if(pageInfo.getException() != null){
			return  new ModelAndView(this.getViewName(),"pageInfo",pageInfo);
		}
		LogConfig cfg = null;
		Properties p = null;
		
		Database db = null;
		ArrayList rsObj = null;
		ResultSet rs = null;
		try {
			p = AppListener.getPops();
			cfg = new LogConfig();
			
			cfg.setEmailAddres(p.getProperty("emailAddres"));
			cfg.setPer_pageSize(p.getProperty("per_pageSize"));
			cfg.setSendName(p.getProperty("sendName"));
			cfg.setStmpHost(p.getProperty("stmpHost"));
			cfg.setUserName(p.getProperty("userName"));
			cfg.setUserPassword(p.getProperty("userPassword"));
			cfg.setWz_topnum(p.getProperty("wz_topnum"));
			cfg.setSubject(p.getProperty("subject"));
			cfg.setWz_close(p.getProperty("wz_close"));
			cfg.setWz_closeyy(p.getProperty("wz_closeyy"));
			cfg.setLyb_close(p.getProperty("lyb_close"));
			cfg.setLyb_closeyy(p.getProperty("lyb_closeyy"));
			cfg.setZxbm_close(p.getProperty("zxbm_close"));
			cfg.setZxbm_closeyy(p.getProperty("zxbm_closeyy"));
			cfg.setWz_description(p.getProperty("wz_description"));
			cfg.setWz_keywords(p.getProperty("wz_keywords"));
			cfg.setWz_title(p.getProperty("wz_title"));
			cfg.setWz_topnum(p.getProperty("wz_topnum"));
			cfg.setWz_dbxx(p.getProperty("wz_dbxx"));
			cfg.setWz_dz(p.getProperty("wz_dz"));
			cfg.setWz_mrzcjs(p.getProperty("wz_mrzcjs"));
			
			db = new Database();
        	db.initialize();
        	rs = db.executeQuery("select dh,mc from jx_m_js");
        	rsObj = new ArrayList();
        	while(rs.next()){
        		rsObj.add(new String[]{rs.getString("dh"),rs.getString("mc")});
        	}
        	arg0.setAttribute("jsjhs", rsObj);
		}catch (Exception ex) {
			pageInfo.setExceptionMessage(ex.getMessage());
			log.error("selectAction:"+ex.getMessage());
		}finally{
			p = null;
			if(db!=null){
        		db.terminate();
                db = null;
        	}
		}
        return  new ModelAndView(this.getViewName(),"xtszcfg",cfg);
	}
}
