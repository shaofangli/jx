<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
		 
		getPrs = function(x)
		{        
		   return '&method='+x+'&qxmc='+$('qxmc').value+'&mkmc='+$('mkmc').value;
		}
		$('selbut').onclick = function() {
					Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/qxgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage=1'+getPrs('selectAction')
	                });
	                return false;
	            }
	    $('firstd').onclick = function() {
	    			if(parseInt($('currpg').value) == 1)
	    				return false;
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
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
	    			var npg = $('backpg').value;
	                if(parseInt(npg) < 1)
	                	return false;
	                Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
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
	    			var npg = $('nextpg').value;
	                if(parseInt(npg) > parseInt($('lastpg').value))
	                	return false;
	                Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
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
		    				var npg = $('currpg').value;
			                new Ajax.Updater('datashow_div','<c:url value="/manage/qxgl_ajax.htm"/>', 
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
	</script>
</head>
<body>
	
<%--查询条件div --%>
	<div id ="select_div">
		权限名称:<input id="qxmc" type="text" maxlength="10"/>
		模块名称:<input id="mkmc" type="text" maxlength="10"/>
		<input id="selbut" type="button" value="查询"/>
	</div>

<%--分页按钮div --%>
	<div id ="pagination_div" style="display: none;">
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
</body>
</html>
