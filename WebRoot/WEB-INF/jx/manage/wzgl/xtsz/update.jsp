<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 

<html>
<head>
	<script type="text/javascript">
		alertMsg=function(msg){
			myAlert('提示信息',msg,true,null);
		}
		updatextsz = function(){
			myAlert('提示信息','正在保存,请稍候...',false,'updatextsz_form');
			new Ajax.Request('<c:url value="/manage/xtsz_ajax.htm"/>',
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=updateAction&'+Form.serialize('updatextsz_form'),
	                	onSuccess: function(transport) {
	                		setMyAlertMsg(transport.responseText,true);
						}
	        });
		}
		rswzgbinit = function(v1,v2,v3)
		{
		  $(v1).selected="selected";
		  gbcgfcs(updatextsz_form.wz_close,'gbyy_wz_tr');
		  
		  $(v2).selected="selected";
		  gbcgfcs(updatextsz_form.lyb_close,'gbyy_lyb_tr');
		  
		  $(v3).selected="selected";
		  gbcgfcs(updatextsz_form.zxbm_close,'gbyy_zxbm_tr');
		}
		gbcgfcs = function(sobj,sdivid)
		{
			if(sobj.value=='0')
				Element.hide(sdivid);
			else
				Element.show(sdivid);
		}
	</script>
</head>
<body>
<c:choose>
	<c:when test="${pageInfo.exception != null }">
		<script>alertMsg('${pageInfo.exception }');</script>
	</c:when>
	<c:otherwise>
		<c:if test="${xtszcfg != null}">
			<div class="up_Container" align="center"><br/>
				<form id="updatextsz_form" name="updatextsz_form">
				<table border="0">
					<tr><td align="right"><em class="ok">系统邮箱发件人</em></td><td align="left"><input class="ipttext" name="sendName" value="${xtszcfg.sendName}"/><em class="tx">(用户注册成功后收到的邮件显示的发件人信息)</em></td></tr>
					<tr><td align="right"><em class="ok">系统邮件标题</em></td><td align="left"><input class="ipttext" name="subject" value="${xtszcfg.subject}"/><em class="tx">(用户注册成功后收到的邮件显示的邮件标题信息)</em></td></tr>
					<tr><td align="right"><em class="ok">系统邮箱地址</em></td><td align="left"><input class="ipttext" name="emailAddres" value="${xtszcfg.emailAddres}"/><em class="err">(一般不需更改)</em></td></tr>
					<tr><td align="right"><em class="ok">系统邮箱账号</em></td><td align="left"><input class="ipttext" name="userName" value="${xtszcfg.userName}"/><em class="err">(一般不需更改)</em></td></tr>
					<tr><td align="right"><em class="ok">系统邮箱密码</em></td><td align="left"><input class="ipttext" name="userPassword" value="${xtszcfg.userPassword}"/><em class="err">(一般不需更改)</em></td></tr>
					<tr><td align="right"><em class="ok">系统邮箱stmp</em></td><td align="left"><input class="ipttext" name="stmpHost" value="${xtszcfg.stmpHost}"/><em class="err">(一般不需更改)</em></td></tr>
					<tr><td align="right"><em class="ok">分页每页显示</em></td><td align="left"><input class="ipttext" name="per_pageSize" value="${xtszcfg.per_pageSize}"/><em class="tx">(默认25)</em></td></tr>
					<tr><td align="right"><em class="ok">子页最大置顶数</em></td><td align="left"><input class="ipttext" name="wz_topnum" value="${xtszcfg.wz_topnum}"/></td></tr>
					<tr><td align="right">&nbsp;</td><td align="left">&nbsp;</td></tr>
					<tr><td align="right"><em class="ok">用户注册默认角色</em></td><td align="left"><select id="wz_mrzcjs" name="wz_mrzcjs"><c:if test="${jsjhs != null}"><c:forEach var="jss" items="${jsjhs}"> <c:choose><c:when test="${jss[0] eq xtszcfg.wz_mrzcjs}"><option value="${jss[0]}" selected="selected">${jss[1]}</option></c:when><c:otherwise><option value="${jss[0]}">${jss[1]}</option></c:otherwise></c:choose></c:forEach></c:if></select><em class="tx">(请尽量选择权限最少的角色)</em></td></tr>
					<tr><td align="right"><em class="ok">网站地址</em></td><td align="left"><input class="ipttext" name="wz_dz" value="${xtszcfg.wz_dz}"/></td></tr>
					<tr><td align="right"><em class="ok">网站标题</em></td><td align="left"><input class="ipttext" name="wz_title" value="${xtszcfg.wz_title}"/></td></tr>
					<tr><td align="right"><em class="ok">网站关键字</em></td><td align="left"><input class="ipttext" name="wz_keywords" value="${xtszcfg.wz_keywords}"/></td></tr>
					<tr><td align="right"><em class="ok">网站描述</em></td><td align="left"><input class="ipttext" name="wz_description" value="${xtszcfg.wz_description}"/></td></tr>
					<tr><td align="right"><em class="ok">是否关闭网站</em></td><td align="left"><select name="wz_close" onchange="gbcgfcs(this,'gbyy_wz_tr')"><option value="0" id="wz_cls_0">否</option><option value="1" id="wz_cls_1">是</option></select></td></tr>
					<tr id="gbyy_wz_tr" style="display: none;"><td align="right"><em class="err">网站关闭原因</em></td><td align="left"><input class="ipttext" name="wz_closeyy" value="${xtszcfg.wz_closeyy}"/></td></tr>
					
					<tr><td align="right"><em class="ok">是否关闭留言板</em></td><td align="left"><select name="lyb_close" onchange="gbcgfcs(this,'gbyy_lyb_tr')"><option value="0" id="lyb_cls_0">否</option><option value="1" id="lyb_cls_1">是</option></select></td></tr>
					<tr id="gbyy_lyb_tr" style="display: none;"><td align="right"><em class="err">留言板关闭原因</em></td><td align="left"><input class="ipttext" name="lyb_closeyy" value="${xtszcfg.lyb_closeyy}"/></td></tr>
					
					<tr><td align="right"><em class="ok">是否关闭在线报名</em></td><td align="left"><select name="zxbm_close" onchange="gbcgfcs(this,'gbyy_zxbm_tr')"><option value="0" id="zxbm_cls_0">否</option><option value="1" id="zxbm_cls_1">是</option></select></td></tr>
					<tr id="gbyy_zxbm_tr" style="display: none;"><td align="right"><em class="err">在线报名关闭原因</em></td><td align="left"><input class="ipttext" name="zxbm_closeyy" value="${xtszcfg.zxbm_closeyy}"/></td></tr>
					
					<tr><td align="right" valign="top"><em class="ok">网站底部备案信息</em></td><td align="left"><textarea class="m_txtarea" name="wz_dbxx" rows="7" cols="50">${xtszcfg.wz_dbxx}</textarea></td></tr>
				</table>
				<input type="button" class="updbut" onclick="updatextsz()"/>
				<input type="reset" value="" class="restbut"/>
				</form>
				<script type="text/javascript">rswzgbinit('wz_cls_${xtszcfg.wz_close}','lyb_cls_${xtszcfg.lyb_close}','zxbm_cls_${xtszcfg.zxbm_close}');</script>
			</div>
		</c:if>
	</c:otherwise>
</c:choose>

</body>
</html>