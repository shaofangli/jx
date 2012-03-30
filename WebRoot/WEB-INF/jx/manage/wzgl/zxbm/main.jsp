<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
		 
		getPrs = function(x)
		{        
		   return '&method='+x+'&zjhm='+trim($('zjhm').value)+'&sjhm='+trim($('sjhm').value)+'&xm='+trim($('xm').value)+'&sfcl='+trim($('sfcl').value);
		}
		selects = function(cpg) {
					Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
					Element.update('update_datadiv','');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/zxbm_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+cpg+getPrs('selectAction')
	                });
	                return false;
	    }
		
	    $('firstd').onclick = function() {
	    			if(!$('lastpg'))return false;
	    			if(parseInt($('currpg').value) == 1)
	    				return false;  
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/manage/zxbm_ajax.htm"/>', 
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
	                new Ajax.Updater('datashow_div','<c:url value="/manage/zxbm_ajax.htm"/>', 
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
	                new Ajax.Updater('datashow_div','<c:url value="/manage/zxbm_ajax.htm"/>', 
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
		            new Ajax.Updater('datashow_div','<c:url value="/manage/zxbm_ajax.htm"/>', 
		            {
		            	method:'post',
		            	asynchronous:true,
		            	evalScripts : true,
		            	parameters:'currentpage='+npg+getPrs('selectAction')
		            });
		            return false;
         }
         deleted = function(did,bol){
			         if(bol)
			         {
			         	if(confirm('确定删除吗?!')){
			         		myAlert('提示信息','正在删除信息,请稍候...',false,null);
			         		Element.update('update_datadiv','');
		    				var npg = $('currpg').value;
			                new Ajax.Request('<c:url value="/manage/zxbm_ajax.htm"/>', 
			                {
			                	method:'post',
			                	asynchronous:true,
			                	evalScripts : true,
			                	parameters:'delid='+did+'&currentpage='+npg+getPrs('deleteAction'),
			                	onSuccess: function(transport) {
			                		setMyAlertMsg(transport.responseText,true);
				               		if(trim(transport.responseText).indexOf('成功')!= -1)
				               			{selects(npg);getdcls();}
					    		}
			                }); 
	    				}
			         }
	                return false;
         }
         ggclzt =function(sfclv,upid,ysfcl){
         		if(sfclv!='' && sfclv!=ysfcl){
			         	if(confirm('确定更改状态吗?!')){
			         		myAlert('提示信息','正在更改状态信息,请稍候...',false,null);
			         		Element.update('update_datadiv','');
		    				var npg = $('currpg').value;
			                new Ajax.Request('<c:url value="/manage/zxbm_ajax.htm"/>', 
			                {
			                	method:'post',
			                	asynchronous:true,
			                	evalScripts : true,
			                	parameters:'updateid='+upid+'&sfcl='+sfclv+getPrs('updateAction'),
			                	onSuccess: function(transport) {
			                		setMyAlertMsg(transport.responseText,true);
				               		if(trim(transport.responseText).indexOf('成功')!= -1)
				               			{selects(npg);getdcls();}
					    		}
			                }); 
	    				}
	    		}
	            return false;
		 }
         seleted = function(sid){
         			if(sid != '-1')
         				$('updatedx_'+sid).checked="checked";
	                Element.update('update_datadiv','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('update_datadiv','<c:url value="/manage/zxbm_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'tpid='+sid+getPrs('InitTpCzAction')
	                });
	                return false;
         }
	</script>
</head>
<body>
	
<%--查询条件div --%>
	<div id ="select_div" class="jrcx">
		证件号码:<input name="zjhm" id="zjhm" class="ipttext"/>
		姓名:<input name="xm" id="xm" class="ipttext"/>
		手机号码:<input name="sjhm" id="sjhm" class="ipttext"/><br/>
		处理情况:<select name="sfcl">
			<option >请选择</option>
			<option value="0">待处理</option>
			<option value="1">已处理</option>
		</select>
		<input id="selbut" type="button" class="selbut" onclick="selects('1')"/>
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
</div>

</body>
</html>
