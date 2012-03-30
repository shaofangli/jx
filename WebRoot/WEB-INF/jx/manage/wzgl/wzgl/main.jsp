<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
		 
		getPrs = function(x)
		{     
		   return '&method='+x+'&'+Form.serialize('select_div_zyform');
		}
		selects = function() {
					Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
					Element.update('update_datadiv','');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/wzgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage=1'+getPrs('selectAction')
	                });
	                return false;
	    }
		$('selbut').onclick = selects;
		
	    $('firstd').onclick = function() {
	    			if(!$('lastpg'))return false;
	    			if(parseInt($('currpg').value) == 1)
	    				return false;  
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/wzgl_ajax.htm"/>', 
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
	                new Ajax.Updater('datashow_div','<c:url value="/manage/wzgl_ajax.htm"/>', 
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
	                new Ajax.Updater('datashow_div','<c:url value="/manage/wzgl_ajax.htm"/>', 
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
		            new Ajax.Updater('datashow_div','<c:url value="/manage/wzgl_ajax.htm"/>', 
		            {
		            	method:'post',
		            	asynchronous:true,
		            	evalScripts : true,
		            	parameters:'currentpage='+npg+getPrs('selectAction')
		            });
		            return false;
         }
         deleted = function(did,dlxdh,bol){
			         if(bol)
			         {
			         	if(confirm('确定删除吗?!')){
			         		Element.update('update_datadiv','');
		    				var npg = $('currpg').value;
			                new Ajax.Updater('datashow_div','<c:url value="/manage/wzgl_ajax.htm"/>', 
			                {
			                	method:'post',
			                	asynchronous:true,
			                	evalScripts : true,
			                	parameters:'dlxdh='+dlxdh+'&delid='+did+'&currentpage='+npg+getPrs('deleteAction')
			                }); 
	    				}
			         }
	                return false;
         }
         seleted = function(sid){
         			if(sid == '-1' && select_div_zyform.dh.value==' ')
         			{myAlert('提示信息','请选择所属模块!',true,'select_div_zyform');return false;}
         			if(sid != '-1')
         				$('updatedx_'+sid).checked="checked";
         			Element.update('update_datadiv','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('update_datadiv','<c:url value="/manage/wzgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'wzid='+sid+getPrs('InitWzCzAction')
	                });
         }
         setwzzd = function (zdid,czdh,zdmtd,tmsg){
	         	if(confirm('确定'+tmsg+'吗?!')){
	         		myAlert('提示信息',tmsg+'中,请稍候...',false,null);
	         	    new Ajax.Request('<c:url value="/manage/wzgl_ajax.htm"/>', 
		                {
		                	method:'post',
		                	asynchronous:true,
		                	evalScripts : true,
		                	parameters:'method='+zdmtd+'&zdid='+zdid+'&czdh='+czdh+getPrs('setTopwz'),
		                	onSuccess: function(transport) {
				                		setMyAlertMsg(transport.responseText,true);
				                		if(trim(transport.responseText).indexOf('成功')!= -1){
				                			selects();
				                		}
								    }
		                });
	         	}
	           return false;
         }
         hqdtzcd = function(dtid){
         	$('dt_zjcd').innerHTML = $('dtzcd_'+dtid).innerHTML;
         	rstadd_div(select_div_zyform.dh.value);
         }
         rstadd_div = function(tval){
         	if(tval==' ')
         		$('update_datadiv').innerHTML='';
         }
	</script>
</head>
<body>
	
<%--查询条件div --%>
	<div id ="select_div" class="jrcx">
	<form id="select_div_zyform" name="select_div_zyform">
		<select name="pdh" onchange="hqdtzcd(this.value)">
			<option value=" ">请选择</option>
			<c:if test="${wzlxs != null }">
				<c:forEach var="wzlx_tmp" items="${wzlxs }">
					<option value="${wzlx_tmp[0] }">${wzlx_tmp[1] }</option>
				</c:forEach>
			</c:if>
		</select>
		<em id="dt_zjcd"><select name="dh"><option value=" ">请选择</option></select></em>
		<input id="selbut" type="button" class="selbut" />
		<input id="addbut" type="button" class="addbut" onclick="seleted('-1')"/>
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
		</ul>
	</div>
	<%--数据显示div --%>
	<div id="datashow_div">
	</div>
	<%--数据修改div --%>
	<div id="update_datadiv">
  	</div>
  	<%--动态子菜单div --%>
  	<c:if test="${wzlxs != null }">
		<c:forEach var="wzlx_tmp2" items="${wzlxs }">
			<div id="dtzcd_${wzlx_tmp2[0] }" style="display: none;">
				<select id="sel_${wzlx_tmp2[0] }" name="dh" onchange="rstadd_div(this.value)">
					<option value=" ">请选择</option>
					<c:forEach var="wzlx_tmp2_2" items="${wzlx_tmp2[2] }">
						<option value="${wzlx_tmp2_2[0] }">${wzlx_tmp2_2[1] }</option>
					</c:forEach>
				</select>
			</div>
		</c:forEach>
		<em id="dtzcd_ " style="display: none;"><select name="dh"><option value=" ">请选择</option></select></em>
	</c:if>
</div>

</body>
</html>
