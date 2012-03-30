<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.PrintStream" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>

<html>
<body>
cwl
<c:choose>
    <c:when test="${requestScope['javax.servlet.error.exception'] != null}">
       
        <div class="errorMessageDetails">
            <%
            	Throwable error = (Throwable) request.getAttribute("javax.servlet.error.exception");
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                PrintStream ps = new PrintStream(bos);
                //error.printStackTrace(ps);
                Throwable e = error;

                int maxCauses = 10;

                while (maxCauses-- > 0) {
                    if (e instanceof ServletException) {
                        e = ((ServletException) e).getRootCause();
                    } else {
                        e = e.getCause();
                    }

                    if (e != null) {
                        ps.print("<br/><br/>Caused by:</br></br>");
                        //e.printStackTrace(ps);
                    } else {
                        break;
                    }
                }

                out.print("<script>myAlert('提示信息','<em class=err>异常:"+error.getMessage()+"</em>',true,null);</script>");
                //out.print(bos.toString());
            %>
        </div>
    </c:when>
    <c:otherwise>
        <%out.print("<script>myAlert('提示信息','发生未知错误!',true,null);</script>"); %>
    </c:otherwise>
</c:choose>
</body>
</html>