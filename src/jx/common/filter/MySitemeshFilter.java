package jx.common.filter;
import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.opensymphony.sitemesh.webapp.SiteMeshFilter;

public class MySitemeshFilter extends SiteMeshFilter{
	 
	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2) throws IOException,ServletException{
		HttpServletRequest req = ((HttpServletRequest)arg0);
		HttpServletResponse respons = ((HttpServletResponse)arg1);
		
		req.setCharacterEncoding("UTF-8");
		respons.setCharacterEncoding("UTF-8");
		
		super.doFilter(arg0, arg1, arg2);
	}
 
}
