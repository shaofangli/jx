<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<html>
	<body>
		<div class="www_zzjs_" id="focus_bigpic" onmouseover="clearAuto()"
			onmouseout="setAuto()">
			<c:if test="${tps != null}">
				<c:forEach var="mytp" items="${tps }">
					<c:if test="${mytp.dh < 6}">
						<a class="www_zzjs_-item"><img alt="${mytp.bt }"
								src="${mytp.nr }" width="665px" height="250px" />
						</a>
					</c:if>
				</c:forEach>
				<ul class="www_zzjs_-toggle" id="focus_tabsbg">
					<c:forEach var="mytpx" items="${tps }">
						<c:if test="${mytpx.dh < 6}">
							<c:choose>
								<c:when test="${mytpx.dh == 1 }">
									<li class="no${mytpx.dh }" id="selm">
										<a class="current"
											href="javascript:void(Mea(${mytpx.zz-1 }));">${mytpx.dh }</a>
									</li>
								</c:when>
								<c:otherwise>
									<li class="no${mytpx.dh }" id="selm">
										<a href="javascript:void(Mea(${mytpx.zz-1 }));">${mytpx.dh}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
				</ul>
			</c:if>
		</div>
	</body>
	<script type="text/javascript">
		setAuto();
	</script>
</html> 