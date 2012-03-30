<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<html>
<head>
	<script type="text/javascript">
		mtsub=function(){
			$('rtdiv').innerHTML=$('zy_contentBody').innerHTML;
		}
		fccpdivhm=function(cp_dvhm){
			Element.update('rtdiv','<div id=loading_data class=loading_data></div>');
			$('dxslj').innerHTML='<img src=\"images/bullet_go.gif\" height=\"15\"/>'+$(cp_dvhm).innerHTML;
		}
		moLogin = function(flg)
		{
			new Ajax.Request('<c:url value="/web/login.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=logOut&flg='+flg,
	                	onSuccess: function(transport) {
	                		init_w_index(true);
	                	}
	        });
		}
		txtsz = function(cp_dvhm){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/xtsz_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=selectAction'
	        });
	        return false;
		}
		tjsgl = function(cp_dvhm){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/jsgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=jsGl'
	        });
	        return false;
		}
		tyhgl = function(cp_dvhm){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/yhgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=yhGl'
	        });
	        return false;
		}
		twzgl = function(cp_dvhm){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/wzgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=wzGl'
	        });
	        return false;
		}
		ttpgl = function(cp_dvhm){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/tpgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=tpGl'
	        });
	        return false;
		}
		tzxbm = function(cp_dvhm){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/zxbm_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true
	        });
	        return false;
		}
		tlygl = function(cp_dvhm){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/sub/lygl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true
	        });
	        return false;
		}
		tqxgl = function(){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/qxgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=qxGl'
	        });
	        return false;
		}
		tgrgl = function(cp_dvhm,cp_yhid){
			fccpdivhm(cp_dvhm);
			new Ajax.Updater('rtdiv','<c:url value="/manage/grgl_ajax.htm"/>', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=InitGrCzAction&yhid='+cp_yhid
	        });
	        return false;
		}
		getdcls =function(){
				init_sz('w_time_div');
				$('zbody').background='';
         		if($('wzgl_sub')){
			                new Ajax.Request('<c:url value="/manage/zxbm_ajax.htm"/>', 
			                {
			                	method:'post',
			                	asynchronous:true,
			                	evalScripts : true,
			                	parameters:'method=gDclNum',
			                	onSuccess: function(transport) {
				               		if(trim(transport.responseText).indexOf('fail')== -1)
				               		{
				               			if(trim(transport.responseText) != '0')
				               				{Element.update('dclxx',trim(transport.responseText)+'条[<a href="" onclick="return tzxbm(m_tzxbm);"><img src="images/letter.gif"/>在线报名</a>]信息待处理!<br/>');
				               				 $('tmpbgsd').src='images/msg.wav';
				               				}
				               			else
				               				Element.update('dclxx','');
				               		}
				               			
					    		}
			                }); 
	    		}
	            return false;
		 }
	</script>
</head>
	<body>
	<div class="main_manage" id="main_manage">
		  <div class="head"></div>
		  <div id="menu">
		  　<ul>
			    <li><a href="#" onclick="return init_w_index(true);">首页</a></li>
				<li>VIP特权</li>
				<li>会员活动</li>
		    </ul>
		  </div> 
	  
		<div class="where" >&nbsp;您现在的位置：<em class="tx" style="cursor: hand" onclick="iLogin()"><img src="images/bullet_go.gif" height="15"/>个人信息管理中心</em><em id="dxslj" class="tx"></em></div>
		<div class="boxleft" id="ltdiv">
			<div class="memberx">
				<div class="userhead">
					<img src="images/userhead.gif" width="65" height="72"/>
				</div>
				<div class="userxx">
					<img src="images/umhd.gif"/>姓名:<B>${sessionScope.usr.xm}</B><br />
					<img src="images/jb.gif"/>级别:<B>${sessionScope.usr.jsmc}</B><br />
				</div>
				<div class="member_info">
					上次登录:<em class="tx">${sessionScope.usr.zhdl}</em><br />
					<em class="err" id="dclxx"></em><input type="button" class="out_but" onclick="return moLogin('m');"/>
				</div>
			</div>
			<div class="member_xufei"><div id="w_time_div"></div></div>
			<div class="member_foot"></div>
			<!-- 左侧模块 -->
			<c:if test="${sessionScope.usr.mks != null}">
			<div class="left_bt_x">
				 <c:if test="${fn:indexOf(sessionScope.usr.mks,'$1$') != -1 }">
				 <div id="wzgl" >
				 	 <div  class="panelTitle" onclick="showhide('wzgl_sub')"></div>
				 	 <div id="wzgl_sub" class="verticalMenu">
				 	 	 <div style="background: url('images/Loading.png') center left no-repeat;"><p>网站管理</p></div>
				 	 	 <bgsound id="tmpbgsd" src="" loop="1">
				 	 	 <ul>
				 	 	 	<li id="m_txtsz"><a href="" onclick="return txtsz('m_txtsz');">系统设置</a></li>
				 	 		<li id="m_tjsgl"><a href="" onclick="return tjsgl('m_tjsgl');">角色管理</a></li>
				 	 		<li id="m_tyhgl"><a href="" onclick="return tyhgl('m_tyhgl');">用户管理</a></li>
				 	 		<li id="m_twzgl"><a href="" onclick="return twzgl('m_twzgl');">子页管理</a></li>
				 	 		<li id="m_ttpgl"><a href="" onclick="return ttpgl('m_ttpgl');">图片管理</a></li>
				 	 		<li id="m_tlygl"><a href="" onclick="return tlygl('m_tlygl');">留言管理</a></li>
				 	 		<li id="m_tzxbm"><a href="" onclick="return tzxbm('m_tzxbm');">在线报名</a></li>
					 	 </ul>
				 	 </div>
			 	 </div>
			 	 </c:if>
			 	 <c:if test="${fn:indexOf(sessionScope.usr.mks,'$2$') != -1 }">
				 <div id="grxx">
				 	 <h3  class="panelTitle" onclick="showhide('grxx_sub')"></h3>
				 	 <div id="grxx_sub" class="verticalMenu" >
				 	 	<div style="background: url('images/Profile.png') center left no-repeat;"><p>个人信息</p></div>
				 	 	<ul>
				 	 		<li id="m_tgrgl"><a href="" onclick="return tgrgl('m_tgrgl','${sessionScope.usr.zh }');">查看个人信息</a></li>
				 	 		<li><a href="#" >查看学员信息</a></li>
				 	 		<li><a href="#" >学员自助约考</a></li>
				 	 		<li><a href="#" >学员自助训练</a></li>
				 	 	</ul>
				 	 </div>
			 	 </div>
			 	 </c:if>
			 	 <c:if test="${fn:indexOf(sessionScope.usr.mks,'$3$') != -1 }">
				 <div id="clxx">
				 	 <h3  class="panelTitle" onclick="showhide('clxx_sub')"></h3>
				 	 <div  id="clxx_sub" class="verticalMenu" >
				 	 	<div style="background: url('images/Exit.png') center left no-repeat;"><p>车辆信息</p></div>
				 	 	<ul>
				 	 		<li><a href="#" >机动车违章查询</a></li>
				 	 		<li><a href="#" >驾驶人违章查询</a></li>
				 	 		<li><a href="#" >历史违章查询</a></li>
				 	 		<li><a href="#" >违章统计</a></li>
				 	 	</ul>
				 	 </div>
				 </div>
				 </c:if>
			</div>
		</div>
		<br/>
		<div class="boxright" style="background-color: white;" id="rtdiv">
			<c:if test="${fn:indexOf(sessionScope.usr.mks,'$4$') != -1 }">
				<h3  class="panelTitle2">VIP广告</h3>
				<div class="right_ad">
					<img src="images/memeber_10.jpg" width="680px" border="0" onclick="tSub('在线报名','湖南交通驾校首页>>网上报名>>在线报名','initzxbm','','rtdiv','mtsub();','wsbm');" style="cursor: hand;"/>
				</div>
				<div class="btn">
					<a href="#"><img src="images/memeber_20.jpg" border="0" />
					</a>
					<a href="#"><img src="images/memeber_22.jpg" border="0" />
					</a>
					<a href="#"><img src="images/memeber_24.jpg" border="0" />
					</a>
					<a href="#"><img src="images/memeber_26.jpg" border="0" />
					</a>
				</div>
			</c:if>
			<c:if test="${fn:indexOf(sessionScope.usr.mks,'$5$') != -1 }">
				<div class="info01">
						 <div class="panelTitle2">info1</div>
						 <div class="panelBody" style="height: 340px;">
						 	 x1
						 </div>
				</div>
			</c:if>
			<c:if test="${fn:indexOf(sessionScope.usr.mks,'$6$') != -1 }">
				<div class="info02">
						 <div class="panelTitle2">info2</div>
						 <div class="panelBody" style="height: 340px;">
						 	 x2
						 </div>
				</div>
			</c:if>
		</div>
		</c:if>
		<script type="text/javascript">
			getdcls();
			setMyAlertMsg('登录成功!',true);
		</script>
	 </div>
	 
	 <div class="foot">
	    <div class="copyright">${wz_dbxx}</div>
	  </div>	
	
	</body>
</html>
