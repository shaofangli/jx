package jx.web.controller.sub;


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
import jx.common.tools.Utils;
import jx.web.bean.Zxbm;

public class ZxbmController extends JxQxMultiController{
	
	private String zxbm_initpg;  
	private String zxbm_showpg; 
	private String zxbm_initupdatepg;
	
	private static final Log log = LogFactory.getLog(ZxbmController.class);

	public ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("initZxbm...");
		return new ModelAndView(getViewName());
	}
	
	public  ModelAndView selectAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		if(pageInfo.getException() != null){
			return new ModelAndView(getZxbm_showpg(),"pageInfo",pageInfo); 
		}
		//System.out.println("selectAction.. ");
		
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        Zxbm zxbm = null;
        try {
        	db = new Database();
        	db.initialize();
        	pageInfo = new PageInfo();
        	
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	pageInfo.setPage_sql(
        			Utils.getWhereString(new String[]{"zjhm","sjhm","xm","sfcl"}, arg0,"select * from jx_w_zxbm ", " where ", "like", "and",""));
        	
        	db.execuPaginationSelect(pageInfo);
        	rs = pageInfo.getRs_obj();
        	
        	rsObj = new ArrayList();
        	
        	while(rs.next())
        	{
        		 zxbm = new Zxbm();
	           	 zxbm.setBz(rs.getString("bz"));
	           	 zxbm.setLxdz(rs.getString("lxdz"));
	           	 zxbm.setNl(rs.getString("nl"));
	           	 zxbm.setSjhm(rs.getString("sjhm"));
	           	 zxbm.setXb(rs.getString("xb"));
	           	 zxbm.setXm(rs.getString("xm"));
	           	 zxbm.setZjhm(rs.getString("zjhm"));
	           	 zxbm.setZjlx(rs.getString("zjlx"));
	           	 zxbm.setZy(rs.getString("zy"));
	           	 zxbm.setSfcl(rs.getString("sfcl"));
        		 rsObj.add(zxbm);
        	}
        	pageInfo.setAttribute_param(rsObj);
        	
        	return  new ModelAndView(this.getZxbm_showpg(),"pageInfo",pageInfo);
        	
        } catch (Exception ex) {
        	log.error("selectAction:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
        }
        return null;
	}
	public ModelAndView insertZxbm(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("insertZxbm.. ");
		
		Writer out = arg1.getWriter();
		ArrayList rsObj = null;
        Database db = null;
        ResultSet rs = null;
        int irs =0;
        try {
        	db = new Database();
        	db.initialize();
        	rsObj = new ArrayList();
        	rsObj.add(Utils.removeAllHtmltg(Utils.removeAllspaces(arg0.getParameter("bz"))));
        	rsObj.add(0);
        	
        	rs=db.executeQuery("select xm from jx_w_zxbm where zjhm='"+arg0.getParameter("zjhm")+"'");
        	if(rs.next()){
        		out.write("该证件号码已被'"+rs.getString("xm")+"'报名过了!");
        		return null;
        	}
        	irs= db.insert(Utils.getSqlParamList('i', "jx_w_zxbm", 
        		"xm={xm},xb={xb},zjlx={zjlx},zjhm={zjhm},sjhm={sjhm},lxdz={lxdz},bz=[0],sfcl=[1]", 
        		null, null, arg0, rsObj),rsObj.get(0).toString());
        	
        	if(irs > 0){
        		out.write("已成功提交你的在线报名信息,等待管理员处理");
        	}else{
        		out.write("提交信息失败!请联系管理员");
        	}
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("insertZxbm:"+ex.getMessage());
        } finally {
        	if(out!=null)
            	out.close();
        	if(db!= null){
        		db.terminate();
        	}
        	out = null;
        	db = null;
        }
        return null;
	}
	public ModelAndView deleteAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage().trim());
			return null;
		}
		//System.out.println("deleteAction.. ");
		
		ArrayList rsObj = null;
        Database db = null;
        int irs =0;
        try {
        	db = new Database();
        	db.initialize();
        	
        	irs= db.executeUpdate("delete from jx_w_zxbm where zjhm='"+arg0.getParameter("delid")+"'");
        	
        	if(irs > 0){
        		out.write("删除成功！");
        	}else{
        		out.write("删除失败!请联系管理员");
        	}
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("deleteAction:"+ex.getMessage());
        } finally {
        	if(out!=null)
            	out.close();
        	if(db!= null){
        		db.terminate();
        	}
        	db = null;
        	out = null;
        }
        return null;
	}
	public ModelAndView gDclNum(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("gDclNum.. ");
		Writer out = arg1.getWriter();
		Database db = null;
        ResultSet rs =null;
        String rnum = "0";
        try {
        	db = new Database();
        	db.initialize();
        	
        	rs= db.executeQuery("select count(zjhm) from jx_w_zxbm where sfcl=0");
        	
        	if(rs.next()){
        		rnum = rs.getString(1);
        	}
        	out.write(rnum);
        	return null;
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("gDclNum:"+ex.getMessage());
        } finally {
        	if(out!=null)
            	out.close();
        	if(db!= null){
        		db.terminate();
        	}
        	out = null;
        	db = null;
        }
        return null;
	}
	
	public  ModelAndView updateAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		 
		//System.out.println("updateAction.. ");
		int rs = 0;
        Database db = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	rs =db.executeUpdate("update jx_w_zxbm set sfcl='"+arg0.getParameter("sfcl")+"' where zjhm='"+arg0.getParameter("updateid")+"'");
        	if(rs>0){
        		out.write("更新状态成功！");
        	}else{
        		out.write("更新状态失败！");
        	}
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("updateAction:"+ex.getMessage());
        } finally {
        	if(out != null)
        		out.close();
        	if(db != null)
        		db.terminate();
            db = null;
            out = null;
        }
        return  null;
	}
	
	public String getZxbm_initpg() {
		return zxbm_initpg;
	}

	public void setZxbm_initpg(String zxbm_initpg) {
		this.zxbm_initpg = zxbm_initpg;
	}

	public String getZxbm_initupdatepg() {
		return zxbm_initupdatepg;
	}

	public void setZxbm_initupdatepg(String zxbm_initupdatepg) {
		this.zxbm_initupdatepg = zxbm_initupdatepg;
	}

	public String getZxbm_showpg() {
		return zxbm_showpg;
	}

	public void setZxbm_showpg(String zxbm_showpg) {
		this.zxbm_showpg = zxbm_showpg;
	}
}
