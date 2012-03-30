<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>

<html> 
<body>
<input type="hidden"  id="currpg" value="${pageInfo.current_page }">
<input type="hidden"  id="backpg" value="${pageInfo.current_page-1 }">
<input type="hidden"  id="nextpg" value="${pageInfo.current_page+1 }">
<input type="hidden"  id="lastpg" value="${pageInfo.all_pagecount }">
<c:choose>
	<c:when test="${pageInfo.exception != null }">
		<div class="errorMessageDetails">
		  ${pageInfo.exception }
		</div>
	</c:when>
	<c:otherwise>
		页数：${pageInfo.current_page }/${pageInfo.all_pagecount },记录数: ${pageInfo.current_rowscount }/${pageInfo.all_rowscount }.
		<div class="blockContainer">
			<display:table uid="js" name="pageInfo.attribute_param" scope="request" class="genericTbl" cellspacing="0" requestURI="">
				<display:column sortable="false" property="mc" title="角色名称" />
				<display:column sortable="false" title="操作" >
					修改<input id="updated" type="radio" />&nbsp;&nbsp;&nbsp;&nbsp;
					删除<input id="${js.dh }" value="${js.dh }" type="checkbox"  onclick="return deleted('${js.dh }',this.checked)"  />
				</display:column>
			</display:table>
		</div>
	</c:otherwise>
</c:choose>
</body>
</html>