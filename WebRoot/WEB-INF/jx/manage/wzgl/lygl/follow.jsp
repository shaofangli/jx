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
		showjjhide = function(s_div,imgobj){
			$(s_div).style.display =='none'?Element.show(s_div):Element.hide(s_div);
			$(s_div).style.display =='none'?imgobj.src='images/Plus.gif':imgobj.src='images/Minus.gif';
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
		<c:if test="${pageInfo.current_rowscount >0}">
		<div class="blockContainer">
		<form id="lygl_lys_form" name="lygl_lys_form">
			<table class="genericTbl" cellspacing="0" id="lytb" >
				<tr><th>类型</th><th>留言人</th><th>留言日期</th><th>留言内容</th><th>操作</th></tr>
				<tbody>
				<c:forEach var="tly" items="${pageInfo.attribute_param}" varStatus="lyxh">
					<c:choose>
						<c:when test="${lyxh.index % 2 ==0}">
							<tr>
						</c:when>
						<c:otherwise>
							<tr  class="even">
						</c:otherwise>
					</c:choose>
					  		<td class="leftmost" style="width: 40px;">
					  		  <c:if test="${tly.lx ==0}">
					  		  	<c:if test="${tly.hfs_size > 0}"><img src="images/Plus.gif" onclick="showjjhide('hfs_tr_${tly.dh }',this)" style="cursor: hand"/>留言</c:if>
						  		<c:if test="${tly.hfs_size == 0}"><img src="images/Minus.gif" />留言</c:if>
						  	  </c:if>
						  	  <c:if test="${tly.lx ==1}"><img src="images/Minus.gif"/>回复</c:if>
					  		</td>
					  		<td style="width: 65px;">${tly.xm }</td>
					  		<td style="width: 60px;">${tly.lyrq }</td>
					  		<td style="width: 380px;height: 20px;">${tly.lynr }<img align="middle" src="${tly.bq }"/></td>
					  		<td style="width: 80px;"><c:if test="${tly.lx ==0}"><a href="#" onclick="return seleted('${tly.dh }')"/>回复</a>&nbsp;&nbsp;</c:if><a href="#" onclick="return deletely('${tly.dh }',1,'删除用户[${tly.xm }]于${tly.lyrq }的发言信息.')"/>删除</a><input id="${tly.dh }" name="lygl_delids" value="${tly.dh }" type="checkbox" /></td>
					  </tr>
					  <%-- 回复 --%>
					  <c:if test="${tly.hfs_size > 0}">
					  <tr style="display: none;" id="hfs_tr_${tly.dh }"><td colspan="5" class="leftmost">
					  		<table class="statsTable" cellspacing="0" id="hftb" >
					  			<tr><th class="leftMost">回复人</th><th>回复日期</th><th>回复内容</th><th>操作</th></tr>
								<tbody>
									<c:forEach var="thf" items="${tly.hfs}">
									<tr>
										<td class="leftmost">${thf.xm }</td>
										<td>${thf.lyrq }</td>
										<td style="width: 380px;height: 20px;">${thf.lynr }<img align="middle" src="${thf.bq }"/></td>
										<td>删除<input id="${thf.dh }" value="${thf.dh }" type="checkbox"  onclick="return deletely('${thf.dh }',1,'删除用户[${thf.xm }]于${thf.lyrq }的发言信息.')"  /></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
					  </td></tr>
					  </c:if>
				</c:forEach>
				</tbody>
			</table>
		</form>
		</div>
		</c:if>
</c:if>
</body>
</html>