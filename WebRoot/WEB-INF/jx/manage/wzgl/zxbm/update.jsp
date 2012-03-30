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
<input type="hidden" id="tp_nr" value="${up_tp.nr}" />
<input type="hidden" id="tp_dh" value="${up_tp.dh}" />
<input type="hidden" id="tp_bt" value="${up_tp.bt}" />
<input type="hidden" id="tp_sx" value="${up_tp.lxmc}" />
<c:choose>
	<c:when test="${pageInfo.exception != null }">
		<div class="errorMessageDetails">
		  ${pageInfo.exception }
		</div>
	</c:when>
	<c:otherwise>
		<iframe id="tpnr_ifrm" name="tpnr_ifrm" src="${up_tp.url}" width="100%" height="510px" 
				marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
	</c:otherwise>
</c:choose>
</body>
</html>