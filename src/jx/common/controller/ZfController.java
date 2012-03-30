package jx.common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;

public class ZfController extends JxBasicMultiController{
		
	public ModelAndView view (HttpServletRequest arg0, HttpServletResponse arg1) throws Exception {
		//System.out.println("zf...");
		return new ModelAndView(getViewName());
	}
}
