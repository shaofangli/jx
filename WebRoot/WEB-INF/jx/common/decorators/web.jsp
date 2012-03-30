<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<html>
<head>
	<title></title>
	<meta name="keywords" content=""/>
	<meta name="description" content=""/>
	<link href="css/css.css" type="text/css" rel="stylesheet" />
 	<link href="css/reg.css" type="text/css" rel="stylesheet" />
 	<link href="css/manage.css" type="text/css" rel="stylesheet" />
 	<link href="css/table.css" type="text/css" rel="stylesheet" />
 	<script type="text/javascript" language="javascript" src="js/prototype.js"></script>
 	<script type="text/javascript" language="javascript" src="js/func.js"></script>
 	<script type="text/javascript" language="javascript" src="js/index.js"></script>
 	<script type="text/javascript" language="javascript" src="js/calendar/wpCalendar.js"></script>
 	<script type="text/javascript" language="javascript" src="js/calendar/gdCalendar.js"></script>
</head>
<body background="images/main02_01.jpg" id="zbody">
<div id="main" >
   
   <div id="header">
   	  <div class="topinfo" id="w_topinfo"></div>
      <div class="top">
      	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="1000" height="132">
          <param name="movie" value="images/logo.swf" />
		  <param name="wmode" value="transparent"/>
          <param name="quality" value="high" />
          <embed wmode="transparent" src="images/logo.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="1000" height="132"></embed>
        </object>
      </div>
	  
      <div id="index_menu">
        <!-- 导航主菜单 -->
        <ul>
          <li><a href="#" onclick="return init_w_index(true);">首　　页</a></li>
          <li><a href="#" onclick="return false;">驾校简介</a>
          	<ul id="dhcdmn_jxjj">
          		<li><a href="#" onclick="return tSub('驾校概况','湖南交通驾校首页>>驾校简介>>驾校概况','','','','','jxjj')" >驾校概况</a></li>
				<li><a href="#" onclick="return tSub('驾校文化','湖南交通驾校首页>>驾校简介>>驾校文化','','','','','jxjj')" >驾校文化</a></li>
				<li><a href="#" onclick="return tSub('驾校荣誉','湖南交通驾校首页>>驾校简介>>驾校荣誉','','','','','jxjj')" >驾校荣誉</a></li>
				<li><a href="#" onclick="return tSub('驾校分校','湖南交通驾校首页>>驾校简介>>驾校分校','','','','','jxjj')" >驾校分校</a></li>
				<li><a href="#" onclick="return tSub('师资力量','湖南交通驾校首页>>驾校简介>>师资力量','','','','','jxjj')" >师资力量</a></li>
          	</ul>
          </li>
          <li><a href="#" onclick="return false;">新闻中心</a>
          	<ul id="dhcdmn_xwzx">
          		<li><a href="#" onclick="return tSub('新闻聚焦','湖南交通驾校首页>>新闻中心>>新闻聚焦','','','','','xwzx')" >新闻聚焦</a></li>
				<li><a href="#" onclick="return tSub('行业新闻','湖南交通驾校首页>>新闻中心>>行业新闻','','','','','xwzx')" >行业新闻</a></li>
				<li><a href="#" onclick="return tSub('最新公告','湖南交通驾校首页>>新闻中心>>最新公告','','','','','xwzx')" >最新公告</a></li>
          	</ul>
          </li>
          <li><a href="#" onclick="return false;">学车咨询</a>
          	<ul id="dhcdmn_xczx">
          		<li><a href="#" onclick="return tSub('学车须知','湖南交通驾校首页>>学车咨询>>学车须知','','','','','xczx')" >学车须知</a></li>
				<li><a href="#" onclick="return tSub('学车流程','湖南交通驾校首页>>学车咨询>>学车流程','','','','','xczx')" >学车流程</a></li>
				<li><a href="#" onclick="return tSub('报名价格','湖南交通驾校首页>>学车咨询>>报名价格','','','','','xczx')" >报名价格</a></li>
				<li><a href="#" onclick="return tSub('班车路线','湖南交通驾校首页>>学车咨询>>班车路线','','','','','xczx')" >班车路线</a></li>
          	</ul>
          </li>
          <li><a href="#" onclick="return false;">网上报名</a>
          	<ul id="dhcdmn_wsbm">
          		<li><a href="#" onclick="return tSub('在线报名','湖南交通驾校首页>>网上报名>>在线报名','initzxbm','','','','wsbm')" >在线报名</a></li>
				<li><a href="#" onclick="return tSub('团购报名','湖南交通驾校首页>>网上报名>>团购报名','','','','','wsbm')" >团购报名</a></li>
          	</ul>
          </li>
          <li><a href="#" onclick="return false;">互动天地 </a>
          	<ul id="dhcdmn_hdtd">
          		<li><a href="#" onclick="return tSub('留言板','湖南交通驾校首页>>互动天地>>留言板','initlyb','','','','hdtd')" >留言板</a></li>
				<li><a href="#" onclick="return tSub('会员活动','湖南交通驾校首页>>互动天地>>会员活动','','','','','hdtd')" >会员活动</a></li>
          	</ul>
          </li>
          <li><a href="#" onclick="return false;">在线考试</a>
          	<ul id="dhcdmn_zxks">
          		<li><a href="#" onclick="return tSub('考试要点','湖南交通驾校首页>>在线考试>>考试要点','','','','','zxks')" >考试要点</a></li>
          		<li><a href="#" onclick="return tSub('驾驶技巧','湖南交通驾校首页>>在线考试>>驾驶技巧','','','','','zxks')" >驾驶技巧</a></li>
				<li><a href="#" onclick="return tSub('交通标志','湖南交通驾校首页>>在线考试>>交通标志','','','','','zxks')" >交通标志</a></li>
				<li><a href="#" onclick="return tSub('训考服务','湖南交通驾校首页>>在线考试>>训考服务','','','','','zxks')" >训考服务</a></li>
          	</ul>
          </li>
          <li><a href="#" onclick="return false;">违章查询</a>
          	<ul id="dhcdmn_wzcx">
          		<li><a href="#" onclick="return tSub('机动车违法','湖南交通驾校首页>>违章查询>>机动车违法','','','','','wzcx')" >机动车违法</a></li>
				<li><a href="#" onclick="return tSub('驾驶证违法','湖南交通驾校首页>>违章查询>>驾驶证违法','','','','','wzcx')" >驾驶证违法</a></li>
				<li><a href="#" onclick="return tSub('违法统计','湖南交通驾校首页>>违章查询>>违法统计','','','','','wzcx')" >违法统计</a></li>
				<li><a href="#" onclick="return tSub('代办车管业务','湖南交通驾校首页>>违章查询>>代办车管业务','','','','','wzcx')" >代办车管业务</a></li>
          	</ul>
          </li>
		  <li><a href="#" onclick="return false;">驾照直考</a>
		  	<ul id="dhcdmn_jzzk">
          		<li><a href="#" onclick="return tSub('直考动态','湖南交通驾校首页>>驾照直考>>直考动态','','','','','jzzk')" >直考动态</a></li>
				<li><a href="#" onclick="return tSub('直考流程','湖南交通驾校首页>>驾照直考>>直考流程','','','','','jzzk')" >直考流程</a></li>
          	</ul>
		  </li>
        </ul>
      </div>
   </div>


   <div id="contentBody" style="margin-left: 40px;">
		<decorator:head/>
	    <decorator:body/>
   </div>

   <div id="contentpic"> 
	 <div id="foot_div" class="foot">
	 	<ul id="dhcdmn_sydbdh">
	 		<li id="fsclsli"><a href="#" onclick="return tSub('关于我们','湖南交通驾校首页>>关于我们>>关于我们','','','','','sydbdh')" >关于我们</a></li><li id="sclsli">|</li>
	 		<li id="fsclsli"><a href="#" onclick="return tSub('友情链接','湖南交通驾校首页>>关于我们>>友情链接','','','','','sydbdh')" >友情链接</a></li><li id="sclsli">|</li>
	 		<li id="fsclsli"><a href="#" onclick="return tSub('诚聘英才','湖南交通驾校首页>>关于我们>>诚聘英才','','','','','sydbdh')" >诚聘英才</a></li><li id="sclsli">|</li>
	 		<li id="fsclsli"><a href="#" onclick="return tSub('在线咨询','湖南交通驾校首页>>关于我们>>在线咨询','','','','','sydbdh')" >在线咨询</a></li><li id="sclsli">|</li>
	 		<li id="fsclsli"><a href="#" onclick="return tSub('常见问题','湖南交通驾校首页>>关于我们>>常见问题','','','','','sydbdh')" >常见问题</a></li><li id="sclsli">|</li>
	 		<li id="fsclsli"><a href="#" onclick="return tSub('服务条款','湖南交通驾校首页>>关于我们>>服务条款','','','','','sydbdh')" >服务条款</a></li><li id="sclsli">|</li>
	 		<li id="fsclsli"><a href="#" onclick="return tSub('联系我们','湖南交通驾校首页>>关于我们>>联系我们','','','','','sydbdh')" >联系我们</a></li>
	 	</ul><br/><div id="wzBottomInfo"></div>
	 </div>
   </div>
</div>
</body>