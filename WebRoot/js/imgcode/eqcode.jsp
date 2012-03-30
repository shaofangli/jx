<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String incode = (String) request.getParameter("code");
	String rightcode = (String) session.getAttribute("numrand");
		if (incode != null && rightcode != null)
		{
			if (rightcode.equals(incode)) {
				out.write("验证码输入正确!");
			} else {
				out.write("验证码不匹配,请重新输入!");
			}
		}else {
			out.write("验证码不匹配,请重新输入!");
		}
%>

