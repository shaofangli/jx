<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>

<html>
<head>
	<script type="text/javascript">
		alertMsg=function(msg){
			Element.update('update_datadiv','');
			myAlert('提示信息',msg,true,null);
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
			<display:table uid="zxbm" name="pageInfo.attribute_param" scope="request" class="genericTbl" cellspacing="0" requestURI="">
				<display:column sortable="false" title="证件号码" class="leftmost" >
					<em class="tx">${zxbm.zjhm }</em>
				</display:column>
				<display:column sortable="false" title="处理" style="width: 60px;"><c:if test="${zxbm.sfcl ==0}">待处理</c:if><c:if test="${zxbm.sfcl ==1}">已处理</c:if></display:column>
				<display:column sortable="false" title="姓名" style="width: 60px;" property="xm"/>
				<display:column sortable="false" title="性别" ><c:if test="${zxbm.xb ==1}">男</c:if><c:if test="${zxbm.xb ==2}">女</c:if></display:column>
				<display:column sortable="false" title="手机号码" property="sjhm"/>
				<display:column sortable="false" title="备注" property="bz" style="width: 380px;"/>
				<display:column sortable="false" title="操作"  >删除<input id="${zxbm.zjhm }" value="${zxbm.zjhm }" type="checkbox"  onclick="return deleted('${zxbm.zjhm }',this.checked)"  /><select onchange="return ggclzt(this.value,'${zxbm.zjhm }','${zxbm.sfcl}')"><option>状态</option><option value="0">待处理</option><option value="1">已处理</option></select></display:column>
			</display:table>
		</div>
</c:if>
</body>
</html>