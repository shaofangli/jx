<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 

<html>
<head>
	<script type="text/javascript">
		updateyhcz = function(){
			myAlert('提示信息','正在保存,请稍候...',false,'updateyhcz_form');
			new Ajax.Request('<c:url value="/manage/yhglhtm"/>',
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=updateAction&'+Form.serialize('updateyhcz_form'),
	                	onSuccess: function(transport) {
	                		setMyAlertMsg(transport.responseText,true);
	                		if(trim(transport.responseText).indexOf('成功')!= -1){
			                			selects();
			                		}
					}
					    
	        });
		}
		resetsel=function(selvl,selmmbhwt){
			$('gx_mmbhwt_'+selmmbhwt).selected="selected";
			$('dt_seldiv').innerHTML=$('dtx_seldiv').innerHTML;
			//alert(updateyhcz_form.jsdh_sel.value);
			var tmp_obj = updateyhcz_form.jsdh_sel;
			if(updateyhcz_form.jsdh_sel.value != selvl)
			{
				//$('option_js_'+selvl).selected="selected";
				for(i=0;i<tmp_obj.length;i++){
					if(tmp_obj[i].value==selvl)
						tmp_obj[i].selected="selected";
				}
			}
			if(selvl != '')
				{Element.remove(tmp_obj[0]);}
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
			<div class="up_Container" align="center"><br/>
			<form id="updateyhcz_form" name="updateyhcz_form">
				<input type="hidden"  name="zh" value="${pageInfo.attribute_value.zh}" />
			<table border="0">
				<tr><td align="right"><em class="ok">账号:</em></td><td align="left"><em class="tmplable">${pageInfo.attribute_value.zh}</em></td></tr>
				<tr><td align="right"><em class="ok">所属角色:</em></td><td align="left"><em id="dt_seldiv"></em></td></tr>
				<tr><td align="right"><em class="ok">密码:</em></td><td align="left"><input type="password" id="gx_yhmm" name="mm" class="ipttext" value="${pageInfo.attribute_value.mm}" /></td></tr>
				<tr><td align="right"><em class="ok">姓名:</em></td><td align="left"><input id="gx_yhxm" name="xm" class="ipttext" value="${pageInfo.attribute_value.xm}" /></td></tr>
				<tr><td align="right"><em class="ok">性别:</em></td><td align="left"><c:if test="${pageInfo.attribute_value.xb ==1}">男<input type="radio" name="xb" value="1" checked="checked"/>女<input type="radio" name="xb" value="2"/></c:if><c:if test="${pageInfo.attribute_value.xb ==2}">男<input type="radio" name="xb" value="1" />女<input type="radio" name="xb" value="2" checked="checked"/></c:if></td></tr>
				<tr><td align="right"><em class="ok">邮箱:</em></td><td align="left"><input id="gx_yhyx" name="yx" class="ipttext" value="${pageInfo.attribute_value.yx}" /></td></tr>
				<tr><td align="right"><em class="ok">电话:</em></td><td align="left"><input id="gx_yhdh" name="dh" class="ipttext" value="${pageInfo.attribute_value.dh}" /></td></tr>
				<tr><td align="right"><em class="ok">出生日期:</em></td><td align="left"><input id="gx_yhcsrq" name="csrq" class="ipttext" value="${pageInfo.attribute_value.csrq}" onfocus="showCalendar(this);" type="text" readonly="readonly"/></td></tr>
				<tr><td align="right"><em class="ok">注册时间:</em></td><td align="left">${pageInfo.attribute_value.zcsj}</td></tr>
				<tr><td align="right"><em class="ok">最后登录时间:</em></td><td align="left">${pageInfo.attribute_value.zhdl}</td></tr>
				<tr><td align="right"><em class="ok">密码保护问题:</em></td><td align="left"><select	name="mmbhwt" class="sel">
					<option value="1" id="gx_mmbhwt_1">您母亲的姓名是?</option>
			    	<option value="2" id="gx_mmbhwt_2">您父亲的姓名是?</option>
			        <option value="3" id="gx_mmbhwt_3">您配偶的姓名是?</option>
			        <option value="4" id="gx_mmbhwt_4">您母亲的生日是?</option>
			        <option value="5" id="gx_mmbhwt_5">您父亲的生日是?</option>
			        <option value="6" id="gx_mmbhwt_6">您配偶的生日是?</option>
					</select></td></tr>
				<tr><td align="right"><em class="ok">密码保护答案:</em></td><td align="left"><input id="gx_yhmmbhda" name="mmbhda" class="ipttext" value="${pageInfo.attribute_value.mmbhda}" /></td></tr>
				<tr><td align="right"><em class="ok">是否激活:</em></td><td align="left"><select id="gx_yhsfjh" name="sfjh">
					<c:if test="${pageInfo.attribute_value.sfjh ==0}"><option value="0" selected="selected">未激活</option><option value="1">已激活</option><option value="2">已禁用</option></c:if>
					<c:if test="${pageInfo.attribute_value.sfjh ==1}"><option value="0">未激活</option><option value="1" selected="selected">已激活</option><option value="2">已禁用</option></c:if>
					<c:if test="${pageInfo.attribute_value.sfjh ==2}"><option value="0">未激活</option><option value="1" >已激活</option><option value="2" selected="selected">已禁用</option></c:if>
				</select></td></tr>
				<tr><td align="right"><em class="ok">备注:</em></td><td align="left"><input id="gx_yhbz" name="bz" class="ipttext" value="${pageInfo.attribute_value.bz}" /></td></tr>
			</table>
			<input type="button" class="updbut" onclick="updateyhcz()"/>
			<input type="reset" value="" class="restbut"/>
			</form>
			<script type="text/javascript">resetsel('${pageInfo.attribute_value.jsdh}','${pageInfo.attribute_value.mmbhwt}');</script>
			<br/></div>
	</c:otherwise>
</c:choose>

</body>
</html>