package jx.common.controller;

import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jx.common.db.Database;
import jx.common.models.PageInfo;
import jx.web.bean.User;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContextException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;

/**
 * 
 * @author lsf
 * 
 * 重写spring的handleRequestInternal处理/配合方法拦截可以直接拦截URL;
 */
public abstract class JxQxMultiController extends JxBasicMultiController implements JxBasicInterface{
	
	private Object deleget;
	private Map handlerMethodMap;
    private Map lastModifiedMethodMap;
    private Map exceptionHandlerMap;
	
    private static final Log log = LogFactory.getLog(JxQxMultiController.class);
    
	public JxQxMultiController(){
		this.setDeleget(this);
	}
	public JxQxMultiController(Object deleget){
		this.setDeleget(deleget);
	}
	
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) 
	throws Exception {
		JxBasicInterface jx = null;
		String methodNm = null;
		
		Object obj = null;
		try {
			  if(null == request.getParameter("method") || 0 == request.getParameter("method").trim().length())
				{
					methodNm = "view";//默认view界面;
				}else{
					methodNm = request.getParameter("method");
				}
			  
			  if("selectAction".equals(methodNm) || "updateAction".equals(methodNm) ||
				 "deleteAction".equals(methodNm) || "insertAction".equals(methodNm))
			  {
				  PageInfo pginfo = new PageInfo();
				  before(request,pginfo);
				  //System.out.println("URI:"+request.getRequestURI());
				  obj = super.getApplicationContext().getBean(request.getRequestURI().substring(3));
				  
				  jx = (JxBasicInterface)obj; 
				  
				  if("selectAction".equals(methodNm)){
					  return jx.selectAction(request,response,pginfo);
				  }
				  if("updateAction".equals(methodNm)){
					  return jx.updateAction(request,response,pginfo);
				  }
				  if("deleteAction".equals(methodNm)){
					  return jx.deleteAction(request,response,pginfo); 
				  }
				  if("insertAction".equals(methodNm)){
					  return jx.insertAction(request,response,pginfo);
				  }
			  }else{
				  return processOthers(request, response);
			  }
		}
		catch (Exception ex) {
			request.setAttribute("javax.servlet.error.exception", ex.fillInStackTrace());
			log.error("handleRequestInternal:"+ex.getMessage());
		}
		return null;
	}
	public void before(HttpServletRequest request,PageInfo pageInfo){
		log.debug("qx...");
		//HttpServletResponse response = (HttpServletResponse)arg1[1];
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
//	private ModelAndView processOthers(HttpServletRequest arg0, HttpServletResponse arg1,String methodNm,
//	JxBasicInterface jx) throws Exception {
//		Class clas = Class.forName(jx.toString().substring(0,jx.toString().lastIndexOf("@")));
//		Method method = clas.getMethod(methodNm, new Class[]{HttpServletRequest.class,HttpServletResponse.class});
//		
////		Object obj = clas.newInstance();
////		
////		Method[] methods = clas.getMethods();
////		for(int i=0;i<methods.length;i++){
////			if(methods[i].getName().startsWith("set")){
////				methods[i].invoke(obj, new Object[]{});
////			}
////		}
//		return (ModelAndView)method.invoke(clas.newInstance(), new Object[]{arg0,arg1});
//	}
	
	protected ModelAndView processOthers(HttpServletRequest request, HttpServletResponse response)
    throws Exception
	  {
	    try
	    {
	      String methodName = super.getMethodNameResolver().getHandlerMethodName(request);
	      return invokeNamedMethod(methodName, request, response);
	    }
	    catch (NoSuchRequestHandlingMethodException ex) {
	      //pageNotFoundLogger.warn(ex.getMessage());
	      log.error("processOthers:"+ex.getMessage());
	      response.sendError(404); 
	    }
	    return null;
	  }
	
	private final void setDeleget(Object deleget){

	    if (deleget == null) {
	      throw new IllegalArgumentException("delegate cannot be <code>null</code> in MultiActionController");
	    }
	    this.deleget = deleget;
	    this.handlerMethodMap = new HashMap();
	    this.lastModifiedMethodMap = new HashMap();

	    Method[] methods = deleget.getClass().getMethods();
	    Class[] params;
	    for (int i = 0; i < methods.length; ++i)
	    {
	      if (!(methods[i].getReturnType().equals(ModelAndView.class)))
	        continue;
	      params = methods[i].getParameterTypes();

	      if ((params.length < 2) || (!(params[0].equals(HttpServletRequest.class))) || (!(params[1].equals(
	    		  HttpServletResponse.class)))) {
	        continue;
	      }
	      if (this.logger.isDebugEnabled()) {
	        this.logger.debug("Found action method [" + methods[i] + "]");
	      }
	      this.handlerMethodMap.put(methods[i].getName(), methods[i]);
	      try
	      {
	        Method lastModifiedMethod = deleget.getClass().getMethod(methods[i].getName() + "LastModified", 
	        		new Class[] { HttpServletRequest.class });

	        this.lastModifiedMethodMap.put(methods[i].getName(), lastModifiedMethod);
	        if (this.logger.isDebugEnabled()) {
	          this.logger.debug("Found last modified method for action method [" + methods[i] + "]");
	        }

	      }
	      catch (NoSuchMethodException ex)
	      {
	      }

	    }

	    if (this.handlerMethodMap.isEmpty()) {
	      throw new ApplicationContextException("No handler methods in class [" + super.getClass().getName() + "]");
	    }

	    this.exceptionHandlerMap = new HashMap();
	    for (int i = 0; i < methods.length; ++i) {
	      if ((!(methods[i].getReturnType().equals(ModelAndView.class))) || 
	    		  (methods[i].getParameterTypes().length != 3))
	        continue;
	      params = methods[i].getParameterTypes();
	      if ((!(params[0].equals(HttpServletRequest.class))) || (!(params[1].equals(HttpServletResponse.class))) || 
	    		  (!(Throwable.class.isAssignableFrom(params[2]))))
	      {
	        continue;
	      }

	      this.exceptionHandlerMap.put(params[2], methods[i]);
	      if (this.logger.isDebugEnabled())
	        this.logger.debug("Found exception handler method [" + methods[i] + "]");
	    }
	}

	public ModelAndView deleteAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public ModelAndView insertAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public ModelAndView selectAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public ModelAndView updateAction(HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
