<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>

<html>
<head>
	<script type="text/javascript">
		setCkVl = function(bol,obj){
			if(bol)
				obj.value = 1;
			else
				obj.value = 0;
		}
	</script>
</head>
<body>
<p>
<input type="hidden" id="wz_nr" value="${up_wz.nr}" />
<input type="hidden" id="wz_dh" value="${up_wz.dh}" />
<input type="hidden" id="wz_bt" value="${up_wz.bt}" />
<c:choose>
	<c:when test="${pageInfo.exception != null }">
		<div class="errorMessageDetails">
		  ${pageInfo.exception }
		</div>
	</c:when>
	<c:otherwise>
		<iframe id="wznr_ifrm" name="wznr_ifrm" src="${up_wz.url}" width="100%" height="610px" 
				marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
	</c:otherwise>
</c:choose>
</body>
</html>