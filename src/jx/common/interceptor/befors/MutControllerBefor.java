package jx.common.interceptor.befors;

import java.lang.reflect.Method;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import jx.common.db.Database;
import jx.common.models.PageInfo;
import jx.web.bean.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.aop.MethodBeforeAdvice;

public class MutControllerBefor implements MethodBeforeAdvice{
	
	private static final Log log = LogFactory.getLog(MutControllerBefor.class);
	
	public void before(Method arg0, Object[] arg1, Object arg2) throws Throwable {
		log.debug("qx...");
		HttpServletRequest request = (HttpServletRequest)arg1[0];
		//HttpServletResponse response = (HttpServletResponse)arg1[1];
		PageInfo pageInfo = (PageInfo)arg1[2];
		
		ResultSet rs = null;
        Database db = null;
        String methodNm = null;
        String URI = null;
        String jsdh = null;
        int qx = 0;
        try {
        	jsdh = ((User)request.getSession(false).getAttribute("usr")).getJsdh();
        	methodNm = request.getParameter("method");
        	URI = request.getRequestURI().substring(3);
        	
        	db = new Database();
        	db.initialize();
        	
        	//pageInfo.setCurrent_page(request.getParameter("currentpage"));
        	pageInfo.setPage_sql ("select c.dh,(case when q.qx is null then '0' else q.qx end) qx ,c.nm from "+
        	"(select qx,czdh from jx_m_qx where jsdh="+jsdh+")q,jx_m_cz c where q.czdh(+) = c.dh "+
        	" and c.uri = '"+URI+"' and c.mtd = '"+methodNm+"'");
        	
        	//System.out.println(pageInfo.getPage_sql());
        	
        	db.execuPaginationSelect(pageInfo);
        	rs = pageInfo.getRs_obj();
        	
        	if(rs.next())
        	{
        		qx=rs.getInt("qx");
        		methodNm = rs.getString("nm");
        	}
        	if(qx != 1){
        		log.debug("do_qx...");
            	pageInfo.setExceptionMessage("对不起,你没有【"+methodNm+"】的权限！!");
            }
        } catch (Exception ex) {
        	pageInfo.setExceptionMessage("你还未登录,请重新登录!");
        	log.error("before:"+ex.getMessage());
        } finally {
        	if(db != null)
        		db.terminate();
            db = null;
        } 
        
	}

}
