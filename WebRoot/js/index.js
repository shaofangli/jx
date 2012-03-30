function isMatch(str1,str2){
	var index = str1.indexOf(str2);
	if(index==-1) return false;
	return true;
}
/****************************图片切换*************************/
var n;
var showsTab ;
var m ;
var autoStart;
function Mea(value){
    n=value;
    setBg(value);
    plays(value);
}
//tb
function setBg(value){
    for(var i=0;i<m;i++){
    	if(value==i){
    		if($('focus_bigpic'))
        	showsTab.getElementsByTagName("li")[i].childNodes[0].className='current';
        }
	    else{
	    	if($('focus_bigpic'))
	        showsTab.getElementsByTagName("li")[i].childNodes[0].className='';
	    }
	}
}
//pic
function plays(value){
    	var d =document.getElementById("focus_bigpic").getElementsByTagName("a");
        for(var i=0;i<m;i++){
        	i==value?d[i].style.display="block":d[i].style.display="none";
        }
}
function clearAuto(){clearInterval(autoStart);}

function setAuto(){
	clearInterval(autoStart);
	n=0;
	showsTab = document.getElementById("focus_tabsbg");
	m=showsTab.getElementsByTagName("li").length;
	autoStart=setInterval("auto(n)", 3000);
}
function auto(){
	if(!$('focus_bigpic') && autoStart)
		{clearAuto();return;}
    n++;
    if(n>=m)n=0;
    Mea(n);
}
/****************************菜单导航**************************/
function menuFix() {
	var sfEls = document.getElementById("index_menu").getElementsByTagName("li");
	for (var i=0; i<sfEls.length; i++) {
		sfEls[i].onmouseover=function() {
			this.className+=(this.className.length>0? " ": "") + "sfhover";
		}
		sfEls[i].onMouseDown=function() {
			this.className+=(this.className.length>0? " ": "") + "sfhover";
		}
		sfEls[i].onMouseUp=function() {
			this.className+=(this.className.length>0? " ": "") + "sfhover";
		}
		sfEls[i].onmouseout=function() {
			this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"),"");
		}
	}
}
/****************************走马灯****************************/ 
function statlop(){
	$('MYMQ_2').innerHTML=$('MYMQ_1').innerHTML;
	function Marquee(){
		if(!$('MYMQ_2') && MyMar)
			{clearInterval(MyMar);return ;}
		
		if(($('MYMQ_2').offsetWidth-$('MyMarqueeX').scrollLeft) <= 0){
			$('MyMarqueeX').scrollLeft-=$('MYMQ_1').offsetWidth;
		}
		else{
			$('MyMarqueeX').scrollLeft++;
		}
	}
	var MyMar=setInterval(Marquee,1);
	$('MyMarqueeX').onmouseover=function() {clearInterval(MyMar)}
	$('MyMarqueeX').onmouseout=function() {MyMar=setInterval(Marquee,1)}
}
/********************************************************/
regEvent =function(){
	  var inputs=document.all.tags('input');
	  for(var i=0;i<inputs.length;i++){
	  	if(inputs[i].type== 'text'){
	  		inputs[i].onfocus= function(){
	  			this.className='inp ipt-focus';
	  		}
	  		inputs[i].onblur= function(){
	  			this.className='inp ipt-normal';
	  		}
	  	}
  	}
}
getYzm = function(yzobj){
			yzobj.src='js/imgcode/image.jsp?t='+(new Date().getTime());
			return false;
}
var tm_inter;
var bl_tm;
init_sz=function(s_div){
	if($(s_div))
	{
		if(!bl_tm)
		  {tm_inter=setInterval(s_div+".innerHTML=new Date().toLocaleString();",1000);bl_tm=true;}
	}
	else
		{clearInterval(tm_inter);bl_tm=false;}
}
/*********************************************************/
add_fv= function(sURL, sTitle)
{
    try
    {
        window.external.AddFavorite(sURL, sTitle);
    }
    catch (e)
    {
        try
        {
            window.sidebar.addPanel(sTitle, sURL, "");
        }
        catch (e)
        {
            alert("请按下Ctrl+D!");
        }
    }
}
set_hm= function(obj,vrl){
        try{
                obj.style.behavior='url(#default#homepage)';obj.setHomePage(vrl);
        }
        catch(e){
                if(window.netscape) {
                        try {
                                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
                        }
                        catch (e) {
                                alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将 [signed.applets.codebase_principal_support]的值设置为'true',双击即可。");
                        }
                        var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
                        prefs.setCharPref('browser.startup.homepage',vrl);
                 }
        }
}
tSub = function(v1,v2,v3,v4,v5,v6,v7)
		{
				var tag_div = 'main_content';
				var submtdvl = '';
				var subpgdh = '';
				var func6 = '';
				var idinner7 = '';
				
				if(v7 && v7!= '')
					idinner7= '&t_submenuid='+v7;
					
				if(v6 && v6!= '')
					func6= v6;
				
				if(v5 && v5!= '')
					tag_div= v5;
				if(v3 && v3!= '')
					submtdvl = '&method='+v3;
					
				if(v4 && v4!= '')
					subpgdh = '&subdh='+v4;
				else
					subpgdh = '&subdh=-1';
					
				new Ajax.Updater(tag_div,'/jx/sub/sub.htm', 
				                {
				                	method:'post',
				                	asynchronous:true,
				                	evalScripts : true,
				                	parameters:'dh='+v1+'&path='+v2+submtdvl+subpgdh+idinner7,
				                	onComplete:function(){eval(v6);}
				        });
				return false;
}
showhide = function(s_div){
			$(s_div).style.display =='none'?Element.show(s_div):Element.hide(s_div);
}

init_w_index=function(bol){
	if($('header') && $('foot_div'))
	{
		if(bol)
		{Element.show('header');Element.show('foot_div');$('zbody').background='/jx/images/main02_01.jpg';}
		else
		{Element.hide('header');Element.hide('foot_div');}
	}
		
	new Ajax.Updater('main_div','/jx/web/main.htm', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true
	});
	return false;
}
/********************************************************/
function wld(){
	init_sz('w_time_div');
	menuFix();//首页导航
	if($('s_flscj')){
	InitCalYear();InitCalMonth();InitCalendar();}
}