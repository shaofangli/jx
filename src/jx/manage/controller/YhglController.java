package jx.manage.controller;

import java.io.IOException;
import java.io.Writer;
import java.sql.Date;
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
import jx.web.bean.User;

public class YhglController extends JxQxMultiController{
	
	private String yhgl_initpg;  
	private String yhgl_showpg; 
	private String yhgl_initupdatepg;
	
	private static final Log log = LogFactory.getLog(YhglController.class);
	 
	public ModelAndView yhGl (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("initYhgl...");
		
		Database db = null;
		ArrayList rsObj = null;
		ResultSet rs = null;
		try{
			db = new Database();
        	db.initialize();
        	
        	rs = db.executeQuery("select dh,mc from jx_m_js");
        	
        	rsObj = new ArrayList();
        	while(rs.next()){
        		rsObj.add(new String[]{rs.getString("dh"),rs.getString("mc")});
        	}
        	
		}catch(Exception ex){
			log.error("yhGl:"+ex.getMessage());
		}finally {
        	if(db!=null){
        		db.terminate();
                db = null;
        	}
        }
		return new ModelAndView(getYhgl_initpg(),"jsjhs",rsObj);
	}
	
	public  ModelAndView selectAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getYhgl_showpg(),"pageInfo",pageInfo); 
		}
		//System.out.println("selectYh.. ");
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        User usr = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	pageInfo.setPage_sql(Utils.getWhereString(new String[]{"zh","xm","xb","yx","dh","jsdh","sfjh"}, arg0,"select zh,xm,xb,yx,dh,zcsj,sfjh from jx_m_yh ", " where ", "like", "and"," order by zcsj desc"));
        	
        	db.execuPaginationSelect(pageInfo);
        	rs = pageInfo.getRs_obj();
        	
        	rsObj = new ArrayList();
        	
        	while(rs.next())
        	{
        		usr = new User();
        		usr.setZh(rs.getString("zh"));
        		usr.setXm(rs.getString("xm"));
        		usr.setXb(rs.getString("xb"));
        		usr.setYx(rs.getString("yx"));
        		usr.setDh(rs.getString("dh"));
        		usr.setZcsj(rs.getString("zcsj"));
        		usr.setSfjh(rs.getString("sfjh"));
        		rsObj.add(usr);
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
        return  new ModelAndView(getYhgl_showpg(),"pageInfo",pageInfo); 
	}
	public  ModelAndView InitYhCzAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getYhgl_initupdatepg(),"pageInfo",pageInfo); 
		}
		//System.out.println("InitYhCzAction.. ");
		ResultSet rs = null;
        Database db = null;
        User usr = null;
        try {
        	db = new Database();
        	db.initialize();
        	 
        	rs = db.executeQuery("select y.zh,y.mm,y.xm,y.xb,y.yx,y.dh,to_char(y.csrq,'yyyy-mm-dd') csrq,to_char(y.zcsj,'yyyy-mm-dd HH24:Mi:ss') zcsj,to_char(y.zhdl,'yyyy-mm-dd HH24:Mi:ss') zhdl,y.jsdh,y.mmbhwt,y.mmbhda,y.sfjh,y.grjj,y.bz,j.mc " +
        			"from jx_m_yh y left join jx_m_js j on y.jsdh=j.dh where y.zh='"+arg0.getParameter("yhid")+"'");
        	
        	if(rs.next())
        	{
        		usr = new User();
        		usr.setZh(rs.getString("zh"));
        		usr.setMm(rs.getString("mm"));
        		usr.setXm(rs.getString("xm"));
        		usr.setXb(rs.getString("xb"));
        		usr.setYx(rs.getString("yx"));
        		usr.setDh(rs.getString("dh"));
        		usr.setCsrq(rs.getString("csrq"));
        		usr.setZcsj(rs.getString("zcsj"));
        		usr.setZhdl(rs.getString("zhdl"));
        		usr.setJsdh(rs.getString("jsdh"));
        		usr.setJsmc(rs.getString("mc"));
        		usr.setMmbhwt(rs.getString("mmbhwt"));
        		usr.setMmbhda(rs.getString("mmbhda"));
        		usr.setSfjh(rs.getString("sfjh"));
        		usr.setGrjj(rs.getString("grjj"));
	           	usr.setBz(rs.getString("bz"));
        	}
        	pageInfo.setAttribute_value(usr);
        } catch (Exception ex) {
        	pageInfo.setException(ex);
        	log.error("InitYhCzAction:"+ex.getMessage());
        } finally {
        	if(db!=null)
        	{
        		db.terminate();
                db = null;
        	}
        }
        return  new ModelAndView(getYhgl_initupdatepg(),"pageInfo",pageInfo); 
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
	public ModelAndView deleteAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().toString().trim());
			return null;
		}
		
        Database db = null;
        int irs =0;
        try {
        	//System.out.println("deleteYhs.. "+arg0.getParameter("dellx"));
        	
        	db = new Database();
        	db.initialize();
        	db.setAutoCommit(false);
        	
        	irs = Integer.parseInt(arg0.getParameter("dellx"));
        	switch(irs){
        		case 1:irs= db.executeUpdate("delete from jx_m_yh where zh='"+arg0.getParameter("dellyid")+"'");break;
        		case 2:irs= procedellys(arg0.getParameterValues("yhgl_delids"),db);break;
        		case 3:irs= db.executeUpdate(Utils.getWhereString(new String[]{"zh","xm","xb","yx","dh","jsdh","sfjh"}, arg0,"delete from jx_m_yh ", " where ", "like", "and",""));break;
        		case 4:db.executeUpdate("truncate table jx_m_yh");irs=-10;break;
        	}
        	db.commit();
        	if(irs!=-10)
        		out.write("成功删除"+irs+"条数据！");
        	else
        		out.write("清理数据成功！");
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("deleteAction:"+ex.getMessage());
        	if(db!=null)
        		db.rollback();
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
	
	private int procedellys(String[] dellyids,Database db){
		int dels = 0;
		for(int i=0;i<dellyids.length;i++){
			db.executeUpdate("delete from jx_m_yh where zh='"+dellyids[i]+"'");
			dels = i+1;
		}
		return dels;
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
        int ups = 0;
        ArrayList myprm = null;
        try {
        	db = new Database();
        	db.initialize();
        	myprm = new ArrayList();
        	myprm.add(Date.valueOf(arg0.getParameter("csrq")));
            
        	ups = db.update(Utils.getSqlParamList('u',"jx_m_yh","jsdh={jsdh},mm={mm},xm={xm},xb={xb},yx={yx},dh={dh},mmbhwt={mmbhwt},mmbhda={mmbhda},sfjh={sfjh},bz={bz},csrq=[0]","zh={zh}",null,arg0, myprm),myprm.get(0).toString());
        	if(ups>0)
        		out.write("保存成功！");
        	else
        		out.write("不存在账号！保存失败");
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
	 
	public String getYhgl_initpg() {
		return yhgl_initpg;
	}

	public void setYhgl_initpg(String yhgl_initpg) {
		this.yhgl_initpg = yhgl_initpg;
	}

	public String getYhgl_initupdatepg() {
		return yhgl_initupdatepg;
	}

	public void setYhgl_initupdatepg(String yhgl_initupdatepg) {
		this.yhgl_initupdatepg = yhgl_initupdatepg;
	}

	public String getYhgl_showpg() {
		return yhgl_showpg;
	}

	public void setYhgl_showpg(String yhgl_showpg) {
		this.yhgl_showpg = yhgl_showpg;
	}
}
