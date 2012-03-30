<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<html>
<head>
	<script type="text/javascript">
		var isValdt ;
		var oklenth = 0;
		
		var zhreg = /^[A-Za-z0-9]+$/;
		var yxreg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		var mmreg = /^\w+$/;
		var sjreg = /^(13[0-9]{9})|(15[012356789][0-9]{8})|(18[0256789][0-9]{8})$/;
		var xmreg = /^[\u4e00-\u9fa5]+$/;
		var mmbhdareg = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
		var yzmreg = /^[0-9]{4}$/;
		
		getTxMsg = function(flg,str){
			if(flg==-1)
				return '<em class=err>'+str+'</em>';
			if(flg==1)
				return '<em class=ok>'+str+'</em>';
			if(flg==0)
				return '<em class=tx>'+str+'</em>';
		}
		
		jczh = function(){
			
			eblur($('zh'),'div_zh',1);
			
			if( $('div_zh').title == 'Y')
			{
				$('jc').disabled=true;
				$('jc').value='检测账号是否可用,请稍候...';
				new Ajax.Request('<c:url value="/web/reg.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=existUsr&zh='+$('zh').value,
	                	onSuccess: function(transport) {
	                		$('jc').disabled=false;
	                		$('jc').value='检测账号是否存在';
	                		var v1 = $('div_zh').title;
	                		
	                		if(trim(transport.responseText) == '恭喜你,该账号可用!')
	                			{$('div_zh').title = 'Y';Element.update('div_zh',getTxMsg(1,transport.responseText));}
	                		else
	                			{$('div_zh').title = 'N';Element.update('div_zh',getTxMsg(-1,transport.responseText));}
	                		
	                		setOkLenth('div_zh',v1);
					    }
					    
	        	});
			}
	        return false;
		}
		setOkLenth=function(target,v1){
			 if($(target).title == 'Y' && v1 == 'N')
				oklenth++;
			 if($(target).title == 'N' && v1 == 'Y')
				oklenth--;
		}
		
		isZh =function (strZh,target) {
			if(strZh.length == 0 || strZh.length > 18 || strZh.length < 6){
				return getTxMsg(-1,'账号长度有误!(6至18位!)');
			}
			if(!zhreg.test(strZh))
			{
			    return getTxMsg(-1,'只能输入数字或字母!');
			}
			isValdt = true;
			return getTxMsg(1,'账号输入正确！');
		}
		isMm =function (strMm,target) {
			if(strMm.length == 0 || strMm.length > 18 || strMm.length < 8){
				return getTxMsg(-1,'密码长度有误!(8至18位!)');
			}
			if(!mmreg.test(strMm))
			{
			    return getTxMsg(-1,'只能输入数字、字母或下划线!');
			}
			if(target == 'div_zcmm' && strMm != $('mm').value)
			{
				return getTxMsg(-1,'两次输入的密码不一致！');
			}
			if(target == 'div_mm')
				$('zcmm').focus();
			
			isValdt = true;
			
			return getTxMsg(1,'密码输入正确！');
		}
		isEmail =function (strEmail,target) {
			if(strEmail.length ==0){
				return getTxMsg(-1,'未输入邮箱！');
			}
			if(!yxreg.test(strEmail)){
				return getTxMsg(-1,'邮箱格式错误！');
			}
			isValdt = true;
			return getTxMsg(1,'邮箱格式正确！');
		}
		isDh =function (strDh,target) {
			if(strDh.length ==0){
				return getTxMsg(-1,'未输入手机号码！');
			}
			if(!sjreg.test(strDh)){
				return getTxMsg(-1,'手机号码有误！');
			}
			isValdt = true;
			return getTxMsg(1,'联系方式输入正确！');
		}
		isXm =function (strXm,target) {
			if(strXm.length ==0){
				return getTxMsg(-1,'未输入真实姓名！');
			}
			if(!xmreg.test(strXm)){
				return getTxMsg(-1,'真实姓名只能输入中文！');
			}
			isValdt = true;
			return getTxMsg(1,'真实姓名输入正确！');
		}
		isMmbhwt =function (strMmbhwt,target) {
			if(strMmbhwt == '0'){
				return getTxMsg(-1,'没有选择密码保护问题！');
			}
			isValdt = true;
			return getTxMsg(1,'已选择！');
		}
		isMmbhda =function (strMmbhda,target) {
			if(strMmbhda.length ==0)
				return getTxMsg(-1,'未输入密码保护答案!');
			if(!mmbhdareg.test(strMmbhda)){
				return getTxMsg(-1,'只能输入中文、数字、下划线及英文字母!');
			}
			isValdt = true;
			return getTxMsg(1,'密码保护答案输入正确！');
		}
		isXb =function (strXb,target) {
			if(strXb == '0'){
				return getTxMsg(-1,'没有选择性别！');
			}
			isValdt = true;
			return getTxMsg(1,'已选择！');
		}
		isCsrq =function (strCsrq,target) {
			if(strCsrq == ''){
				return getTxMsg(-1,'没有选择出生日期！');
			}
			isValdt = true;
			return getTxMsg(1,'已选择！');
		}
		isYzm =function (strYzm,target,v1) {
			if(strYzm.length ==0)
				return getTxMsg(-1,'未输入验证码!');
			if(!yzmreg.test(strYzm)){
				return getTxMsg(-1,'验证码输入有误!');
			}
			//isValdt = true;
			//return getTxMsg(1,'验证码已输入！');
			new Ajax.Request('js/imgcode/eqcode.jsp',
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'code='+strYzm,
	                	onSuccess: function(transport) {
	                		if(trim(transport.responseText) == '验证码输入正确!')
	                			{$(target).title='Y';Element.update(target,getTxMsg(1,transport.responseText));}
	                		else
	                			{$(target).title='N';Element.update(target,getTxMsg(-1,transport.responseText));}
	                		setOkLenth(target,v1);
					    }
	        });
		}
		
		efocus = function (source,target,msg,clas){
			if(!clas)
				source.className='inp ipt-focus';
			if(clas == 10)
				{source.className='inp ipt-focus';showCalendar(source);}
			Element.update(target,msg);
		}
		
		eblur = function (source,target,index,clas){
			if(!clas)
			  source.className='inp ipt-normal';
			
			source.value = trim(source.value);
			var v1 = $(target).title;
			msg = '';
			
			isValdt = false;
			
			if(index=='1')
				msg =  isZh(source.value,target);
			if(index=='2')
				msg =  isMm(source.value,target);
			if(index=='4')
				msg =  isEmail(source.value,target);
			if(index=='5')
				msg =  isDh(source.value,target);
			if(index=='6')
				msg =  isXm(source.value,target);
			if(index=='7')
				msg =  isMmbhwt(source.value,target);
			if(index=='8')
				msg =  isMmbhda(source.value,target);
			if(index=='9')
				msg =  isXb(source.value,target);
			if(index=='10')
				msg =  isCsrq(source.value,target);
			if(index=='11')
				msg =  isYzm(source.value,target,v1);
			
			if(isValdt)
				$(target).title='Y';
			else
				$(target).title='N';
			
			if(index != '11'){
				if($(target).title == 'Y' && v1 == 'N')
					oklenth++;
				if($(target).title == 'N' && v1 == 'Y')
					oklenth--;
					
			    Element.update(target,msg);
			}
		}
		doReg = function(){
			if(oklenth != 11){
				myAlert('提示信息','必要信息不完整或有误!',true,'reg-form');
				return false;
			}
			if(!$('servItems').checked){
				myAlert('提示信息','你还未接受服务条款!',true,'reg-form');
				return false;
			}
			if($('div_zh').innerHTML.indexOf('账号可用')==-1)
			{
				myAlert('提示信息','你还未检测账号是否已存在!',true,'reg-form');
				return false;
			}
			myAlert('提示信息','正在提交你的注册信息,请稍候...',false,'reg-form');
			new Ajax.Request('<c:url value="/web/reg.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=doReg&'+Form.serialize('reg-form'),
	                	onSuccess: function(transport) {
	                		if(trim(transport.responseText).indexOf('注册已成功')!=-1)
	                		{Form.reset('reg-form');}
	                		setMyAlertMsg(transport.responseText,true);
					    }
					    
	        });
		}
	</script>
	
</head>
<body>
	<div class="sign" id="sign_content">
		<div class="info1_t"></div>
		<form name="reg-form" id="reg-form">
		<div class="zhuti" >
            <!--<div class="info1_t"><h2>　创建您的帐号</h2></div>-->
			<table class="cont-tab" cellpadding="0" cellspacing="0">
				<!--用户名的处理 Start-->
				<tbody>
				 <tr id="tr_input_username">
				    <td class="td1">账　号：<em class="err">*</em></td>
				    <td class="td2">
					    <div class="fle">
	     				  <input name="zh" id="zh"
	     				  		 onfocus="efocus(this,'div_zh',getTxMsg(0,'请输入需要注册的账号!(数字或英文)'))" 
	     				  		 onblur="eblur(this,'div_zh',1)" 
	     				  		 class="inp ipt-normal" 
	     				  		 onkeyup="value=value.replace(/[\W]/g,'')" 
	     				  		 maxlength="18" type="text">
	    				</div>
						<input type="button" id="jc" class="btn-jc" value="检测账号是否存在" onclick="return jczh();">
					</td>
    				<td class="td3">
        			 <div class="info">
            			<!--提示 Start-->
            			<div class="info-pop">
				            <div class="arr"></div>
				            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
				            <div class="info-pop-c">
	                  			<div class="cont" id="div_zh" title="N">·6~18个字符(字母、数字、或其组合)<br>·字母不区分大小写<br></div>
	                		</div>
	              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
           				</div>
            			<!--提示 End-->
        			 </div>
        			</td>
  				 </tr>
  				 <!--用户名的处理 Ent-->
				
				<tr>
				    <td class="td1">密　码：<em class="err">*</em></td>
				    <td class="td2">
				    	<input name="mm" id='mm' 
	     				  		 onfocus="efocus(this,'div_mm',getTxMsg(0,'请输入密码!(数字、英文或下划线)'))" 
	     				  		 onblur="eblur(this,'div_mm',2)" 
	     				  		 class="inp ipt-normal" 
	     				  		 maxlength="18" type="password">
				    </td>
				    <td class="td3">
        			 <div class="info">
            			<!--提示 Start-->
            			<div class="info-pop">
				            <div class="arr"></div>
				            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
				            <div class="info-pop-c">
	                  			<div class="cont" id="div_mm" title="N">·密码长度为8至18位,包括字母、数字和下划线</div>
	                		</div>
	              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
           				</div>
            			<!--提示 End-->
        			 </div>
        			</td>
  				</tr>
  				
			    <tr>
			    	<td class="td1">再次输入密码：<em class="err">*</em></td>
			    	<td class="td2">
			    		<input name="zcmm" id="zcmm" 
	     				  		 onfocus="efocus(this,'div_zcmm',getTxMsg(0,'请再次输入密码!(数字、英文或下划线)'))" 
	     				  		 onblur="eblur(this,'div_zcmm',2)" 
	     				  		 class="inp ipt-normal" 
	     				  		 maxlength="18" type="password">
			    	</td>
			    	<td class="td3">
        			 <div class="info">
            			<!--提示 Start-->
            			<div class="info-pop">
				            <div class="arr"></div>
				            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
				            <div class="info-pop-c">
	                  			<div class="cont" id="div_zcmm" title="N">·重复确认所输入的密码</div>
	                		</div>
	              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
           				</div>
            			<!--提示 End-->
        			 </div>
        			</td>
			  	</tr>
			  	
			  	<tr id="tr_chk_username_result">
				    <td class="td1">电子邮箱：<em class="err">*</em></td>
				    <td class="td2">
				    	<input name="yx" 
	     				  		 onfocus="efocus(this,'div_yx',getTxMsg(0,'请输入你的电子邮箱!(激活账号需要用到)'))" 
	     				  		 onblur="eblur(this,'div_yx',4)" 
	     				  		 class="inp ipt-normal" 
	     				  		 maxlength="30" type="text">
				    </td>
				    <td class="td3">
        			 <div class="info">
            			<!--提示 Start-->
            			<div class="info-pop">
				            <div class="arr"></div>
				            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
				            <div class="info-pop-c">
	                  			<div class="cont" id="div_yx" title="N">·推荐使用163邮箱</div>
	                		</div>
	              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
           				</div>
            			<!--提示 End-->
        			 </div>
        			</td>
    			</tr>
				
				<tr>
				    <td class="td1">手机号码：<em class="err">*</em></td>
				    <td class="td2">
				    	<input name="dh" 
	     				  		 onfocus="efocus(this,'div_dh',getTxMsg(0,'请输入你常用的号码!(激活VIP用户需要用到)'))" 
	     				  		 onblur="eblur(this,'div_dh',5)" 
	     				  		 class="inp ipt-normal" 
	     				  		 maxlength="11" type="text">
				    </td>
				    <td class="td3">
        			 <div class="info">
            			<!--提示 Start-->
            			<div class="info-pop">
				            <div class="arr"></div>
				            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
				            <div class="info-pop-c">
	                  			<div class="cont" id="div_dh" title="N">·你常用的手机号码</div>
	                		</div>
	              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
           				</div>
            			<!--提示 End-->
        			 </div>
        			</td>
				</tr>
				
				<tr>
				    <td class="td1">真实姓名：<em class="err">*</em></td>
				    <td class="td2">
				    	<input name="xm" 
	     				  		 onfocus="efocus(this,'div_xm',getTxMsg(0,'请如实填写你的真实姓名!'))" 
	     				  		 onblur="eblur(this,'div_xm',6)" 
	     				  		 class="inp ipt-normal" 
	     				  		 maxlength="5" type="text">
				    </td>
				    <td class="td3">
        			 <div class="info">
            			<!--提示 Start-->
            			<div class="info-pop">
				            <div class="arr"></div>
				            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
				            <div class="info-pop-c">
	                  			<div class="cont" id="div_xm" title="N">·真实姓名或昵称(中文)</div>
	                		</div>
	              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
           				</div>
            			<!--提示 End-->
        			 </div>
        			</td>
				</tr>
				
			   </tbody>
		    </table>
		    <!-- 创建您的帐号end -->
			
　　　　		<!--<div class="info1_t"><h2>　安全信息设置 (以下信息非常重要，请慎重填写）</h2></div>-->
　　　　		<table class="cont-tab" cellpadding="0" cellspacing="0">
  				<tbody>
  					<tr>
    					<td width="271" class="td1">密码保护问题：<em class="err">*</em></td>
    					<td width="286" class="td2">
					      <select name="mmbhwt" class="sel" 
					      		onfocus="efocus(this,'div_mmbhwt',getTxMsg(0,'请选择密码提示问题!'),1)" 
					      		onblur="eblur(this,'div_mmbhwt',7,1)" 
					      >
					        <option selected="selected" style="color: rgb(102, 102, 102);" value="0">请选择密码提示问题</option>
					        <option value="1">您母亲的姓名是?</option>
					        <option value="2">您父亲的姓名是?</option>
					        <option value="3">您配偶的姓名是?</option>
					        <option value="4">您母亲的生日是?</option>
					        <option value="5">您父亲的生日是?</option>
					        <option value="6">您配偶的生日是?</option>
					      </select>
      					</td>
    					<td class="td3">
	        			 <div class="info">
	            			<!--提示 Start-->
	            			<div class="info-pop">
					            <div class="arr"></div>
					            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
					            <div class="info-pop-c">
		                  			<div class="cont" id="div_mmbhwt" title="N">·设置密码保护问题,忘记密码时需要用到</div>
		                		</div>
		              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
	           				</div>
	            			<!--提示 End-->
	        			 </div>
	        			</td>
  					</tr>
  					 
  					<tr>
					    <td class="td1">密码保护问题答案：<em class="err">*</em></td>
					    <td class="td2">
					    	<input name="mmbhda" 
	     				  		 onfocus="efocus(this,'div_mmbhda',getTxMsg(0,'请输入密码保护答案!(不超过20个字符)'))" 
	     				  		 onblur="eblur(this,'div_mmbhda',8)" 
	     				  		 class="inp ipt-normal" 
	     				  		 maxlength="20" type="text">
					    </td>
    					<td class="td3">
	        			 <div class="info">
	            			<!--提示 Start-->
	            			<div class="info-pop">
					            <div class="arr"></div>
					            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
					            <div class="info-pop-c">
		                  			<div class="cont" id="div_mmbhda" title="N">·不超过20个字符(包括字母、数字、下划线和汉字)</div>
		                		</div>
		              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
	           				</div>
	            			<!--提示 End-->
	        			 </div>
	        			</td>
  					</tr>
  					
					<tr>
					    <td class="td1">性　别：<em class="err">*</em></td>
					    <td class="td2" style="font-size: 14px;"><label for="rd1">
					    	<input name="xb"  value="1" type="radio" 
					    	onfocus="efocus(this,'div_xb',getTxMsg(0,'请选择你的性别!'),1)" 
					    	onclick="eblur(this,'div_xb',9,1)"/> 男
					    	</label>&nbsp;&nbsp;&nbsp;&nbsp;<label for="rd2">
					    	<input name="xb"  value="2" 
					    	onfocus="efocus(this,'div_xb',getTxMsg(0,'请选择你的性别!'),1)" 
					    	onclick="eblur(this,'div_xb',9,1)"  type="radio"/> 女</label>
					    </td>
					    <td class="td3">
	        			 <div class="info">
	            			<!--提示 Start-->
	            			<div class="info-pop">
					            <div class="arr"></div>
					            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
					            <div class="info-pop-c">
		                  			<div class="cont" id="div_xb" title="N">·性别选择</div>
		                		</div>
		              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
	           				</div>
	            			<!--提示 End-->
	        			 </div>
	        			</td>
					</tr>
					
					<tr>
					    <td class="td1">出生日期：<em class="err">*</em></td>
					    <td class="td2" style="font-size: 14px;">
					    	<input name="csrq" 
	     				  		 onfocus="efocus(this,'div_csrq',getTxMsg(0,'请选择你的出生年月!'),10)" 
	     				  		 class="inp ipt-normal" 
	     				  		 type="text" readonly="readonly">
					    </td>
					    <td class="td3">
	        			 <div class="info">
	            			<!--提示 Start-->
	            			<div class="info-pop">
					            <div class="arr"></div>
					            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
					            <div class="info-pop-c">
		                  			<div class="cont" id="div_csrq" title="N">·点击输入框进行日期选择</div>
		                		</div>
		              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
	           				</div>
	            			<!--提示 End-->
	        			 </div>
	        			</td>
					</tr>
				</tbody>
			</table>
			<!-- 安全信息设置end -->

        	<!--<div class="info1_t"><h2>　注册验证</h2></div> -->
			<table class="cont-tab" cellpadding="0" cellspacing="0">
			    <tbody>
				  <tr>
				    <td class="td1">&nbsp;</td>
				    <td class="td2 codeImg">
				    	<img id="vcode_img" name="vcode_img" src="js/imgcode/image.jsp" />&nbsp;&nbsp;
				    	<a href="#" onclick="return getYzm($('reg-form').vcode_img);"><em class="tx">看不清楚，换一张</em></a></td>
				    <td class="td3">&nbsp;</td>
				  </tr>
				  <tr>
				    <td class="td1">验证码：<em class="err">*</em></td>
				    <td class="td2">
				    	<input name="yzm" id='yzm' 
	     				  		 onfocus="efocus(this,'div_yzm',getTxMsg(0,'请输入图中的数字!'))" 
	     				  		 onblur="eblur(this,'div_yzm',11)" 
	     				  		 class="inp ipt-normal" 
	     				  		 maxlength="4" type="text" >
				    </td>
				    <td class="td3">
        			 <div class="info">
            			<!--提示 Start-->
            			<div class="info-pop">
				            <div class="arr"></div>
				            <div class="info-pop-t"><b class="cr-l"></b><b class="cr-r"></b></div>
				            <div class="info-pop-c">
	                  			<div class="cont" id="div_yzm" title="N">·输入验证码</div>
	                		</div>
	              			<div class="info-pop-b"><b class="cr-l"></b><b class="cr-r"></b></div>
           				</div>
            			<!--提示 End-->
        			 </div>
        			</td>
				  </tr>
				</tbody>
			</table>
			<!-- 注册验证end -->
　　　
        	<!--  <div class="info1_t"><h2>　服务条款</h2></div> -->
　　　　　　	<table class="cont-tab" cellpadding="0" cellspacing="0">
			  <tbody>
				  <tr>
				    <td class="td1">&nbsp;</td>
				    <td class="td2" style="width: auto;" colspan="2">
				    	<label><input name="servItems" id="servItems" checked="checked" type="checkbox">我已阅读并接受服务条款</label>
				    </td>
				    <!--  <td class="td3">&nbsp;</td>  -->
				  </tr>
				  <tr>
				    <td class="td1">&nbsp;</td>
				    <td ><input onclick="return doReg();" title="创建帐号" type="image" src="images/login-1_11.jpg"></td>
				    <td class="td3">&nbsp;</td>
				  </tr>
			  </tbody>
			</table>
			<!-- 服务条款end -->
		</div>
		</form>
	</div>
</body>
</html>