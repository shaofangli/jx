package jx.web.interceptor.urlInterceptors;

import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class TimeBasedAccessInterceptor extends HandlerInterceptorAdapter {
	private int openingTime;

	private int closingTime;

	private String mappingURL;// 利用正则映射到需要拦截的路径

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		String url = request.getRequestURL().toString();
		if (mappingURL == null || url.matches(mappingURL)) {
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			int now = c.get(Calendar.HOUR_OF_DAY);
			if (now < openingTime || now > closingTime) {
				request.setAttribute("msg", "注册开放时间：9：00-12：00");
				request.getRequestDispatcher("/msg.jsp").forward(request,
						response);
				return false;
			}
			return true;
		}
		return true;
	}

	public int getClosingTime() {
		return closingTime;
	}

	public void setClosingTime(int closingTime) {
		this.closingTime = closingTime;
	}

	public String getMappingURL() {
		return mappingURL;
	}

	public void setMappingURL(String mappingURL) {
		this.mappingURL = mappingURL;
	}

	public int getOpeningTime() {
		return openingTime;
	}

	public void setOpeningTime(int openingTime) {
		this.openingTime = openingTime;
	}
}
