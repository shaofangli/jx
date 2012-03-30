package jx.common.controller;

import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public abstract class JxBasicMultiController extends MultiActionController{

	public String viewName;

	public String getViewName() {
        return viewName;
    }

    public void setViewName(String viewName) {
        this.viewName = viewName;
    }
}
