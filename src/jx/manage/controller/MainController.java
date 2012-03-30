package jx.manage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.ModelAndView;
import jx.common.controller.JxBasicMultiController;
import jx.common.listeners.AppListener;

public class MainController extends JxBasicMultiController{
	 
	public ModelAndView toManag (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("toManag...");
		
		HttpSession session = arg0.getSession(false);
		if(session.getAttribute(session.getId()) != null && "logsuc".equals(session.getAttribute(session.getId()))){
			return new ModelAndView(getViewName(),"wz_dbxx",AppListener.getPops().getProperty("wz_dbxx").toString());
		}
		return null;
	}
}
