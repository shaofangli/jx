<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>

<html>
<head>
	<script type="text/javascript">
		intzydiv=function(v1,v2){
			new Ajax.Request('/jx/sub/sub.htm', 
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=getsubnr&dh='+v1+'&subdh='+v2,
	                	onSuccess: function(transport) {
				               		$('zy_sdiv').innerHTML=transport.responseText;
				        }
	        });
		}
	</script>
</head>
<body>
   <div class="text_W"> 
	   <div class="text_T">${ljbt }</div>
	   <div class="text_X"> </div>
	   <div class="text_C" id="zy_sdiv"><div class="loading_data"></div></div>
   </div>
   <script type="text/javascript">
			intzydiv('${dh}','${subdh}');
   </script>
</body>
</html>