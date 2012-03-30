<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<body bgcolor="white">
		<div  style="width:910px; height:127px; margin-left:auto; margin-right:auto; background-image:url(${applicationScope.w_appAdd.w_appAdd }images/404head.jpg)">
		</div>
		<div  style="width:910px; height:auto;margin-left:auto; margin-right:auto; background-color:#FFFFFF; margin-top:20px;">
			<div  style="width:640px; height:200px;margin-left:auto; margin-right:auto;">
				<table style="border: 1px solid rgb(204, 204, 204);" align="center"
					border="0" cellpadding="10" cellspacing="0" height="200"
					width="100%">
					<tbody>
						<tr>
							<td align="right">
								<img src="${applicationScope.w_appAdd.w_appAdd }images/sorry01.gif" height="134" width="137" />
							</td>
							<td
								style="line-height: 150%; font-size: 14px; color: rgb(153, 0, 0);">
								对不起,您所查看的网页不存在,5秒后将自动返回首页!
								<br/>
							</td>
						</tr>
						<tr align="center">
							<td colspan="2">
								<a href="${applicationScope.w_appAdd.w_appAdd }"><img src="${applicationScope.w_appAdd.w_appAdd }images/sorry02.gif" border="0" height="24" hspace="10" width="140" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<script language='javascript'>setTimeout("{location.href='${applicationScope.w_appAdd.w_appAdd }'}",5000);</script>
	</body>
</html>
