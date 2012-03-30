package jx.web.controller.sub;

import java.io.PrintWriter;
import java.sql.Clob;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jx.common.controller.JxBasicMultiController;
import jx.common.db.Database;
import jx.common.listeners.AppListener;
import jx.common.tools.FinallData;
import jx.web.bean.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;


public class SubController extends JxBasicMultiController {
	
	private String initlybpg;
	private String initzxbmpg;
	
	private static final Log log = LogFactory.getLog(SubController.class);
	
	public ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("view...");
		String tpath = null;
		String tpath2 = null;
		try {
			tpath = arg0.getParameter("path");
        	tpath2 = tpath.substring(tpath.indexOf(">>")+2);
		}catch (Exception ex) {
        	log.error("view:"+ex.getMessage());
        } 
		arg0.setAttribute("dh",arg0.getParameter("dh"));
		arg0.setAttribute("subdh",arg0.getParameter("subdh"));
        arg0.setAttribute("submenuid", arg0.getParameter("t_submenuid"));
        arg0.setAttribute("subbt",tpath2.substring(0, tpath2.indexOf(">>")));
        return  new ModelAndView(this.getViewName(),"ljbt", tpath); 
	}
	
	public ModelAndView getsubnr (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("getsubnr...");
		ResultSet rs = null;
        Database db = null;
        Clob nrSource = null;
        String nrString = null;
        StringBuffer rsql = null;
        PrintWriter out = arg1.getWriter();
        try {
        	db = new Database();
        	db.initialize();
        	
        	rsql = new StringBuffer("select nr from jx_w_wz w inner join jx_w_wzlx l on w.lx = l.dh where l.lxmc ='"+arg0.getParameter("dh"));
        	
        	if("-1".equals(arg0.getParameter("subdh"))){
        		rsql.append("' and w.dh = substr(l.topdh,2,(contains(substr(l.topdh,2),'$')-contains(l.topdh,'$')))");
        	}else{
        		rsql.append("' and w.dh = "+arg0.getParameter("subdh"));
        	}
        	rs = db.executeQuery(rsql.toString());
        	if(rs.next())
        	{
        	    nrSource = rs.getClob("nr");
        	    nrString = nrSource.getSubString((long)1, (int)nrSource.length());
        	}else{
        		nrString="没有置顶内容!";
        	}
        	out.write(nrString);
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("getsubnr:"+ex.getMessage());
        } finally {
        	if(out!=null)
            	out.close();
        	if(db != null)
        		db.terminate();
            db = null;
            out = null;
            nrSource = null;
            if(rsql!=null)
            	rsql.delete(0, rsql.length());
        }
        return null; 
	}
	
	public ModelAndView initlyb (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("sub_initLyb...");
		
		String tpath = null;
		String tpath2 = null;
		try {
			tpath = arg0.getParameter("path");
			tpath2 = tpath.substring(tpath.indexOf(">>")+2);
		}catch (Exception ex) {
        	log.error("initlyb:"+ex.getMessage());
        } 
        arg0.setAttribute("submenuid", arg0.getParameter("t_submenuid"));
        arg0.setAttribute("subbt",tpath2.substring(0, tpath2.indexOf(">>")));
        arg0.setAttribute("ljbt",tpath);
        if("1".equals(AppListener.getAppValue("lyb_close"))){
  		   if(AppListener.getAppValue("wz_whrzh") != null && arg0.getSession().getAttribute("usr") !=null){
  			   if(!AppListener.getAppValue("wz_whrzh").equals((((User)arg0.getSession().getAttribute("usr")).getZh())))
  	    	    	throw new ModelAndViewDefiningException(new ModelAndView("/common/errors/wz_err","er_msg",AppListener.getAppValue("lyb_closeyy")));
  		   }else{
  			   throw new ModelAndViewDefiningException(new ModelAndView("/common/errors/wz_err","er_msg",AppListener.getAppValue("lyb_closeyy")));
  		   }
 		}
		return new ModelAndView(getInitlybpg());
	}
	public ModelAndView initzxbm (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("sub_initZxbm...");
		
		String tpath = null;
		String tpath2 = null;
		try {
			tpath = arg0.getParameter("path");
			tpath2 = tpath.substring(tpath.indexOf(">>")+2);
		}catch (Exception ex) {
        	log.error("initzxbm:"+ex.getMessage());
        } 
        arg0.setAttribute("submenuid", arg0.getParameter("t_submenuid"));
        arg0.setAttribute("subbt",tpath2.substring(0, tpath2.indexOf(">>")));
        arg0.setAttribute("ljbt",tpath);
        if("1".equals(AppListener.getAppValue("zxbm_close"))){
	 		   if(AppListener.getAppValue("wz_whrzh") != null && arg0.getSession().getAttribute("usr") !=null){
	 			   if(!AppListener.getAppValue("wz_whrzh").equals((((User)arg0.getSession().getAttribute("usr")).getZh())))
	 	    	    	throw new ModelAndViewDefiningException(new ModelAndView("/common/errors/wz_err","er_msg",AppListener.getAppValue("zxbm_closeyy")));
	 		   }else{
	 			   throw new ModelAndViewDefiningException(new ModelAndView("/common/errors/wz_err","er_msg",AppListener.getAppValue("zxbm_closeyy")));
	 		   }
		}
		return new ModelAndView(getInitzxbmpg());
	}
	
	public String getInitlybpg() {
		return initlybpg;
	}

	public void setInitlybpg(String initlybpg) {
		this.initlybpg = initlybpg;
	}

	public String getInitzxbmpg() {
		return initzxbmpg;
	}

	public void setInitzxbmpg(String initzxbmpg) {
		this.initzxbmpg = initzxbmpg;
	}
}
