package jx.common.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jx.common.listeners.AppListener;
import jx.web.bean.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.i18n.LocaleContext;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.HandlerAdapter;
import org.springframework.web.servlet.HandlerExecutionChain;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

public class JxServlet extends DispatcherServlet{
	
  private static final Log log = LogFactory.getLog(JxServlet.class);
	
  protected void doDispatch(HttpServletRequest request, HttpServletResponse response)throws Exception{
	  
    HttpServletRequest processedRequest = request;
    HandlerExecutionChain mappedHandler = null;
    int interceptorIndex = -1;
    
    //System.out.println("JxServlet-->"+request.getRequestURL()+":"+request.getParameter("method"));
    LocaleContext previousLocaleContext = LocaleContextHolder.getLocaleContext();
    try
    {
      ModelAndView mv = null;
      try {
    	  if("1".equals(AppListener.getAppValue("wz_close"))){
    		   if(AppListener.getAppValue("wz_whrzh") != null && request.getSession().getAttribute("usr") !=null){
    			   if(!AppListener.getAppValue("wz_whrzh").equals((((User)request.getSession().getAttribute("usr")).getZh())))
    	    	    	throw new ModelAndViewDefiningException(new ModelAndView("/common/errors/wz_err","er_msg",AppListener.getAppValue("wz_closeyy")));
    		   }else{
    			   throw new ModelAndViewDefiningException(new ModelAndView("/common/errors/wz_err","er_msg",AppListener.getAppValue("wz_closeyy")));
    		   }
    	}
        processedRequest = super.checkMultipart(request);

        mappedHandler = getHandler(processedRequest, false);
        if ((mappedHandler == null) || (mappedHandler.getHandler() == null)) {
          noHandlerFound(processedRequest, response);

          if ((processedRequest instanceof MultipartHttpServletRequest) && (processedRequest != request)) {
             //super.multipartResolver.cleanupMultipart((MultipartHttpServletRequest)processedRequest);
          }

          LocaleContextHolder.setLocaleContext(previousLocaleContext);
          return;
        }
        if (mappedHandler.getInterceptors() != null) {
          for (int i = 0; i < mappedHandler.getInterceptors().length; ++i) {
            HandlerInterceptor interceptor = mappedHandler.getInterceptors()[i];
            if (!(interceptor.preHandle(processedRequest, response, mappedHandler.getHandler()))) {
              //triggerAfterCompletion(mappedHandler, interceptorIndex, processedRequest, response, null);

              if ((processedRequest instanceof MultipartHttpServletRequest) && (processedRequest != request)) {
                //this.multipartResolver.cleanupMultipart((MultipartHttpServletRequest)processedRequest);
              }

              LocaleContextHolder.setLocaleContext(previousLocaleContext);
              return;
            }
            interceptorIndex = i;
          }

        }
        HandlerAdapter ha = getHandlerAdapter(mappedHandler.getHandler());
//        if(ha instanceof SimpleControllerHandlerAdapter){
//        	System.out.println("1");
//        }else
//		if(ha instanceof ThrowawayControllerHandlerAdapter){
//			System.out.println("2");     	
//		 }else
//		if(ha instanceof SimpleServletHandlerAdapter){
//			System.out.println("3");
//		}else{
//			System.out.println("4");
//		}
        mv = ha.handle(processedRequest, response, mappedHandler.getHandler());
        if (mappedHandler.getInterceptors() != null)
          for (int i = mappedHandler.getInterceptors().length - 1; i >= 0; --i) {
            HandlerInterceptor interceptor = mappedHandler.getInterceptors()[i];
            interceptor.postHandle(processedRequest, response, mappedHandler.getHandler(), mv);
          }
      }
      catch (ModelAndViewDefiningException ex)
      {
    	log.error("doDispatch.ModelAndViewDefiningException:"+ex.getMessage());
        mv = ex.getModelAndView();
      }
      catch (Exception ex) {
        Object handler = (mappedHandler != null) ? mappedHandler.getHandler() : null;
        mv = processHandlerException(request, response, handler, ex);
      }

      if ((mv != null) && (!(mv.isEmpty()))) {
        render(mv, processedRequest, response);
      }
      else if (this.logger.isDebugEnabled()) {
        this.logger.debug("Null ModelAndView returned to DispatcherServlet with name '" + getServletName() + "': assuming HandlerAdapter completed request handling");
      }

      //triggerAfterCompletion(mappedHandler, interceptorIndex, processedRequest, response, null);
    }
    catch (Exception ex)
    {
    	log.error("doDispatch.Exception:"+ex.getMessage());
    }
    catch (Error err)
    {
    	log.error("doDispatch.Error:"+err.getMessage());
    }
    finally
    {
//      if ((processedRequest instanceof MultipartHttpServletRequest) && (processedRequest != request)) {
//        //this.multipartResolver.cleanupMultipart((MultipartHttpServletRequest)processedRequest);
//      }
      LocaleContextHolder.setLocaleContext(previousLocaleContext);
    }
  } 
}