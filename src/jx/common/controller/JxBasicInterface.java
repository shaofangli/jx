package jx.common.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jx.common.models.PageInfo;

import org.springframework.web.servlet.ModelAndView;

public interface JxBasicInterface {
	//对下列方法进行拦截;
	public  ModelAndView selectAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception;
	public  ModelAndView deleteAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception;
	public  ModelAndView insertAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception;
	public  ModelAndView updateAction (HttpServletRequest arg0, HttpServletResponse arg1,PageInfo pageInfo) throws Exception;
}
