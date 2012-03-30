<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
		 
		getPrs = function(x)
		{  
		   Element.hide('update_datadiv');      
		   return '&method='+x+'&xm='+trim($('xm').value)+'&lyrq='+trim($('lyrq').value)+'&lx='+trim($('lx').value);
		}
		selects = function() {
					var selpg = 1;
		 			if($('currpg'))
		 			{
		 				if(parseInt($('currpg').value) ==0)
		 					selpg = 1;
		 				else
		 					selpg = parseInt($('currpg').value);
		 			}
		 			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/sub/lygl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'currentpage='+selpg+getPrs('selectAction')
	                });
	                return false;
	    }
		
		$('firstd').onclick = function() {
					if(!$('lastpg'))return false;
	    			if(parseInt($('currpg').value) == 1)
	    				return false;
	    			
	    			Element.update('datashow_div','<div id=loading_data class=loading_data></div>');
	                new Ajax.Updater('datashow_div','<c:url value="/sub/lygl_ajax.htm"/>', 
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
	                new Ajax.Updater('datashow_div','<c:url value="/sub/lygl_ajax.htm"/>', 
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
	                new Ajax.Updater('datashow_div','<c:url value="/sub/lygl_ajax.htm"/>', 
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
		            new Ajax.Updater('datashow_div','<c:url value="/sub/lygl_ajax.htm"/>', 
		            {
		            	method:'post',
		            	asynchronous:true,
		            	evalScripts : true,
		            	parameters:'currentpage='+npg+getPrs('selectAction')
		            });
		            return false;
         }
         $('qx_xx').onclick = function() {
         		if(!$('lygl_lys_form'))return false;
         		else return checkAll(lygl_lys_form);
         }
         $('fx_xx').onclick = function() {
         		if(!$('lygl_lys_form'))return false;
         		else return inverse(lygl_lys_form);
         }
         $('dl_xxs_dq').onclick = function() {
         		if($('lygl_lys_form')){
         			if(parseInt($('lastpg').value)!=0)
         				deletely('',3,'删除当前查询条件下所有数据.');
         			else
         				alert('无记录!');
         		}
         		return false;
         }
         $('dl_xxs_all').onclick = function() {
         		if($('lygl_lys_form')){
         			if(parseInt($('lastpg').value)!=0)
         				deletely('',4,'清空所有留言数据.');
         			else
         				alert('无记录!');
         		}
         		return false;
         }
         $('dl_xxs').onclick = function() {
         		if($('lygl_lys_form')){
         			if(Form.serialize('lygl_lys_form'))
         				deletely('',2,'删除所选择的数据.');
         			else
         				alert('没有选择!');
         		}
         		return false;
         }
         resetcupg=function(){
         	if($('currpg'))
         		$('currpg').value=1;
         	selects();
         }
         deletely = function(dellyid,dellx,delmsg) {
         	
         	var delstr = 'method=deleteAction&dellx='+dellx;
         	
         	if(dellx==1)
         		 delstr=delstr+'&dellyid='+dellyid;
         	if(dellx==2)
         		 delstr=delstr+'&'+Form.serialize('lygl_lys_form');
         	if(dellx==3)
         		 delstr='dellx=3'+getPrs('deleteAction');
         		 
	     	if(confirm((delmsg?delmsg:'')+'确定删除吗?!')){
	     			Element.hide('update_datadiv');
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
			                			selects();
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
	                			selects();
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
	     var yshid = 0;
         seleted = function(hid){
         			if(yshid != hid){$('m_lyhf_pdh').value=hid;Element.show('update_datadiv');yshid=hid;getYzm($('m-lyb-form').vcode_img);}
         			else{showhide('update_datadiv');}
	                return false;
         }
	</script>
</head>
<body>
	
<%--查询条件div --%>
	<div id ="select_div" class="jrcx">
		留言人:<input type="text" name="xm" id="xm" class="ipttext"/>留言日期:<input name="lyrq" id="lyrq" class="ipttext"/>
		类型:<select name="lx">
			<option value="0">留言</option>
			<option value="1">回复</option>
		</select>
		<input id="selbut" type="button" class="selbut" onclick="resetcupg();"/>
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
	<div id="update_datadiv" style="display:none;width:600px;height:auto;">
		 <form name="m-lyb-form" id="m-lyb-form">
    	 	<input type="hidden" value="1" name="lx">
    	 	<input type="hidden" value="0" name="sfnm">
    	 	<input type="hidden" value="2" name="sfkj">
    	 	<input type="hidden" value=""  name="pdh" id="m_lyhf_pdh">
    	 	
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
			
			<c:choose>
				<c:when test="${sessionScope.usr == null}">
					<p>会员帐号：<em class="err">*</em>
				  		<input type="text" name="zh" id="zh" class="txt" />
					<p>密码：<em class="err">*</em>
				  		<input type="password" name="mm" id="mm" class="txt" />
				</c:when>
				<c:otherwise>
				  		<input type="hidden" name="zh" value="${sessionScope.usr.zh}"/>
				  		<input type="hidden" name="xm" value="${sessionScope.usr.xm}"/>
				</c:otherwise>
			</c:choose>
			
			<p>验 证 码：<em class="err">*</em>
			  <input type="text" name="yzm" id='yzm' class="w_inputtext" maxlength="4"/>
			  <img id="vcode_img" name='vcode_img' src="#" />
			  <a href="#" onclick="return getYzm($('m-lyb-form').vcode_img);"><em class="tx">看不清楚，换一张</em></a>
			<p>
			 <input type="button" class="aplbut" value="回复" onclick="return valid_lybform('m-lyb-form');"></p>
		</form>
  	</div>
</div>

</body>
</html>
