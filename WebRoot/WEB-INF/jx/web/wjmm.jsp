<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<html>
	<head>
		<script type="text/javascript">
		var isValdt ;
		var zhreg = /^[A-Za-z0-9]+$/;
		var mmreg = /^\w+$/;
		var mmbhdareg = /^[\u4e00-\u9fa5_a-zA-Z0-9]+$/;
		var yzmreg = /^[0-9]{4}$/;
		fhzjm = function(){
			$('yh_box_login').innerHTML = $('dxslgxdiv').innerHTML;$('dxslgxdiv').innerHTML='';
		}
		getTxMsg = function(flg,str){
			if(flg==-1)
				setMyAlertMsg('<em class=err>'+str+'</em>',true);
			if(flg==1)
				setMyAlertMsg('<em class=ok>'+str+'</em>',true);
			if(flg==0)
				setMyAlertMsg('<em class=tx>'+str+'</em>',true);
			
			if(flg==-1)
				return false;
			else
				return true;
		}
		tjcsmmqq = function(){
			setMyAlertMsg('正在重设账号['+$('zh').value+']的密码信息,请稍候...',false);
				new Ajax.Request('<c:url value="/web/login.htm"/>', 
		                {
		                	method:'post',
		                	asynchronous:true,
		                	evalScripts : true,
		                	parameters:'method=doRestmm&'+Form.serialize('wjmm-form'),
		                	onSuccess: function(transport) {
		                		if(trim(transport.responseText).indexOf('成功')!=-1)
		                		{Form.reset('wjmm-form');fhzjm();}
		                		setMyAlertMsg(transport.responseText,true);
						    }
						    
		        });
		}
		isZh =function () {
			if($('zh').value.length == 0 || $('zh').value.length > 18 || $('zh').value.length < 6){
				return getTxMsg(-1,'[账号]长度有误!(6至18位!)');
			}
			if(!zhreg.test($('zh').value))
			{
			    return getTxMsg(-1,'[账号]只能输入数字或字母!');
			}
			return true;
		}
		isMm =function () {
			if($('mm').value.length == 0 || $('mm').value.length > 18 || $('mm').value.length < 8){
				return getTxMsg(-1,'[密码]长度有误!(8至18位!)');
			}
			if(!mmreg.test($('mm').value))
			{
			    return getTxMsg(-1,'[密码]只能输入数字、字母或下划线!');
			}
			return true;
		}
		isMmbhwt =function () {
			if($('mmbhwt').value == '0'){
				return getTxMsg(-1,'没有选择[密码保护问题]！');
			}
			return true;
		}
		isMmbhda =function () {
			if($('mmbhda').value.length ==0)
				return getTxMsg(-1,'未输入[密码保护答案]!');
			if(!mmbhdareg.test($('mmbhda').value)){
				return getTxMsg(-1,'[密码保护答案]只能输入中文、数字、下划线及英文字母!');
			}
			return true;
		}
		isYzm =function () {
			if($('yzm').value.length ==0)
				return getTxMsg(-1,'未输入验证码!');
			if(!yzmreg.test($('yzm').value)){
				return getTxMsg(-1,'验证码输入有误!');
			}
			new Ajax.Request('js/imgcode/eqcode.jsp',{
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'code='+$('yzm').value,
	                	onSuccess: function(transport) {
	                		if(trim(transport.responseText) == '验证码输入正确!')
	                			{tjcsmmqq();}
	                		else
	                			{getTxMsg(-1,'验证码不匹配!');}
					    }
	        });
	        return false;
		}
		
		yzcsmmfm = function(){
			myAlert('提示信息','验证信息中...',false,'wjmm-form');
			if(isZh() && isMm() && isMmbhwt() && isMmbhda()){
				isYzm();
			}
			return false;
		}
	</script>

	</head>
	<body>
		<div>
			<form name="wjmm-form" id="wjmm-form">
				<div>
					<!--<div class="info1_t"><h2>　创建您的帐号</h2></div>-->
					<table cellpadding="0" cellspacing="5" width="100%">
						<tr id="tr_input_username">
							<td>
								我的账号
								<em class="err">*</em>
							</td>
							<td>
								<input name="zh" id="zh" class="w_inputtext"
									onkeyup="value=value.replace(/[\W]/g,'')" maxlength="18"
									type="text">
							</td>
						</tr>
						<tr>
							<td style="width: 210px;">
								新的密码
								<em class="err">*</em>
							</td>
							<td>
								<input name="mm" id='mm' class="w_inputtext" maxlength="18"
									type="password">
							</td>
						</tr>
						<tr>
							<td>
								密码问题
								<em class="err">*</em>
							</td>
							<td>
								<select name="mmbhwt" style="width: 135px;">
									<option selected="selected" style="color: rgb(102, 102, 102);"
										value="0">
										请选择你设置的问题
									</option>
									<option value="1">
										您母亲的姓名是?
									</option>
									<option value="2">
										您父亲的姓名是?
									</option>
									<option value="3">
										您配偶的姓名是?
									</option>
									<option value="4">
										您母亲的生日是?
									</option>
									<option value="5">
										您父亲的生日是?
									</option>
									<option value="6">
										您配偶的生日是?
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								问题答案
								<em class="err">*</em>
							</td>
							<td>
								<input name="mmbhda" class="w_inputtext" maxlength="20"
									type="text">
							</td>
						</tr>

						<tr>
							<td>
								&nbsp;
							</td>
							<td class="td2 codeImg">
								<img id="vcode_img" name="vcode_img" src="js/imgcode/image.jsp" />
								<a href="#" onclick="return getYzm($('wjmm-form').vcode_img);"><em class="tx">换一张</em> </a>
							</td>
						</tr>
						<tr>
							<td>
								验&nbsp;&nbsp;证&nbsp;码
								<em class="err">*</em>
							</td>
							<td>
								<input name="yzm" id='yzm' class="w_inputtext" maxlength="4"
									type="text">
							</td>
						</tr>
						<tr>
							<td>
								<input type="reset" value="返回登陆" onclick="fhzjm();" style="width:60px;border:1px solid #669999;background:none;"/>
							</td>
							<td>
							<input type="button" value="重设密码" onclick="return yzcsmmfm();" style="border:1px solid #669999;background: none;"/>
								<input type="reset" value="重置" style="border:1px solid #669999;background: none;"/>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<div id="dxslgx" style="display: none;">${zqlgnr}</div>
	</body>
</html>
