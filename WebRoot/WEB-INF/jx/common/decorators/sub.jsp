<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<html>
<script type="text/javascript">
	init_tsubmenuuls=function(t_mid){
		if(!$('main_manage') && $(t_mid)){
			var xd = $(t_mid).innerHTML;
			for(i=0;i<6;i++){xd = xd.replace('<LI id=sclsli>| </LI>',' ');}
			$('tmp_uls').innerHTML=xd;
		}
	}
</script>
<body>
   <!--    子页内容        -->
   <div class="ziyead"></div>
   
   <div class="zy_c"> 
   <div class="left_one">
   
      <div class="left_top"> 
	      <div class="leftmenu_t"> ${subbt }</div>
	        <div class="leftmenu"> 
	          <div class="left_m"> 
			    <ul id="tmp_uls">
			    </ul>
		      </div>           
	        </div>
	     </div>
  		 <script type="text/javascript">init_tsubmenuuls('dhcdmn_${submenuid}');</script>

	  	<div class="left_btt"><img src="images/ziye_TS.gif" /></div>
		<div class="left_btc">
		　　当您不方便电话联系或我们的报名热线正忙时您可以采用驾校“<em class="tx" style="cursor: hand;text-decoration: underline" onclick="return tSub('在线报名','湖南交通驾校首页>>网上报名>>在线报名','initzxbm','','','','wsbm')">网上报名</em>”系统，提交您的学车信息，我们的客服人员会在第一时间为您解决报名事宜。<br>
		交通驾校报名点：<br>
　　长沙市雨花区韶山南路635号。<br>
乘车路线：<br>
　　7路、101路到上海城路口下车即可。<br>
　　报名热线：0731-12345678<br>
　　传真电话：0731-12345678<br>
　　QQ：413123123<br>
		</div>
    
     
    
	 	<div class="left_btt"><img src="images/ziye_yh.gif" /></div>
		<div class="left_btc"><img src="images/pic_main_02.gif" align="left"/>
		凡通过电话报名或网上报名的学员，可以享受价值278元VIP礼品一份：<br>
　　1、优惠卡。<br>
　　2、学车指南一份。<br>
　　3、消费卡。<br>
		</div>
    
     
   </div>
  
   <div id="zy_contentBody">
		<decorator:head/>
	    <decorator:body/>
   </div>
   
   </div>  
</body>