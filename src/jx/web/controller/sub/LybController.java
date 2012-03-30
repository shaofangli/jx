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
import jx.web.bean.Lyb;
import jx.web.bean.User;

public class LybController extends JxQxMultiController{
	
	private String lyb_initpg;  
	private String lyb_showpg; 
	private String lygl_showpg;
	private String lyb_initupdatepg;
	
	private static final Log log = LogFactory.getLog(LybController.class);

	public ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("initLybm...");
		return new ModelAndView(getViewName(),"ljbt",arg0.getParameter("path"));
	}
	/**
	 * add
	 */
	public ModelAndView insertAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		return insertLys(arg0,arg1);
	}
	/**
	 * Reply
	 */
	public ModelAndView updateAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		Writer out = arg1.getWriter();
		if(pageInfo.getException() != null){
			out.write(pageInfo.getException().getMessage());
			return null; 
		}
		return insertLys(arg0,arg1);
	}
	
	public  ModelAndView showLys (HttpServletRequest arg0, HttpServletResponse arg1) throws IOException
	{ 
		//System.out.println("showLys_w.. ");
		
		PageInfo pageInfo = null;
        try {
        	pageInfo = new PageInfo();
        	
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	pageInfo.setPage_sql("select l.*,y.xm lyzxm from jx_w_lyb l inner join jx_m_yh y on l.zh = y.zh where l.lx=0 order by l.lyrq desc");
        	
        	proceShowLys(pageInfo);
        	
        	return  new ModelAndView(this.getLyb_showpg(),"pageInfo",pageInfo);
        	
        } catch (Exception ex) {
        	log.error("showLys:"+ex.getMessage());
        	return null;
        }
	}
	public  ModelAndView selectAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		
		if(pageInfo.getException() != null){
			return new ModelAndView(getLygl_showpg(),"pageInfo",pageInfo); 
		}
		
		//System.out.println("showLys_m.. ");
		
        try {
        	//pageInfo = new PageInfo();
        	
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	pageInfo.setPage_sql(
        			Utils.getWhereString(new String[]{"y.xm","lyrq","lx"}, arg0,"select l.*,y.xm lyzxm from jx_w_lyb l inner join jx_m_yh y on l.zh = y.zh ", " where ", "like", "and"," order by lyrq desc"));
        	proceShowLys(pageInfo);
        	
        	return  new ModelAndView(this.getLygl_showpg(),"pageInfo",pageInfo);
        	
        } catch (Exception ex) {
        	log.error("selectAction:"+ex.getMessage());
        	return null;
        }
	}
	
	private void proceShowLys(PageInfo pageInfo){
		if (pageInfo == null)
			return;
		
		ArrayList rsObj = null;
		ArrayList rsObjhf = null;
		ResultSet rs = null;
		ResultSet rshf = null;
        Database db = null;
        Lyb lyb = null;
        Lyb lybhf = null;
        try {
        	db = new Database();
        	db.initialize();
        	
        	db.execuPaginationSelect(pageInfo);
        	rs = pageInfo.getRs_obj();
        	
        	rsObj = new ArrayList();
        	
        	while(rs.next())
        	{
        		 lyb = new Lyb();
	           	 lyb.setBq(rs.getString("bq"));
	           	 lyb.setDh(rs.getString("dh"));
	           	 lyb.setLx(rs.getString("lx"));
	           	 lyb.setLynr(rs.getString("lynr"));
	           	 lyb.setLyrq(rs.getString("lyrq"));
	           	 lyb.setPdh(rs.getString("pdh"));
	           	 lyb.setSfkj(rs.getString("sfkj"));
	           	 lyb.setSfnm(rs.getString("sfnm"));
	           	 lyb.setXm(rs.getString("lyzxm"));
	           	 lyb.setZh(rs.getString("zh"));
	           	 
	           	 rshf =db.executeQuery("select l.bq,l.dh,l.lx,l.lynr,to_char(l.lyrq,'yyyy-mm-dd HH24:Mi:ss') lyrq,l.pdh,l.sfkj,l.sfnm,y.xm,l.zh from jx_w_lyb l inner join jx_m_yh y on l.zh = y.zh where l.lx=1 and l.pdh='"+lyb.getDh()+"' order by l.lyrq desc");
	           	 rsObjhf = new ArrayList();
	           	 while(rshf.next()){
	           		lybhf = new Lyb();
	           		lybhf.setBq(rshf.getString("bq"));
	           		lybhf.setDh(rshf.getString("dh"));
	           		lybhf.setLx(rshf.getString("lx"));
	           		lybhf.setLynr(rshf.getString("lynr"));
	           		lybhf.setLyrq(rshf.getString("lyrq"));
	           		lybhf.setPdh(rshf.getString("pdh"));
	           		lybhf.setSfkj(rshf.getString("sfkj"));
	           		lybhf.setSfnm(rshf.getString("sfnm"));
	           		lybhf.setXm(rshf.getString("xm"));
	           		lybhf.setZh(rshf.getString("zh"));
	           		rsObjhf.add(lybhf);
	           	 }
	           	 lyb.setHfs(rsObjhf);
        		 rsObj.add(lyb);
        	} 
        	pageInfo.setAttribute_param(rsObj);
        	
        } catch (Exception ex) {
        	log.error("proceShowLys:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
        }
	}
	public ModelAndView insertLys(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("insertLys.. ");
		
		Writer out = arg1.getWriter();
		ArrayList rsObj = null;
        Database db = null;
        int irs =0;
        User usr = null;
        try {
        	db = new Database();
        	db.initialize();
        	usr =  (User)arg0.getSession(false).getAttribute("usr");
        	rsObj = new ArrayList();
        	
        	rsObj.add(Utils.getRandomString(null, null, null, 32));
        	rsObj.add(Utils.removeAllHtmltg(Utils.removeAllspaces(arg0.getParameter("lyb_comments"))));
        	rsObj.add(usr.getZh());
        	rsObj.add(usr.getXm());
        	
        	irs= db.insert(Utils.getSqlParamList('i', "jx_w_lyb", 
        		"dh=[0],zh=[2],xm=[3],lynr=[1],bq={bq},lx={lx},sfnm={sfnm},sfkj={sfkj},pdh={pdh}", 
        		null, null, arg0, rsObj),rsObj.get(0).toString());
        	
        	if(irs > 0){
        		out.write("0".equals(arg0.getParameter("lx"))?"留言成功!":"回复成功!");
        	}else{
        		out.write("0".equals(arg0.getParameter("lx"))?"留言失败!请联系管理员":"回复失败!请联系管理员");
        	}
        } catch (Exception ex) {
        	out.write(FinallData.getErrMsg(ex.getMessage(),null));
        	log.error("insertLys:"+ex.getMessage());
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
			out.write(pageInfo.getException().toString().trim());
			return null;
		}
		//System.out.println("deleteLys.. "+arg0.getParameter("dellx"));
		
        Database db = null;
        int irs =0;
        try {
        	db = new Database();
        	db.initialize();
        	db.setAutoCommit(false);
        	
        	irs = Integer.parseInt(arg0.getParameter("dellx"));
        	switch(irs){
        		case 1:irs= db.executeUpdate("delete from jx_w_lyb where dh='"+arg0.getParameter("dellyid")+"'");break;
        		case 2:irs= procedellys(arg0.getParameterValues("lygl_delids"),db);break;
        		case 3:irs= db.executeUpdate(Utils.getWhereString(new String[]{"y.xm","l.lyrq","l.lx"}, arg0,"delete from jx_w_lyb where dh in(select l.dh from jx_w_lyb l inner join jx_m_yh y on l.zh = y.zh ", " where ", "like", "and",")"));break;
        		case 4:db.executeUpdate("truncate table jx_w_lyb");irs=-10;break;
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
			db.executeUpdate("delete from jx_w_lyb where dh='"+dellyids[i]+"'");
			dels = i+1;
		}
		return dels;
	}
	
	
	public String getLyb_initpg() {
		return lyb_initpg;
	}

	public void setLyb_initpg(String lyb_initpg) {
		this.lyb_initpg = lyb_initpg;
	}

	public String getLyb_initupdatepg() {
		return lyb_initupdatepg;
	}

	public void setLyb_initupdatepg(String lyb_initupdatepg) {
		this.lyb_initupdatepg = lyb_initupdatepg;
	}

	public String getLyb_showpg() {
		return lyb_showpg;
	}

	public void setLyb_showpg(String lyb_showpg) {
		this.lyb_showpg = lyb_showpg;
	}

	public String getLygl_showpg() {
		return lygl_showpg;
	}

	public void setLygl_showpg(String lygl_showpg) {
		this.lygl_showpg = lygl_showpg;
	}
}
