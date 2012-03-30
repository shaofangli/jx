package jx.manage.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.Clob;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import jx.common.controller.JxQxMultiController;
import jx.common.db.Database;
import jx.common.models.PageInfo;
import jx.common.tools.FinallData;
import jx.common.tools.Utils;
import jx.manage.bean.Wz;
import jx.web.bean.User;

public class TpglController extends JxQxMultiController{
	
	private String tpgl_initpg;
	private String tpgl_showpg;
	private String tpgl_initupdatepg;
	 
	private static final Log log = LogFactory.getLog(TpglController.class);
	
	public ModelAndView tpGl (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("initTpgl2...");
		Database db = null;
		ResultSet rs = null;
		List rsList = null;
		Wz wz = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	rs = db.executeQuery("select  dh, lxmc from jx_w_tplx t where t.mk = 7");
        	
        	rsList = new ArrayList();
        	
        	while(rs.next()){
        		 wz = new Wz();
        		 wz.setDh(rs.getString("dh"));
        		 wz.setLxmc(rs.getString("lxmc"));
        		 rsList.add(wz);
        	}
        } catch (Exception ex) {
        	log.error("tpGl:"+ex.getMessage());
        } finally {
        	if(db!=null)
        	{
        		db.terminate();
                db = null;
        	}
        }
		return new ModelAndView(getTpgl_initpg(),"tplxs",rsList);
	}
	
	public  ModelAndView selectAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getTpgl_showpg(),"pageInfo",pageInfo);
		}
		//System.out.println("selectTp.. ");
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        Wz wz = null;
        String where = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	where = arg0.getParameter("lxdh").trim().length() == 0?"":" where lx = "+arg0.getParameter("lxdh").trim();
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	pageInfo.setPage_sql("select dh,alt,zz,scrq,gxrq,sx from jx_w_tp "+where+" order by sx");
        	
        	db.execuPaginationSelect(pageInfo);
        	rs = pageInfo.getRs_obj();
        	
        	rsObj = new ArrayList();
        	
        	while(rs.next())
        	{
        		 wz = new Wz();
        		 wz.setDh(rs.getString("dh"));
        		 wz.setBt(rs.getString("alt"));
        		 wz.setZz(rs.getString("zz"));
        		 wz.setFbrq(rs.getString("scrq"));
        		 wz.setGxrq(rs.getString("gxrq"));
        		 wz.setLxmc(rs.getString("sx"));
        		 rsObj.add(wz);
        	}
        	pageInfo.setAttribute_param(rsObj);
        } catch (Exception ex) {
        	arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("selectAction:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
        }
        if(arg0.getAttribute("delinfo") != null){
        	pageInfo.setExceptionMessage(arg0.getAttribute("delinfo").toString());
        }
        if(arg0.getAttribute("insertinfo") != null){
        	pageInfo.setExceptionMessage(arg0.getAttribute("insertinfo").toString());
        }
        return  new ModelAndView(getTpgl_showpg(),"pageInfo",pageInfo); 
	}
	public ModelAndView insertAction(HttpServletRequest arg0, HttpServletResponse arg1, PageInfo pageInfo) throws Exception {
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		//System.out.println("insertTpAction.. ");
		
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        try {
        	rsObj = new ArrayList();
        	
        	db = new Database();
        	db.initialize();
        	
        	rs = db.executeQuery("select max(dh)+1 from jx_w_tp");
        	if(rs.next()){
        		rsObj.add(rs.getInt(1));
        		rsObj.add(arg0.getParameter("bt"));
            	rsObj.add(arg0.getParameter("nr"));
            	rsObj.add(((User)arg0.getSession().getAttribute("usr")).getZh());
            	rsObj.add(arg0.getParameter("lx"));
            	rsObj.add(arg0.getParameter("sx"));
            	
            	db.update(rsObj,"insert into jx_w_tp(dh,alt,nr,zz,lx,sx) values(?,?,?,?,?,?)");
        	}
        	out.write("新增成功！");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("insertAction:"+ex.getMessage());
        	if(db != null)
        		db.rollback();
        } finally {
        	if(out != null)
        		out.close();
        	if(db != null)
        		db.terminate();
            db = null;
            out = null;
        }
        return null;
	}
	public ModelAndView deleteAction(HttpServletRequest arg0, HttpServletResponse arg1, PageInfo pageInfo) throws Exception {
		if(pageInfo.getException() != null){
			arg0.setAttribute("delinfo", pageInfo.getException().getMessage());
			pageInfo.clearException();
			return selectAction (arg0,arg1,pageInfo);
		}
		//System.out.println("deleteWz.. ");
        Database db = null;
        try {
        	db = new Database();
        	db.initialize();
        	 
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	int  rs = db.executeUpdate("delete from jx_w_tp where dh ='"+arg0.getParameter("delid")+"'");
        	if(rs > 0){
        		arg0.setAttribute("delinfo", "删除成功！");
        	}else{
        		arg0.setAttribute("delinfo", "删除失败！");
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("delinfo", ex.getMessage().trim());
        	log.error("deleteAction:"+ex.getMessage());
        } finally {
        	if(db!= null){
        		db.terminate();
                db = null;
        	}
        }
        return selectAction (arg0,arg1,pageInfo);
	}
	
	public  ModelAndView InitTpCzAction (HttpServletRequest arg0, HttpServletResponse arg1) throws IOException
	{
		//System.out.println("InitTpCzAction.. ");
		Wz wz = null;
		if("-1".equals(arg0.getParameter("tpid"))){
			wz = new Wz();
			wz.setUrl("js/comment/Kindeditor_tp_i.jsp");
			return  new ModelAndView(getTpgl_initupdatepg(),"up_tp",wz); 
		}
		ResultSet rs = null;
        Database db = null;
        Clob nrSource = null;
        String nrString = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	rs = db.executeQuery("select nr,dh,alt,sx from jx_w_tp  where dh="+arg0.getParameter("tpid"));
        	
        	while(rs.next())
        	{
        		wz = new Wz();
        		nrSource = rs.getClob("nr");
        	    nrString = nrSource.getSubString((long)1, (int)nrSource.length());
        	    
        	    wz.setNr(Utils.htmlspecialchars(nrString));
        	    wz.setBt(rs.getString("alt"));
        	    wz.setDh(rs.getString("dh"));
        	    wz.setLxmc(rs.getString("sx"));
        	    wz.setUrl("js/comment/Kindeditor_tp_u.jsp");
        	    break;
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("InitTpCzAction:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
            nrSource = null;
            nrString = null;
        }
        return  new ModelAndView(getTpgl_initupdatepg(),"up_tp",wz); 
	}
	
	public  ModelAndView updateAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		 
		//System.out.println("updateTpAction.. ");
		ArrayList rsObj = null;
        Database db = null;
        try {
        	rsObj = new ArrayList();
        	 
        	rsObj.add(arg0.getParameter("bt"));
        	rsObj.add(arg0.getParameter("nr"));
        	rsObj.add(((User)arg0.getSession().getAttribute("usr")).getZh());
        	rsObj.add(arg0.getParameter("sx"));
        	rsObj.add(arg0.getParameter("dh"));
        	
        	db = new Database();
        	db.initialize();
        	
        	db.update(rsObj,"update jx_w_tp set alt=? , nr = ?,gxrq = sysdate,zz=?,sx=? where dh=?");
        	
        	out.write("修改成功！");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("updateAction:"+ex.getMessage());
        	if(db!=null)
        		db.rollback();
        } finally {
        	if(out != null)
        		out.close();
        	if(db!=null)
        		db.terminate();
            db = null;
            out = null;
        }
        return  null;
	}

	public String getTpgl_initpg() {
		return tpgl_initpg;
	}

	public void setTpgl_initpg(String tpgl_initpg) {
		this.tpgl_initpg = tpgl_initpg;
	}

	public String getTpgl_initupdatepg() {
		return tpgl_initupdatepg;
	}

	public void setTpgl_initupdatepg(String tpgl_initupdatepg) {
		this.tpgl_initupdatepg = tpgl_initupdatepg;
	}

	public String getTpgl_showpg() {
		return tpgl_showpg;
	}

	public void setTpgl_showpg(String tpgl_showpg) {
		this.tpgl_showpg = tpgl_showpg;
	} 
}
