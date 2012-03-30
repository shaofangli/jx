package jx.web.controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jx.common.controller.JxQxMultiController;
import jx.common.db.Database;
import jx.common.models.PageInfo;
import jx.web.bean.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

public class MutController extends JxQxMultiController{
	
	public String indexName ;
	public String mainName ;
	
	private static final Log log = LogFactory.getLog(MutController.class);
	
//	private String getRdm()
//	{
//		return Utils.getRandomString("lsf", "jx", null, 15);
//	}
	
	public  ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception
	{
		//System.out.println("indexAction.. ");
		return new ModelAndView(getIndexName());
	}
	public  ModelAndView mainAction (HttpServletRequest arg0, HttpServletResponse arg1) throws IOException
	{
		//System.out.println("mainAction.. ");
		return new ModelAndView(getMainName());
	}
	public  ModelAndView selectAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws IOException
	{
		if(pageInfo.getException() != null){
			return new ModelAndView(getViewName(),"pageInfo",pageInfo); 
		}
		//System.out.println("selectAction.. ");
		ArrayList rsObj = null;
		ResultSet rs = null;
        Database db = null;
        try {
        	db = new Database();
        	db.initialize();
        	 
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	//pageInfo.setPage_sql(db.getSimpleSql('s', "xt_glpt_user", "ID,JH,XM,DH,GLBM,ZCSJ", Utils.getWhereString(new String[]{"id","jh","glbm"},arg0)));
        	
        	db.execuPaginationSelect(pageInfo);
        	rs = pageInfo.getRs_obj();
        	
        	while(rs.next())
        	{
        		if(rsObj == null)
        			rsObj = new ArrayList();
        		
        		User u = new User();
//        		u.setUid(rs.getString("ID"));
//        		u.setUnm(rs.getString("XM"));
//        		u.setUjh(rs.getString("JH"));
//        		u.setUdh(rs.getString("DH"));
//        		u.setUglbm(rs.getString("GLBM"));
//        		u.setUzcsj(rs.getString("ZCSJ"));
        		rsObj.add(u);
        		u = null;
        	}
        	pageInfo.setAttribute_param(rsObj);
        } catch (Exception ex) {
        	arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("selectAction:"+ex.getMessage());
        } finally {
        	if(db!=null)
        		db.terminate();
            db = null;
        }
        
		ModelAndView mv = new ModelAndView(getViewName(),"pageInfo",pageInfo); 
		return mv; 
	}

	@Override
	public ModelAndView deleteAction(HttpServletRequest arg0, HttpServletResponse arg1, PageInfo pageInfo) throws Exception {
		if(pageInfo.getException() != null){
			return new ModelAndView(getViewName(),"pageInfo",pageInfo); 
		}
		//System.out.println("deleteAction.. ");
		ArrayList rsObj = null;
        Database db = null;
        try {
        	db = new Database();
        	db.initialize();
        	 
        	pageInfo.setCurrent_page(arg0.getParameter("currentpage"));
        	String sql = "delete from xt_glpt_user where id='"+arg0.getParameter("delid")+"'";
        	System.out.println("sql.. "+sql);
        	int rs = db.executeUpdate(sql);
        	if(rs > 0){
        		System.out.println("del ok!");
        		selectAction (arg0,arg1,pageInfo);
        	}else{
        		System.out.println("del fail!");
        	}
        } catch (Exception ex) {
        	//arg0.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
        	log.error("deleteAction:"+ex.getMessage());
        } finally {
        	if(db!=null)
        		db.terminate();
            db = null;
        }
        
		ModelAndView mv = new ModelAndView(getViewName(),"pageInfo",pageInfo); 
		return mv; 
	}
	public String getIndexName() {
		return indexName;
	}

	public void setIndexName(String indexName) {
		this.indexName = indexName;
	}

	public String getMainName() {
		return mainName;
	}

	public void setMainName(String mainName) {
		this.mainName = mainName;
	} 

}
