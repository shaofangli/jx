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
			<display:table uid="wz" name="pageInfo.attribute_param" scope="request" class="genericTbl" cellspacing="0" requestURI="">
				<display:column sortable="false" title="文章标题" class="leftmost">
					<input id="updatedx_${wz.dh }" name="updatedx" type="radio" value="${wz.bt }" onclick="return seleted('${wz.dh }')"/>
					<em class="tx" style="cursor: hand;" onclick="return seleted('${wz.dh }')">${wz.bt }</em>
				</display:column>
				
				<display:column sortable="false" title="作者" property="zz"/>
				<display:column sortable="false" title="所属模块" property="lxmc"/>
				<display:column sortable="false" title="发表时间" property="fbrq"/>
				<display:column sortable="false" title="更新时间" property="gxrq"/>
				
				<display:column sortable="false" title="操作" >
					删除<input id="${wz.dh }" value="${wz.dh }" type="checkbox"  onclick="return deleted('${wz.dh }','${wz.lxdh }',this.checked)"  />
					<c:choose>
						<c:when test="${wz.sfzd ==1 }">
							<em class="tx" style="cursor: hand;" onclick="return setwzzd('${wz.dh }','${wz.lxdh }','setTopwz','置顶')">置顶</em>
						</c:when>
						<c:otherwise>
							<em class="tx" style="cursor: hand;" onclick="return setwzzd('${wz.dh }','${wz.lxdh }','cxTopwz','取消置顶')">取消置顶</em>
						</c:otherwise>
					</c:choose>
				</display:column>
			</display:table>
		</div>
</c:if>
</body>
</html>