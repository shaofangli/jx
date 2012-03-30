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
import jx.common.listeners.AppListener;
import jx.common.models.PageInfo;
import jx.common.tools.FinallData;
import jx.common.tools.Utils;
import jx.manage.bean.Wz;
import jx.web.bean.User;

public class WzglController extends JxQxMultiController{
	
	private String wzgl_initpg;
	private String wzgl_showpg;
	private String wzgl_initupdatepg;
	 
	private static final Log log = LogFactory.getLog(WzglController.class);
	
	public ModelAndView wzGl (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("initWzgl2...");
		Database db = null;
		ResultSet rs = null;
		List rsList = null;
		List opList = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	rs = db.executeQuery("select  t.dh, t.lxmc, t.pdh,d.lxmc mc from jx_w_wzlx t inner join jx_w_wzlx d on t.pdh=d.dh " +
        			"where t.mk = 6 and t.pdh <> 0 and t.dh not in(25,23) order by t.pdh");
        	
        	rsList = new ArrayList();
        	Object[] obj = null;
        	while(rs.next()){
        		 String tmpdh = rs.getString("pdh");
        		 
        		 if(opList == null)
        			 opList = new ArrayList();
        		  
    			 if(obj == null || !tmpdh.equals(obj[0])){
    				 opList = new ArrayList();
    				 obj = new Object[]{rs.getString("pdh"),rs.getString("mc"),opList};
    			 }
    			 opList.add(new String[]{rs.getString("dh"),rs.getString("lxmc")});
        		 
    			 if(!rsList.contains(obj))
    				 rsList.add(obj);
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("wzGl:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
        }
		return new ModelAndView(getWzgl_initpg(),"wzlxs",rsList);
	}
	
	public  ModelAndView selectAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getWzgl_showpg(),"pageInfo",pageInfo);
		}
		//System.out.println("selectWz.. ");
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        Wz wz = null;
        String where = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	where = Utils.getWhereString(new String[]{"l.pdh","l.dh"}, arg0, "", " where ", "=", " and ", "");
        	
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	pageInfo.setPage_sql("select w.dh,l.lxmc,l.dh lxdh,w.bt,w.zz,w.fbrq,w.gxrq,(case when contains(l.topdh,'$'||w.dh||'$') <> -1 then 0 else 1 end) sftop" +
        			" from jx_w_wz w inner join jx_w_wzlx l on w.lx = l.dh "+where+" order by sftop asc,w.fbrq desc");
        	
        	db.execuPaginationSelect(pageInfo);
        	rs = pageInfo.getRs_obj();
        	
        	rsObj = new ArrayList();
        	
        	while(rs.next())
        	{
        		 wz = new Wz();
        		 wz.setDh(rs.getString("dh"));
        		 wz.setLxmc(rs.getString("lxmc"));
        		 wz.setLxdh(rs.getString("lxdh"));
        		 wz.setBt(rs.getString("bt"));
        		 wz.setZz(rs.getString("zz"));
        		 wz.setFbrq(rs.getString("fbrq"));
        		 wz.setGxrq(rs.getString("gxrq"));
        		 wz.setSfzd(rs.getString("sftop"));
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
        return  new ModelAndView(getWzgl_showpg(),"pageInfo",pageInfo); 
	}
	public ModelAndView insertAction(HttpServletRequest arg0, HttpServletResponse arg1, PageInfo pageInfo) throws Exception {
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		//System.out.println("insertWzAction.. ");
		
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        try {
        	rsObj = new ArrayList();
        	
        	db = new Database();
        	db.initialize();
        	
        	rs = db.executeQuery("select max(dh)+1 from jx_w_wz");
        	if(rs.next()){
        		rsObj.add(rs.getInt(1));
        		rsObj.add(arg0.getParameter("bt"));
            	rsObj.add(arg0.getParameter("nr"));
            	rsObj.add(((User)arg0.getSession().getAttribute("usr")).getZh());
            	rsObj.add(arg0.getParameter("lx"));
            	
            	db.update(rsObj,"insert into jx_w_wz(dh,bt,nr,zz,lx) values(?,?,?,?,?)");
        	}
        	out.write("新增成功！");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("insertAction:"+ex.getMessage());
        	if(db!=null)
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
        String deldh = null;
        String dlxdh = null;
        try {
        	db = new Database();
        	db.initialize();
        	db.setAutoCommit(false);
        	deldh = arg0.getParameter("delid");
        	dlxdh = arg0.getParameter("dlxdh");
        	 
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	int  rs = db.executeUpdate("delete from jx_w_wz where dh ='"+deldh+"'");
        	if(rs > 0){
        		db.executeUpdate("update jx_w_wzlx set topdh=replace(topdh,'$'||'"+deldh+"'||'$','$') where dh="+dlxdh);
        		db.commit();
        		arg0.setAttribute("delinfo", "删除成功！");
        	}else{
        		arg0.setAttribute("delinfo", "删除失败！");
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("delinfo", ex.getMessage().trim());
        	log.error("deleteAction:"+ex.getMessage());
        	if(db!= null)
        		db.rollback();
        } finally {
        	if(db!= null){
        		db.terminate();
                db = null;
        	}
        }
        return selectAction (arg0,arg1,pageInfo);
	}
	
	public  ModelAndView InitWzCzAction (HttpServletRequest arg0, HttpServletResponse arg1) throws IOException
	{
		//System.out.println("InitWzCzAction.. ");
		Wz wz = null;
		if("-1".equals(arg0.getParameter("wzid"))){
			wz = new Wz();
			wz.setUrl("js/comment/Kindeditor_wz_i.jsp");
			return  new ModelAndView(getWzgl_initupdatepg(),"up_wz",wz); 
		}
		ResultSet rs = null;
        Database db = null;
        Clob nrSource = null;
        String nrString = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	rs = db.executeQuery("select nr,bt,dh from jx_w_wz  where dh="+arg0.getParameter("wzid"));
        	
        	while(rs.next())
        	{
        		wz = new Wz();
        	    nrSource = rs.getClob("nr");
        	    nrString = nrSource.getSubString((long)1, (int)nrSource.length());
        	    
        	    wz.setNr(Utils.htmlspecialchars(nrString));
        	    wz.setBt(rs.getString("bt"));
        	    wz.setDh(rs.getString("dh"));
        	    wz.setUrl("js/comment/Kindeditor_wz_u.jsp");
        	    break;
        	}
        } catch (Exception ex) {
        	arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("InitWzCzAction:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
            nrSource = null;
            nrString = null;
        }
        return  new ModelAndView(getWzgl_initupdatepg(),"up_wz",wz); 
	}
	
	public  ModelAndView updateAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		 
		//System.out.println("updateWzAction.. ");
		ArrayList rsObj = null;
        Database db = null;
        try {
        	rsObj = new ArrayList();
        	 
        	rsObj.add(arg0.getParameter("bt"));
        	rsObj.add(arg0.getParameter("nr"));
        	rsObj.add(((User)arg0.getSession().getAttribute("usr")).getZh());
        	rsObj.add(arg0.getParameter("dh"));
        	
        	db = new Database();
        	db.initialize();
        	
        	db.update(rsObj,"update jx_w_wz set bt=? , nr = ?,gxrq = sysdate,zz=? where dh=?");
        	
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
	public  ModelAndView setTopwz(HttpServletRequest arg0, HttpServletResponse arg1) throws IOException
	{
		
		Writer out = arg1.getWriter();
		//System.out.println("setTopwz.. ");
		
        Database db = null;
        ResultSet rstop = null;
        String rstopstr = null;
        int rs = 0;
        try {
        	db = new Database();
        	db.initialize();
        	
        	rstop = db.executeQuery("select topdh from jx_w_wzlx where dh="+arg0.getParameter("czdh"));
        	if(rstop.next()){
        		rstopstr = rstop.getString("topdh");
        	}
        	if(rstopstr!= null && rstopstr.replace('$', ',').split(",").length-1 >= Integer.parseInt(AppListener.getPops().getProperty("wz_topnum").toString())){
        		out.write("置顶失败,已经达到最大置顶数目！");
        		return null;
        	}
        	
        	rs = db.executeUpdate("update jx_w_wzlx set topdh=topdh||'"+arg0.getParameter("zdid")+"'||'$' where dh="+arg0.getParameter("czdh"));
        	if(rs>0)
        		out.write("置顶成功！");
        	else
        		out.write("置顶失败！请联系管理员");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("setTopwz:"+ex.getMessage());
        } finally {
        	if(out != null)
        		out.close();
        	if(db!=null)
        		db.terminate();
            db = null;
            out=null;
        }
        return  null;
	}
	public  ModelAndView cxTopwz(HttpServletRequest arg0, HttpServletResponse arg1) throws IOException
	{
		
		Writer out = arg1.getWriter();
		//System.out.println("cxTopwz.. ");
        Database db = null;
        String cxdh = null;
        String lxdh = null;
        int rs = 0;
        try {
        	db = new Database();
        	db.initialize();
        	
        	cxdh = arg0.getParameter("zdid");
        	lxdh = arg0.getParameter("czdh");
        	
        	rs = db.executeUpdate("update jx_w_wzlx set topdh=replace(topdh,'$'||'"+cxdh+"'||'$','$') where dh="+lxdh);
        	if(rs>0)
        		out.write("撤销置顶成功！");
        	else
        		out.write("撤销置顶失败！请联系管理员");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("cxTopwz:"+ex.getMessage());
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
	
	public String getWzgl_initpg() {
		return wzgl_initpg;
	}

	public void setWzgl_initpg(String wzgl_initpg) {
		this.wzgl_initpg = wzgl_initpg;
	}

	public String getWzgl_initupdatepg() {
		return wzgl_initupdatepg;
	}

	public void setWzgl_initupdatepg(String wzgl_initupdatepg) {
		this.wzgl_initupdatepg = wzgl_initupdatepg;
	}

	public String getWzgl_showpg() {
		return wzgl_showpg;
	}

	public void setWzgl_showpg(String wzgl_showpg) {
		this.wzgl_showpg = wzgl_showpg;
	}
}
