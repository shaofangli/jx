<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
		 
		getPrs = function(x)
		{
		   return '&method='+x+'&zh='+$('zh').value+'&xm='+$('xm').value+'&xb='+$('xb').value+'&yx='+$('yx').value+'&dh='+$('dh').value+'&jsdh='+$('jsdh_sel').value+'&sfjh='+$('sfjh').value;
		}
		selects = function() {
					Element.update('update_datadiv','');
					var selpg = 1;
		 			if($('currpg'))
		 			{
		 				if(parseInt($('currpg').value) ==0)
		 					selpg = 1;
		 				else
		 					selpg = parseInt($('currpg').value);
		 			}
		 			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/yhgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+selpg+getPrs('selectAction')
	                });
	                return false;
	    }
	    resetcupg=function(){
         	if($('currpg'))
         		$('currpg').value=1;
         	selects();
         }
	    $('firstd').onclick = function() {
					if(!$('lastpg'))return false;
	    			if(parseInt($('currpg').value) == 1)
	    				return false;  
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/yhgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage=1'+getPrs('selectAction')
	                });
	                return false;
	            }
	    $('backd').onclick = function() {
	    			if(!$('lastpg'))return false;
	    			var npg = $('backpg').value;
	                if(parseInt(npg) < 1)
	                	return false;
	                Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/yhgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+npg+getPrs('selectAction')
	                });
	                return false;
	            }
	    $('nextd').onclick = function() {
	    			if(!$('lastpg'))return false;
	    			var npg = $('nextpg').value;
	                if(parseInt(npg) > parseInt($('lastpg').value))
	                	return false;
	                Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/yhgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+npg+getPrs('selectAction')
	                });
	                return false;
	            }
         $('lastd').onclick = function() {
         			if(!$('lastpg'))return false;
	         		if(parseInt($('currpg').value) == parseInt($('lastpg').value))
		    			return false;
		    		var npg = $('lastpg').value;
		    		Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
		            new Ajax.Updater('datashow_div','<c:url value="/manage/yhgl_ajax.htm"/>', 
		            {
		            	method:'post',
		            	asynchronous:true,
		            	evalScripts : true,
		            	parameters:'currentpage='+npg+getPrs('selectAction')
		            });
		            return false;
         }
         $('qx_xx').onclick = function() {
         		if(!$('yhgl_yhs_form'))return false;
         		else return checkAll(yhgl_yhs_form);
         }
         $('fx_xx').onclick = function() {
         		if(!$('yhgl_yhs_form'))return false;
         		else return inverse(yhgl_yhs_form);
         }
         $('dl_xxs_dq').onclick = function() {
         		if($('yhgl_yhs_form')){
         			if(parseInt($('lastpg').value)!=0)
         				deleteyh('',3,'删除当前查询条件下所有数据.');
         			else
         				alert('无记录!');
         		}
         		return false;
         }
         $('dl_xxs_all').onclick = function() {
         		if($('yhgl_yhs_form')){
         			if(parseInt($('lastpg').value)!=0)
         				deleteyh('',4,'清空所有用户数据.');
         			else
         				alert('无记录!');
         		}
         		return false;
         }
         ischked=function(ckobj){
         	for(i=0;i<ckobj.length;i++){
         		if(ckobj[i].checked)
         			return true;
         	}
         	return false;
         }
         $('dl_xxs').onclick = function() {
         		if($('yhgl_yhs_form')){
         			if(ischked(yhgl_yhs_form.yhgl_delids))
         				deleteyh('',2,'删除所选择的数据.');
         			else
         				alert('没有选择!');
         		}
         		return false;
         }
         
         deleteyh = function(dellyid,dellx,delmsg) {
         	
         	var delstr = 'method=deleteAction&dellx='+dellx;
         	
         	if(dellx==1)
         		 delstr=delstr+'&dellyid='+dellyid;
         	if(dellx==2)
         		 delstr=delstr+'&'+Form.serialize('yhgl_yhs_form');
         	if(dellx==3)
         		 delstr='dellx=3'+getPrs('deleteAction');
         		 
	     	if(confirm(delmsg+'确定删除吗?!')){
	                myAlert('提示信息','正在删除信息,请稍候...',false,'select_div_form');
					new Ajax.Request('<c:url value="/manage/yhgl_ajax.htm"/>', 
			         {
			                	method:'post',
			                	asynchronous:true,
			                	evalScripts : true,
			                	parameters:delstr,
			                	onSuccess: function(transport) {
			                		setMyAlertMsg(transport.responseText,true);
			                		if(trim(transport.responseText).indexOf('成功')!= -1){
			                			selects();
			                		}
							    },
							    onFailure:function(){
							    	setMyAlertMsg('删除数据失败,请联系管理员!',true);
							    }
			        });
			 }
			 return false;
	     }
         seleted = function(sid){
         			$('updatedx_'+sid).checked="checked";
         			Element.update('update_datadiv','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('update_datadiv','<c:url value="/manage/yhgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'yhid='+sid+getPrs('InitYhCzAction')
	                });
         }
	</script>
</head>
<body>
	
<%--查询条件div --%>
	<div id ="select_div" class="jrcx">
	<form id="select_div_form">
		账号:<input id="zh" type="text" maxlength="18" class="ipttext"/>
		姓名:<input id="xm" type="text" maxlength="18" class="ipttext"/>
		邮箱<input id="yx" type="text" maxlength="30" class="ipttext"/>
		电话<input id="dh" type="text" maxlength="13" class="ipttext"/><br/>
		性别:<select id="xb"><option>请选择</option><option value="1">男</option><option value="2">女</option></select>
		是否激活:<select id="sfjh"><option>请选择</option><option value="0">未激活</option><option value="1">已激活</option><option value="2">已禁用</option></select>
		所属角色:<em id="dtx_seldiv" style="font-style: normal"><select id="jsdh_sel" name="jsdh"><option>请选择</option><c:if test="${jsjhs != null}"><c:forEach var="jss" items="${jsjhs}"><option value="${jss[0]}">${jss[1]}</option></c:forEach></c:if></select></em>
		<input id="selbut" type="button" class="selbut" onclick="resetcupg();"/>
	</form>
	</div>
<div id ="ldpg">
	<%--分页按钮div --%>
	<div id ="pagination_div">
		<ul class="options">
			<li id="firstd"><a href="">首页</a></li>
			<li id="backd"><a href="">上一页</a></li>
			<li id="nextd"><a href="">下一页</a></li>
			<li id="lastd"><a href="">尾页</a></li>
			<li id="qx_xx"><a href="">全选</a></li>
			<li id="fx_xx"><a href="">反选</a></li>
			<li id="dl_xxs"><a href="">删除所选</a></li>
			<li id="dl_xxs_dq"><a href="">删除当前所有</a></li>
			<li id="dl_xxs_all"><a href="">清空所有</a></li>
		</ul>
	</div>
	<%--数据显示div --%>
	<div id="datashow_div">
	</div>
	<%--数据修改div --%>	
	<div id="update_datadiv">
  	</div>
</div>


</body>
</html>
