<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<html>
	<body>
		<div id="top_xwzx" class="top_xwzx">
		<c:if test="${xws != null}">
		<ul> 
			<c:forEach var="xw_tmp" items="${xws}">
				<li><c:if test="${xw_tmp.zz eq 'new'}"><a href="" class="top_xwzx_new zc" onclick="return tSub('${xw_tmp.lxmc }','湖南交通驾校首页>>新闻中心>>${xw_tmp.lxmc }','','${xw_tmp.dh }','','','xwzx')">${xw_tmp.bt }</a></c:if>
				<c:if test="${xw_tmp.zz eq 'old'}"><a href="" class="top_xwzx_old zc" onclick="return tSub('${xw_tmp.lxmc }','湖南交通驾校首页>>新闻中心>>${xw_tmp.lxmc }','','${xw_tmp.dh }','','','xwzx')">${xw_tmp.bt }</a></c:if>
				</li>
			</c:forEach>
		</ul>
		</c:if>
		</div>
	</body>
</html>