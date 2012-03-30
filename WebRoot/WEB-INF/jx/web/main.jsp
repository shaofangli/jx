<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<html>
	<head>
		<script type="text/javascript" language="javascript">
		clear = function()
		{ 
			Source=document.body.firstChild.data; 
			document.open(); 
			document.close(); 
			document.title="错误请求"; 
			document.body.innerHTML=Source; 
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
		iLogin = function()
		{
			Element.hide('header');Element.hide('foot_div');
			new Ajax.Updater('main_div','<c:url value="/manage/main.htm"/>', 
		               {
		               	method:'post',
		               	asynchronous:true,
		               	evalScripts : true,
		               	parameters:'method=toManag'
		       });
		}
		oLogin = function(updiv,flg)
		{
			new Ajax.Updater(updiv,'<c:url value="/web/login.htm"/>', 
		               {
		               	method:'post',
		               	asynchronous:true,
		               	evalScripts : true,
		               	parameters:'method=logOut&flg='+flg
		       });
		       return false;
		}
		tLogin = function()
		{
			if(trim($('login-form').zh.value).length == 0 || trim($('login-form').mm.value).length == 0)
			{myAlert('提示信息','用户名或密码不能为空！',true,'login-form');return false;}
			
			myAlert('提示信息','登录中,请稍候...',false,'login-form');
			new Ajax.Request('<c:url value="/web/login.htm"/>', 
		               {
		               	method:'post',
		               	asynchronous:true,
		               	evalScripts : true,
		               	parameters:Form.serialize('login-form'),
		               	onSuccess: function(transport) {
		               		if(trim(transport.responseText) != 'ok')
		               			setMyAlertMsg(transport.responseText,true);
		               		else{
		               			setMyAlertMsg('登录成功!',false);
		               			iLogin();}
					    }
		       });
		}
		keySub = function ()  
				{
				  if(event.keyCode==13)
				  {  
				  	return tLogin();
				  }
		}
		twjmm = function(){
			Form.reset('login-form');
			$('dxslgxdiv').innerHTML = $('yh_box_login').innerHTML;
			Element.update('yh_box_login','<div id=loading_data class=loading_data></div>');
			new Ajax.Updater('yh_box_login','<c:url value="/web/login.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=initWjmm'
	        });
	        return false;
		}
		sTpbox = function(lxid,s_div,s_mtd)
		{
			new Ajax.Updater(s_div,'<c:url value="/web/main.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method='+s_mtd+'&lxid='+lxid
	        });
		}
		wz_setcf = function(v1,v2,v3,v4,v5){
			window.document.title=v1;
			window.document.getElementsByName('keywords').content=v2;
			window.document.getElementsByName('description').content=v3;
			$('wzBottomInfo').innerHTML=v4;
			$('w_topinfo').innerHTML='<a href="#" onclick="return init_w_index(true);" style="color:#FFFFFF;">返回首页</a>　|　<em onclick="add_fv(\''+v5+'\',\''+v1+'\')">加入收藏</em>　|　<em onclick="set_hm(this,\''+v5+'\')">设为首页</em>'; 
		}
	</script> 
	</head>
	<body onload="clear();">
		<c:if test="${sessionScope.ActivationUsr != null}">
			 <script>myAlert('提示信息','账号激活成功,你现在可以从首页登录了!',true,null);</script>
			 <%request.getSession(false).removeAttribute("ActivationUsr"); %>
		</c:if>
		<div id="main_content">
			<div id="content">
				<div class="box1" id="tp_box_1">
					<%-- box1 --%><div class="loading_data"></div>
				</div>
				
				<div class="login">
					<div class="hy" id="yh_box_login">
						<%-- yh --%>
						<form id="login-form" name="login-form">
							<table width="100%" cellpadding="0" cellspacing="0">
								<c:if test="${sessionScope.usr == null}">
								<tr>
									<td height="30" colspan="2">
										<img src="images/member1_10.jpg" width="25" height="24" />
										<span class="STYLE1">会员登录</span>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td height="30">
										账 号：
									</td>
									<td>
										<label>
											<input class="w_inputtext" name="zh" type="text" size="15" maxlength="18" onkeydown="return keySub();"/>
										</label>
									</td>
								</tr>
								<tr>
									<td height="30">
										密 码：
									</td>
									<td>
										<label>
											<input class="w_paswdtext" name="mm" type="password" size="15" maxlength="18" onkeydown="return keySub();"/>
										</label>
									</td>
								</tr>
								<tr>
									<td height="40" colspan="2">
										<div align="center">
											<img name="submit" src="images/member2_14.jpg" width="80"
												height="30" onclick="return tLogin();" style="cursor: hand;" />
											<img name="submit" src="images/member3_16.jpg" width="80"
												height="30" onclick="tReg()" style="cursor: hand;" />
										</div>
									</td>
								</tr>
								<tr>
									<td height="30" colspan="2">
										<div align="center" class="STYLE2">
											<a href="#" onclick="return twjmm();">忘记密码</a> | <a href="#" onclick="return tSub('留言板','湖南交通驾校首页>>互动天地>>留言板','initlyb','','','','hdtd')" >在线答疑</a>
										</div>
									</td>
								</tr>
								</c:if>
								<c:if test="${sessionScope.usr != null}">
								欢迎你:<B>${sessionScope.usr.xm}</B>&nbsp;
								<em class="err" onclick="return oLogin('main_div','w');" style="cursor: hand;"><img src="images/exclamation.png"/>退出</em>&nbsp;
								<em class="ok" onclick="iLogin();" style="cursor: hand;"><img src="images/user_edit.png"/>管理中心</em>
								<div id="s_flscj" class="c_flscj">
									<div style="text-align:left;padding-left: 10px;padding-right: 10px;overflow:hidden;position:relative;z-index: 2">
										<!--  <select id="CalYear" onChange="javascript:ChgYear(this);">
										</select>年
										<select id="CalMonth" onChange="javascript:ChgMonth(this);">
										</select>月-->
										<input id="CalYear" disabled="disabled" class="yyrtext"/>年<input id="CalMonth" class="yyrtext" disabled="disabled"/>月<input id="CalDayd" class="yyrtext" disabled="disabled"/>日<p/>
										<hr style="border:#b0d3ee 1px solid;" size="2"/>
									</div>
									<div class="date">
										<div id="CalBody"></div>
									</div>
								</div>
								</c:if>
							</table>
				   		</form>
					</div>
					<div id="dxslgxdiv" style="display: none;"></div>
				</div>

				<div class="intr">
					<div class="intr1">
					</div>
					<div id="jxgk_box" class="intr2">
						　　<%-- jxgk_box --%><div class="loading_data"></div>
					</div>
				</div>
				<div class="right">
					<img src="images/main03_11.jpg" width="245" height="252" onclick="tReg()" style="cursor: hand;" />
				</div>

				<div class="zhinan">
					<div class="zhinantp"></div>
					<div class="zhinan1">
						<p>
							&nbsp;
						<p>
						<a href="#" onclick="return tSub('学车须知','湖南交通驾校首页>>学车咨询>>学车须知','','','','','xczx')" style="cursor: hand;">
							<br />
							　　现场报名
							<br />
							　　网上报名
							<br />
							　　学车常识
						</a>
						</p>
					</div>
					<div class="zhinan2">
						<p>
							&nbsp;
						<p>
						<a href="#" onclick="return tSub('考试要点','湖南交通驾校首页>>在线考试>>考试要点','','','','','zxks')" style="cursor: hand;">
							<br />
							　　考试须知
							<br />
							　　模拟考试
							<br />
							　　学车基本课程
							<br />
							　　考试项目介绍
						</a>
					</div>
					<div class="zhinan3">
						<p>
							&nbsp;
						</p>
						<p>
						<a href="#" onclick="return tSub('驾驶技巧','湖南交通驾校首页>>在线考试>>驾驶技巧','','','','','zxks')" style="cursor: hand;">
							<br />
							　　技能提升
							<br />
							　　驾驶知识
							<br />
							　　汽车及驾照年审
							<br />
							　　违章查询
						</a>
					</div>
					
					<div class="adgg">
							<img src="images/main03_27.jpg" width="670" height="102" onclick="return tSub('在线报名','湖南交通驾校首页>>网上报名>>在线报名','initzxbm','','','','wsbm')" style="cursor: hand;"/>
					</div>
				</div>
							
				<div class="news">
					<img src="images/main03_17.jpg" border="0" usemap="#Map" />
					<map name="Map" id="Map"><area shape="rect" coords="200,12,244,35" href="#" /></map>
					<div class="newsword" id="flow_xwzx">
						<%-- xwzx --%><div class="loading_data"></div>
					</div>
				</div>
			</div>
			
			<div id="contentpic">
				<div class="LC"></div>
				<div class="lcpic">
					<img src="images/main03_31.jpg" width="910px" onclick="return tSub('学车流程','湖南交通驾校首页>>学车咨询>>学车流程','','','','','xczx')" style="cursor: hand;"/>
				</div>
				
				<div class="cj"></div>

				<div class="cjpic">
					<div class="case" id="tp_box_2">
						 <%-- box2 --%><div class="loading_data"></div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			wz_setcf('${wz_title }','${wz_keywords }','${wz_description }','${wz_dbxx }','${wz_dz }');
			sTpbox('驾校概况','jxgk_box','jxgkbox');
			if($('zh'))
				$('zh').focus();
			sTpbox(1,'tp_box_1','tpbox');
			sTpbox(2,'tp_box_2','tpbox');
			sTpbox(2,'flow_xwzx','xwzxbox');
		 	wld();
		</script>
	</body>
</html>
