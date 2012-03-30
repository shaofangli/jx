<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>

<html>
<head>
	<script type="text/javascript">
		alertMsg=function(msg){
			Element.update('update_datadiv','');
			myAlert('提示信息',msg,true,'select_div_form');
		}
	</script>
</head>
<body>
<c:if test="${pageInfo.exception != null }">
		<script>alertMsg('${pageInfo.exception }')</script>
</c:if>

<c:if test="${pageInfo.attribute_param != null }">
	<input type="hidden"  id="currpg" value="${pageInfo.current_page }">
	<input type="hidden"  id="backpg" value="${pageInfo.current_page-1 }">
	<input type="hidden"  id="nextpg" value="${pageInfo.current_page+1 }">
	<input type="hidden"  id="lastpg" value="${pageInfo.all_pagecount }">
		页数：${pageInfo.current_page }/${pageInfo.all_pagecount },记录数: ${pageInfo.current_rowscount }/${pageInfo.all_rowscount }.
		<div class="blockContainer">
		<form id="yhgl_yhs_form" name="yhgl_yhs_form">
			<display:table uid="yhs" name="pageInfo.attribute_param" scope="request" class="genericTbl" cellspacing="0" requestURI="">
				<display:column sortable="false" title="账号" class="leftmost">
					<input id="updatedx_${yhs.zh }" name="updatedx" type="radio" value="${yhs.zh }" onclick="return seleted('${yhs.zh }')"/>
					<em class="tx" style="cursor: hand;" onclick="return seleted('${yhs.zh }')">${yhs.zh }</em>
				</display:column>
				<display:column sortable="false" title="姓名" property="xm"/>
				<display:column sortable="false" title="性别" >
					<c:if test="${yhs.xb ==1}">男</c:if><c:if test="${yhs.xb ==2}">女</c:if>
				</display:column>
				<display:column sortable="false" title="邮箱" property="yx"/>
				<display:column sortable="false" title="电话" property="dh"/>
				<display:column sortable="false" title="是否激活">
					<c:if test="${yhs.sfjh ==0}">未激活</c:if><c:if test="${yhs.sfjh ==1}">已激活</c:if><c:if test="${yhs.sfjh ==2}">已禁用</c:if>
				</display:column>
				<display:column sortable="false" title="注册时间" property="zcsj"/>
				<display:column sortable="false" title="操作" >
					<a href="#" onclick="return deleteyh('${yhs.zh }',1,'删除账号[${yhs.zh }]的信息.')"/>删除</a>
					<input id="${yhs.zh }" value="${yhs.zh }" name="yhgl_delids" type="checkbox"/>
				</display:column>
			</display:table>
		</form>
		</div>
</c:if>
</body>
</html>