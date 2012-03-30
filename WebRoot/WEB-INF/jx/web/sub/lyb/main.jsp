<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
	     
		 getPrs = function(x)
		 {
		   return '&method='+x;
		 }
		 $('firstd').onclick = function() {
		 			if(!$('currpg'))return false;
	    			if(parseInt($('currpg').value) == 1)
	    				return false;  
	                new Ajax.Updater('showlys_div','<c:url value="/sub/lygl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage=1'+getPrs('showLys')
	                });
	                return false;
	            }
	    $('backd').onclick = function() {
	    			if(!$('currpg'))return false;
	    			var npg = $('backpg').value;
	                if(parseInt(npg) < 1)
	                	return false;
	                new Ajax.Updater('showlys_div','<c:url value="/sub/lygl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+npg+getPrs('showLys')
	                });
	                return false;
	            }
	    $('nextd').onclick = function() {
	    			if(!$('currpg'))return false;
	    			var npg = $('nextpg').value;
	                if(parseInt(npg) > parseInt($('lastpg').value))
	                	return false;
	                new Ajax.Updater('showlys_div','<c:url value="/sub/lygl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+npg+getPrs('showLys')
	                });
	                return false;
	            }
         $('lastd').onclick = function() {
         			if(!$('currpg'))return false;
	         		if(parseInt($('currpg').value) == parseInt($('lastpg').value))
		    			return false;  
		            new Ajax.Updater('showlys_div','<c:url value="/sub/lygl_ajax.htm"/>', 
		            {
		            	method:'post',
		            	asynchronous:true,
		            	evalScripts : true,
		            	parameters:'currentpage='+$('lastpg').value+getPrs('showLys')
		            });
		            return false;
         }
		 initly = function() {
		 			var selpg = 1;
		 			if($('currpg'))
		 			{
		 				if(parseInt($('currpg').value) ==0)
		 					selpg = 1;
		 				else
		 					selpg = parseInt($('currpg').value);
		 			}
		 			
	                new Ajax.Updater('showlys_div','<c:url value="/sub/lygl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+selpg+getPrs('showLys')
	                });
	                return false;
	     }
	     deletely = function(dellyid,dellx) {
	     	var delstr = 'method=deleteAction&dellx='+dellx+'&dellyid='+dellyid;
	     	if(confirm('确定删除吗?!')){
	                myAlert('提示信息','正在删除信息,请稍候...',false,null);
					new Ajax.Request('<c:url value="/sub/lygl_ajax.htm"/>', 
			         {
			                	method:'post',
			                	asynchronous:true,
			                	evalScripts : true,
			                	parameters:delstr,
			                	onSuccess: function(transport) {
			                		setMyAlertMsg(transport.responseText,true);
			                		if(trim(transport.responseText).indexOf('成功')!= -1){
			                			initly();
			                		}
							    }
							    
			        });
			 }
			 return false;
	     }
	     submyly = function (subformids){
	        var tmethod = '';
	        if('lyb-form' == subformids)
	        	tmethod='insertAction&';
	        else
	        	tmethod='updateAction&';
	        
	     	new Ajax.Request('<c:url value="/sub/lygl_ajax.htm"/>', 
	         {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method='+tmethod+Form.serialize(subformids),
	                	onSuccess: function(transport) {
	                		setMyAlertMsg(transport.responseText,true);
	                		if(trim(transport.responseText).indexOf('成功')!= -1){
	                			Form.reset(subformids);
	                			getYzm($(subformids).vcode_img);
	                			initly();
	                		}
					    }
					    
	        });
	     }
		 submit_lybform = function (subformids){
		    if($(subformids).zh && $(subformids).mm){
		    	myAlert('提示信息','正在验证用户信息,请稍候...',false,subformids);
				new Ajax.Request('<c:url value="/web/login.htm"/>', 
		               {
		               	method:'post',
		               	asynchronous:true,
		               	evalScripts : true,
		               	parameters:Form.serialize(subformids),
		               	onSuccess: function(transport) {
		               		if(trim(transport.responseText) != 'ok')
		               			setMyAlertMsg(transport.responseText,true);
		               		else{
		               			setMyAlertMsg('用户信息验证通过,正在提交信息...',false);
		               			$('lyb_logdhk').innerHTML='';
		               			submyly(subformids);
		               		}
					    }
		       });
		    }else{
		    	myAlert('提示信息','正在提交你的留言信息,请稍候...',false,subformids);
		    	submyly(subformids);
		    }
		 }
         valid_lybform = function (formids){
         	
         	if(($(formids).zh && trim($(formids).zh.value).length ==0) || ($(formids).mm && trim($(formids).mm.value).length ==0) || 
         	   trim($(formids).yzm.value).length ==0 || trim($(formids).lyb_comments.value).length ==0){
         		myAlert('提示信息','必填信息不能有空!',true,formids);
         		return false;
         	}/**
         	if(trim($(formids).lyb_comments.value).length > 100){
         		myAlert('提示信息','字数太多!',true,formids);
         		return false;
         	}*/
         		
         	new Ajax.Request('js/imgcode/eqcode.jsp',
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'code='+trim($(formids).yzm.value),
	                	onSuccess: function(transport) {
	                		if(trim(transport.responseText) == '验证码输入正确!')
	                			{
	                				submit_lybform(formids);
	                			}
	                		else
	                			{myAlert('提示信息','验证码错误,已失效?',true,formids);return false;}
					    }
	        });
         	return false;
         }
         tReg = function()
		 {
			new Ajax.Updater('main_content','<c:url value="/web/reg.htm"/>', 
		               {
		               	method:'post',
		               	asynchronous:true,
		               	evalScripts : true
		       });
		 }
	</script>
</head>
<body>
   <div class="text_W"> 
	 <div class="text_T">${ljbt }</div>
	 <div class="text_X"> </div>
   	 <div class="text_C">
   	 <table width="600px" cellpadding="0" cellspacing="0">
	   <tr>
	    	<td height="120"><img src="images/bbs_ad.jpg" width="600px" height="91" /></td>
	   </tr>
	   <tr>
   		  <td>
   		  	  <div id="showlys_div"><div class="loading_data"></div></div>
    	  </td>
  		</tr>
  		<tr>
  			<td>
  				<%--分页按钮div --%>
				<div id ="pagination_div" style="display: block;">
					<ul class="options">
						<li id="firstd"><a href="">首页</a></li>
						<li id="backd"><a href="">上一页</a></li>
						<li id="nextd"><a href="">下一页</a></li>
						<li id="lastd"><a href="">尾页</a></li>
					</ul>
				</div>
  			</td>
  		</tr>
  	   <tr>
    	 <td width="600px">
	    	 <form name="lyb-form" id="lyb-form">
	    	 	<input type="hidden" value="0" name="lx">
	    	 	<input type="hidden" value="0" name="sfnm">
	    	 	<input type="hidden" value="0" name="sfkj">
	    	 	<input type="hidden" name="pdh">
				<%-- 加载表情 --%>
				<c:forEach begin="1" end="16" var="bqitms">
			  		<img src="/jx/js/comment/plugins/emoticons/${bqitms-1 }.gif"/>
			  		<c:choose>
				  		<c:when test="${bqitms == 1}">
				  			<input type="radio" checked="checked" name="bq" value="/jx/js/comment/plugins/emoticons/${bqitms-1 }.gif"/>
				  		</c:when>
				  		<c:otherwise>
				  			<input type="radio" name="bq" value="/jx/js/comment/plugins/emoticons/${bqitms-1 }.gif"/>
				  		</c:otherwise>
			  		</c:choose>
			  		<c:if test="${bqitms % 8 == 0}"><br/></c:if>
				</c:forEach>
				<textarea name="lyb_comments" id="lyb_comments" cols="50" rows="10" class="w_txtarea"></textarea>
				
				<c:if test="${sessionScope.usr == null}">
				<div id="lyb_logdhk">
					<p>会员帐号：<em class="err">*</em>
				  		<input type="text" name="zh" id="zh" maxlength="18" class="w_inputtext"/><em class="tx" style="cursor: hand" onclick="tReg()">不是会员?</em>
					<p>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：<em class="err">*</em>
				  		<input type="password" name="mm" id="mm" maxlength="18" class="w_paswdtext" />
				</div>
				</c:if>
				
				<p>验 证&nbsp;码：<em class="err">*</em>
				  <input type="text" name="yzm" id='yzm' class="w_inputtext" maxlength="4"/>
				  <img id="vcode_img" name='vcode_img' src="js/imgcode/image.jsp" />
				  <a href="#" onclick="return getYzm($('lyb-form').vcode_img);"><em class="tx">看不清楚，换一张</em></a>
				<p>
				  <input type="button" class="tjbut" onclick="return valid_lybform('lyb-form');"></p>
			 </form>
		 </td>
  		</tr>
	  </table>
      </div>
   </div>
   <script type="text/javascript">
   		initly();
   </script>
</body>
</html>
