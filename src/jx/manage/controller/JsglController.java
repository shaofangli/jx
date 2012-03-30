package jx.manage.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import jx.common.controller.JxQxMultiController;
import jx.common.db.Database;
import jx.common.models.PageInfo;
import jx.common.tools.FinallData;
import jx.manage.bean.Js;
import jx.manage.bean.Jscz;

public class JsglController extends JxQxMultiController{
	
	private String jsgl_initpg;  
	private String jsgl_showpg; 
	private String jsgl_initupdatepg;
	
	private static final Log log = LogFactory.getLog(JsglController.class);
	 
	public String getJsgl_initupdatepg() {
		return jsgl_initupdatepg;
	}

	public void setJsgl_initupdatepg(String jsgl_initupdatepg) {
		this.jsgl_initupdatepg = jsgl_initupdatepg;
	}

	public String getJsgl_initpg() {
		return jsgl_initpg;
	}

	public void setJsgl_initpg(String jsgl_initpg) {
		this.jsgl_initpg = jsgl_initpg;
	}

	public ModelAndView jsGl (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("initJsgl2...");
		return new ModelAndView(getJsgl_initpg());
	}
	
	public  ModelAndView selectAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getJsgl_showpg(),"pageInfo",pageInfo); 
		}
		//System.out.println("selectJs.. ");
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        Js js = null;
        String where = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	where = arg0.getParameter("jsmc").trim().length() == 0?"":" where mc like '%"+arg0.getParameter("jsmc").trim()+"%'";
        	rs = db.executeQuery("select dh,mc,mks from jx_m_js "+where);
        	
        	rsObj = new ArrayList();
        	
        	while(rs.next())
        	{
        		 js = new Js();
	           	 js.setDh(rs.getString("dh"));
	           	 js.setMc(rs.getString("mc"));
	           	 js.setMks(rs.getString("mks"));
        		 rsObj.add(js);
        	}
        	pageInfo.setAttribute_param(rsObj);
        } catch (Exception ex) {
        	pageInfo.setException(ex);
        	log.error("selectAction:"+ex.getMessage());
        } finally {
        	if(db!=null){
        		db.terminate();
                db = null;
        	}
        }
        if(arg0.getAttribute("delinfo") != null){
        	pageInfo.setExceptionMessage(arg0.getAttribute("delinfo").toString());
        }
        if(arg0.getAttribute("insertinfo") != null){
        	pageInfo.setExceptionMessage(arg0.getAttribute("insertinfo").toString());
        }
        return  new ModelAndView(getJsgl_showpg(),"pageInfo",pageInfo); 
	}
	public ModelAndView insertAction(HttpServletRequest arg0, HttpServletResponse arg1, PageInfo pageInfo) throws Exception {
		if(pageInfo.getException() != null){
			arg0.setAttribute("insertinfo", pageInfo.getException().getMessage());
			pageInfo.clearException();
			return selectAction (arg0,arg1,pageInfo);
		}
		//System.out.println("insertJs.. ");
        Database db = null;
        ResultSet rs = null;
        int jsid = 0;
        String jsmc = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	String sql = "select max(dh)+1 from jx_m_js";
        	rs = db.executeQuery(sql);
        	
        	int irs = 0;
        	if(rs.next()){
        		jsid = rs.getInt(1);
        		jsmc = arg0.getParameter("jsmc");
        		sql = "insert into jx_m_js(dh,mc) values("+jsid+",'"+jsmc+"')";
        		irs = db.executeUpdate(sql);
        	}
        	
        	if(irs > 0){
        		arg0.setAttribute("insertinfo", "添加角色成功！");
        	}else{
        		arg0.setAttribute("insertinfo", "添加角色失败！");
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("insertinfo", ex.getMessage().trim());
        	log.error("insertAction:"+ex.getMessage());
        } finally {
        	if(db!= null){
        		db.terminate();
                db = null;
        	}
        }
        return selectAction (arg0,arg1,pageInfo);
	}
	public ModelAndView deleteAction(HttpServletRequest arg0, HttpServletResponse arg1, PageInfo pageInfo) throws Exception {
		if(pageInfo.getException() != null){
			arg0.setAttribute("delinfo", pageInfo.getException().getMessage());
			pageInfo.clearException();
			return selectAction (arg0,arg1,pageInfo);
		}
		//System.out.println("deleteJsx.. ");
        Database db = null;
        try {
        	db = new Database();
        	db.initialize();
        	 
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	String sql = "delete from jx_m_js where dh='"+arg0.getParameter("delid")+"'";
        	int  rs = db.executeUpdate(sql);
        	if(rs > 0){
        		arg0.setAttribute("delinfo", "删除成功！");
        	}else{
        		arg0.setAttribute("delinfo", "删除失败！");
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("delinfo", FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("deleteAction:"+ex.getMessage());
        } finally {
        	if(db!= null){
        		db.terminate();
                db = null;
        	}
        }
        return selectAction (arg0,arg1,pageInfo);
	}
	
	public  ModelAndView InitJsCzAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getJsgl_initupdatepg(),"pageInfo",pageInfo); 
		}
		//System.out.println("InitJsCzAction.. ");
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        Jscz jscz = null;
        try {
        	db = new Database();
        	db.initialize();
        	 
        	rs = db.executeQuery("select q.jsdh,c.dh,q.qx,c.nm from " +
        			"(select * from jx_m_qx where jsdh = "+arg0.getParameter("jsid")+")q ,jx_m_cz c " +
        			"where  q.czdh(+) = c.dh order by c.dh");
        	
        	rsObj = new ArrayList();
        	
        	while(rs.next())
        	{
        		jscz = new Jscz();
        		jscz.setCzdh(rs.getString("dh"));
        		jscz.setJsdh(arg0.getParameter("jsid"));
        		jscz.setNm(rs.getString("nm"));
        		jscz.setQx(String.valueOf(rs.getInt("qx")));
        		rsObj.add(jscz);
        	}
        	pageInfo.setAttribute_param(rsObj);
        	
        	rs.close();
        	rs = db.executeQuery("select mks,mc from jx_m_js where dh= "+arg0.getParameter("jsid"));
        	if(rs.next())
        	{
        		pageInfo.setAttribute_value(new String[]{rs.getString("mks"),rs.getString("mc")});
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("InitJsCzAction:"+ex.getMessage());
        } finally {
        	if(db!=null)
        	{
        		db.terminate();
                db = null;
        	}
        }
        return  new ModelAndView(getJsgl_initupdatepg(),"pageInfo",pageInfo); 
	}
	
	public  ModelAndView updateAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		 
		//System.out.println("updateAction.. ");
        Database db = null;
        try {
        	db = new Database();
        	db.initialize();
        	db.setAutoCommit(false);
        	proceUpdate(arg0,db);
        	db.commit();
        	out.write("保存成功！");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("updateAction:"+ex.getMessage());
        	if(db!=null)
        		db.rollback();
        } finally {
        	if(out != null)
        		out.close();
        	out = null;
        	if(db!=null)
        	{
        		db.terminate();
                db = null;
        	}
        }
        return  null;
	}
	 
	private void proceUpdate(HttpServletRequest arg0,Database db){
		String[] prms = arg0.getParameter("parm").split("jsdh=");
		ArrayList oprm = new ArrayList();
		String jsdh = null;
		String[] mks = null;
        StringBuffer mksbuf = null;
        
		for(int i=0;i<prms.length;i++){
				if(prms[i] ==null || prms[i].length() ==0)
					continue;
				String[] xxs = prms[i].split(";");
				jsdh = xxs[0].trim();
				String czdh =xxs[1].substring(xxs[1].indexOf("=")+1,xxs[1].length()).trim();
				String qx = (xxs.length>2)?(xxs[2] == null?"0":"1"):"0";
				//System.out.println("-->>"+jsdh+"|"+czdh+"|"+qx+"|");
				oprm.add(qx);
				oprm.add(jsdh);
				oprm.add(czdh);
				if(db.update(oprm,"update jx_m_qx set qx=? where jsdh=? and czdh=?") <= 0){
					oprm.add(1);
					db.insert(oprm, "insert into jx_m_qx (qx,jsdh,czdh,xs) values(?,?,?,?)");
				}
				oprm.clear();
		}
		
		if(arg0.getParameterValues("mks")!=null){
    		mks = arg0.getParameterValues("mks");
    		mksbuf = new StringBuffer("$");
    		for(int i=0;i<mks.length;i++){
    			mksbuf.append(mks[i]+"$");
    		}
    		db.executeUpdate("update jx_m_js set mks='"+mksbuf.toString()+"',mc='"+arg0.getParameter("gx_jsmc")+"' where dh="+jsdh);
    	}else{
    		db.executeUpdate("update jx_m_js set mks= null,mc='"+arg0.getParameter("gx_jsmc")+"' where dh="+jsdh);
    	}
	}

	public String getJsgl_showpg() {
		return jsgl_showpg;
	}

	public void setJsgl_showpg(String jsgl_showpg) {
		this.jsgl_showpg = jsgl_showpg;
	}
}
