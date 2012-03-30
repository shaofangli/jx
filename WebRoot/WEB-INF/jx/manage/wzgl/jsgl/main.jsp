<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
		 
		getPrs = function(x)
		{        
		   return '&method='+x+'&jsmc='+$('jsmc').value;
		}
		selects = function() {
					Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
					Element.update('update_datadiv','');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/jsgl_ajax.htm"/>', 
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
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	    			if(parseInt($('currpg').value) == 1)
	    				return false;  
	                new Ajax.Updater('datashow_div','<c:url value="/next_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage=1'+getPrs('selectAction')
	                });
	                return false;
	            }
	    $('backd').onclick = function() {
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	    			var npg = $('backpg').value;
	                if(parseInt(npg) < 1)
	                	return false;
	                new Ajax.Updater('datashow_div','<c:url value="/next_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+npg+getPrs('selectAction')
	                });
	                return false;
	            }
	    $('nextd').onclick = function() {
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	    			var npg = $('nextpg').value;
	                if(parseInt(npg) > parseInt($('lastpg').value))
	                	return false;
	                new Ajax.Updater('datashow_div','<c:url value="/next_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+npg+getPrs('selectAction')
	                });
	                return false;
	            }
         $('lastd').onclick = function() {
         			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	         		if(parseInt($('currpg').value) == parseInt($('lastpg').value))
		    			return false;  
		            new Ajax.Updater('datashow_div','<c:url value="/next_ajax.htm"/>', 
		            {
		            	method:'post',
		            	asynchronous:true,
		            	evalScripts : true,
		            	parameters:'currentpage='+$('lastpg').value+getPrs('selectAction')
		            });
		            return false;
         }
         deleted = function(did,bol){
			         if(bol)
			         {
			         	if(confirm('确定删除吗?!')){
			         		Element.update('update_datadiv','');
		    				var npg = $('currpg').value;
			                new Ajax.Updater('datashow_div','<c:url value="/manage/jsgl_ajax.htm"/>', 
			                {
			                	method:'post',
			                	asynchronous:true,
			                	evalScripts : true,
			                	parameters:'delid='+did+'&currentpage='+npg+getPrs('deleteAction')
			                }); 
	    				}
			         }
	                return false;
         }
         seleted = function(sid){
         			Element.update('update_datadiv','<div id=loading_data class=loading_data></div>');
         			$('updatedx_'+sid).checked="checked";
	                new Ajax.Updater('update_datadiv','<c:url value="/manage/jsgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'jsid='+sid+getPrs('InitJsCzAction')
	                });
         }
         addd = function(){
         		var jsmc = trim($('jsmc').value);
         		if(jsmc == '')
         		{
         			myAlert('提示信息','角色名称不能为空',true,null);
         		}else{
         			new Ajax.Updater('datashow_div','<c:url value="/manage/jsgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'jsmc='+jsmc+getPrs('insertAction')
	                });
         		}
	          return false;
         }
	</script>
</head>
<body>
	
<%--查询条件div --%>
	<div id ="select_div" class="jrcx">
		角色名称:<input id="jsmc" type="text" class="ipttext"/>
		<input id="selbut" type="button" class="selbut" />
		<input id="addbut" type="button" class="addbut" onclick="return addd();"/>
	</div>
<div id ="ldpg">
	<%--分页按钮div --%>
	<div id ="pagination_div" style="display: none;">
		<ul class="options">
			<li id="firstd"><a href="">首页</a></li>
			<li id="backd"><a href="">上一页</a></li>
			<li id="nextd"><a href="">下一页</a></li>
			<li id="lastd"><a href="">尾页</a></li>
		</ul>
	</div><p/>
	<%--数据显示div --%>
	<div id="datashow_div">
	</div>
	<%--数据修改div --%><p/>	
	<div id="update_datadiv">
  	</div>
</div>


</body>
</html>
