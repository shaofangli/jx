<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 

<html>
<head>
	<script type="text/javascript">
		setCkVl = function(bol,obj){
			if(bol)
				obj.value = 1;
			else
				obj.value = 0;
		}
		updatejscz = function(){
			if(trim($('gx_jsmc').value) == '')
			{
				myAlert('提示信息','角色名称不能更新为空!',true,'updatejscz_form');
				return false;
			}
			myAlert('提示信息','正在保存,请稍候...',false,'updatejscz_form');
			new Ajax.Request('<c:url value="/manage/jsgl_ajax.htm"/>',
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=updateAction&parm='+Form.serialize('updatejscz_form').replaceAll('&',';')+'&gx_jsmc='+trim($('gx_jsmc').value)+'&'+Form.serialize('updatejscz_mk_form'),
	                	onSuccess: function(transport) {
	                		setMyAlertMsg(transport.responseText,true);
					}
					    
	        });
		}
		resetscz=function(form1,form2,form3){
			if(form1 != null)
				form1.reset();
			if(form2 != null)
				form2.reset();
			if(form3 != null)
				form3.reset();
		}
	</script>
</head>
<body>
<c:choose>
	<c:when test="${pageInfo.exception != null }">
		<div class="errorMessageDetails">
		  ${pageInfo.exception }
		</div>
	</c:when>
	<c:otherwise>
		<div class="up_Container"><br/>
		<em class="ok">角色名称:</em><input id="gx_jsmc" name="gx_jsmc" class="ipttext" value="${pageInfo.attribute_value[1]}" /><p>
		<form id="updatejscz_form">
			 <table>
			 <c:forEach var="jsczs" items="${pageInfo.attribute_param }" varStatus="sxtmp">
			 	<input type="hidden"  name="jsdh" value="${jsczs.jsdh}" /><input type="hidden"  name="czdh" value="${jsczs.czdh}" />
			 	<c:if test="${sxtmp.index ==0}"><em class="tmplable">拥有的权限:</em></c:if>
	 			<c:if test="${sxtmp.index % 6 ==0}"><tr></c:if>
	 			<td>
		 		<c:choose>
			 		<c:when test="${jsczs.qx eq 1 }">
			 			<input type="checkbox" onclick="setCkVl(this.checked,this);" checked="checked" id="qx" name="qx" value="1" />
			 		</c:when>
			 		<c:otherwise>
			 			<input type="checkbox" onclick="setCkVl(this.checked,this);" id="qx" name="qx" value="0"/>
			 		</c:otherwise>
		 		</c:choose>
		 		<em class="zc">${jsczs.nm}</em>
		 		</td>
		 		<c:if test="${sxtmp.index+1 % 6 ==0}"></tr></c:if>
			 </c:forEach>
			 </table>
		</form>
		<form id="updatejscz_mk_form">
			 <em class="tmplable">拥有的模块:</em><p>
			 <c:choose><c:when test="${fn:indexOf(pageInfo.attribute_value[0],'$1$') != -1}"><input type="checkbox" checked="checked" value="1" name="mks"/></c:when><c:otherwise><input type="checkbox" value="1" name="mks"/></c:otherwise></c:choose><em class="zc">网站管理</em>
			 <c:choose><c:when test="${fn:indexOf(pageInfo.attribute_value[0],'$2$') != -1}"><input type="checkbox" checked="checked" value="2" name="mks"/></c:when><c:otherwise><input type="checkbox" value="2" name="mks"/></c:otherwise></c:choose><em class="zc">个人信息</em>
			 <c:choose><c:when test="${fn:indexOf(pageInfo.attribute_value[0],'$3$') != -1}"><input type="checkbox" checked="checked" value="3" name="mks"/></c:when><c:otherwise><input type="checkbox" value="3" name="mks"/></c:otherwise></c:choose><em class="zc">车辆信息</em>
			 <c:choose><c:when test="${fn:indexOf(pageInfo.attribute_value[0],'$4$') != -1}"><input type="checkbox" checked="checked" value="4" name="mks"/></c:when><c:otherwise><input type="checkbox" value="4" name="mks"/></c:otherwise></c:choose><em class="zc">VIP广告</em>
			 <c:choose><c:when test="${fn:indexOf(pageInfo.attribute_value[0],'$5$') != -1}"><input type="checkbox" checked="checked" value="5" name="mks"/></c:when><c:otherwise><input type="checkbox" value="5" name="mks"/></c:otherwise></c:choose><em class="zc">info1</em>
			 <c:choose><c:when test="${fn:indexOf(pageInfo.attribute_value[0],'$6$') != -1}"><input type="checkbox" checked="checked" value="6" name="mks"/></c:when><c:otherwise><input type="checkbox" value="6" name="mks"/></c:otherwise></c:choose><em class="zc">info2</em>
		</form>
		<input type="button"  class="updbut" onclick="updatejscz()"/>
		<input type="reset" value="" class="restbut" onclick="resetscz(updatejscz_form,updatejscz_mk_form)"/>
		<br/></div>
		 
	</c:otherwise>
</c:choose>

</body>
</html>