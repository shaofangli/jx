<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<html>
	<body>
			<c:choose>
				<c:when test="${jxgktpnr != null}">
					<div style="work-break:break-all;overflow:hidden;height:150px;">${jxgktpnr }</div>
					<span style="float: right;"><a href="#" onclick="return tSub('驾校概况','湖南交通驾校首页>>驾校简介>>驾校概况','','','','','jxjj')">『详情』</a></span>
				</c:when>
				<c:otherwise>没有驾校概况置顶内容!</c:otherwise>
			</c:choose>
	</body>
</html>
