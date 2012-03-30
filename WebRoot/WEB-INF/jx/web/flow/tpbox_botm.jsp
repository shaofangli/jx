<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<html>
	<body>
		<div id="MyMarqueeX">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<c:if test="${tps != null}">
						<td id="MYMQ_1"><c:forEach var="mytpd" items="${tps }"><img alt="${mytpd.bt }" src="${mytpd.nr }" /></c:forEach></td>
						<td id="MYMQ_2"></td>
					</c:if>
				</tr>
			</table>
		</div>
	</body>
	<script type="text/javascript">
		statlop();
	</script>
</html>
