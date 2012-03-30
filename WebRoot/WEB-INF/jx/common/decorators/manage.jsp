<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<html>
<body>
	  <div class="main_manage">
		  <div class="head"></div>
		  <div id="menu">
		  　<ul>
			    <li><a href="">首页</a></li>
				<li>VIP特权</li>
				<li>会员活动</li>
		    </ul>
		  </div>
		  
		  <div id="contentBody">
			<decorator:head/>
		    <decorator:body/>
		  </div>
	  </div>
	  <div class="foot">
	    <div class="copyright">
		报名热线：0731-85313322　84514155　<br />
		驾校地址：长沙市韶山南路635号　湖南交通职业技术学院内 <br />
		Copyright 2010 www.00000.com All Right Reserved 湖南交通职业技术学院交通驾校版权所有	
		</div>
	  </div>
</body>