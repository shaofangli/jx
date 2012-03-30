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
			<display:table uid="tp" name="pageInfo.attribute_param" scope="request" class="genericTbl" cellspacing="0" requestURI="">
				<display:column sortable="false" title="图片标题" class="leftmost">
					<input id="updatedx_${tp.dh }" name="updatedx" type="radio" value="${tp.bt }" onclick="return seleted('${tp.dh }')"/>
					<em class="tx" style="cursor: hand;" onclick="return seleted('${tp.dh }')">${tp.bt }</em>
				</display:column>
				
				<display:column sortable="false" title="上传者" property="zz"/>
				<display:column sortable="false" title="次序" >第${tp.lxmc }张</display:column>
				<display:column sortable="false" title="上传时间" property="fbrq"/>
				<display:column sortable="false" title="更新时间" property="gxrq"/>
				
				<display:column sortable="false" title="操作" >
					删除<input id="${tp.dh }" value="${tp.dh }" type="checkbox"  onclick="return deleted('${tp.dh }',this.checked)"  />
				</display:column>
			</display:table>
		</div>
</c:if>
</body>
</html>