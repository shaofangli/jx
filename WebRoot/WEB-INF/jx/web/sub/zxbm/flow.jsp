<%@ page contentType="text/html;charset=UTF-8" language="java"
	session="true"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<html>
<head>
	<script type="text/javascript">
		var b_o_s_div ;
	    var b_o_tobj ;
	     	    
		show_hfk = function(s_div,tobj){
		
			if($('hfk_div_'+s_div).getStyle('display')=='none')
			{
				if(b_o_s_div && b_o_tobj)
					show_hfk(b_o_s_div,b_o_tobj);
					
				$('hfk_div_'+s_div).show();
				getYzm($('lyb-hf-form_'+s_div).vcode_img);
				tobj.innerHTML='隐藏';
				
				b_o_s_div = s_div;
				b_o_tobj = tobj;
			}else{
				$('hfk_div_'+s_div).hide();
				tobj.innerHTML='回复';
				
				b_o_s_div = null;
				b_o_tobj = null;
			}
		}
	</script>
</head>
<body>
	<table cellspacing="0" cellpadding="5" width="100%" align="center" border="0">
   	 <tbody>
        <tr>
          <td colspan="2"><table cellspacing="0" cellpadding="0" width="100%" border="0">
              <tbody>
                <tr>
                  <td nowrap="nowrap">
                  	页数：${pageInfo.current_page }/${pageInfo.all_pagecount },记录数: ${pageInfo.current_rowscount }/${pageInfo.all_rowscount }
                  </td>
                </tr>
              </tbody>
          </table></td>
        </tr>
        <c:if test="${pageInfo.attribute_param != null}">
	        <input type="hidden"  id="currpg" value="${pageInfo.current_page }">
			<input type="hidden"  id="backpg" value="${pageInfo.current_page-1 }">
			<input type="hidden"  id="nextpg" value="${pageInfo.current_page+1 }">
			<input type="hidden"  id="lastpg" value="${pageInfo.all_pagecount }">
	
        	<c:forEach var="ly_tmp" items="${pageInfo.attribute_param}">
        	 	<tr>
		          <td width="28">&nbsp;</td>
		          <td width="483"><b>${ly_tmp.xm }</b> 在 (${ly_tmp.lyrq }) 
		          </td>
		          <td align="right">
		          	<c:if test="${sessionScope.usr != null}">
		          		<em class="tx" style="cursor: hand" onclick="show_hfk('${ly_tmp.dh }',this);">回复</em>
		          		<c:if test="${sessionScope.usr.jsdh == 3}">
		          			<em class="err" style="cursor: hand" onclick="deletely('${ly_tmp.dh }',this);">删除</em>
		          		</c:if>
		          	</c:if>
		          </td>
		        </tr>
     			<tr>
       				<td>&nbsp;</td>
       				<td class="formatU">
        				${ly_tmp.lynr }<img src="${ly_tmp.bq }" /><br /><br />
        				<%-- 回复框 --%>
        				<div id="hfk_div_${ly_tmp.dh }" style="display: none;">
        					<form name="lyb-hf-form_${ly_tmp.dh }" id="lyb-hf-form_${ly_tmp.dh }">
					    	 	<input type="hidden" value="1" name="lx">
					    	 	<input type="hidden" value="0" name="sfnm">
					    	 	<input type="hidden" value="2" name="sfkj">
					    	 	<input type="hidden" value="${ly_tmp.dh }" name="pdh">
					    	 	
								<%-- 加载表情 --%>
								<c:forEach begin="1" end="16" var="bqitms">
							  		<img src="/jx/js/kindeditor/plugins/emoticons/${bqitms-1 }.gif"/>
							  		<c:choose>
								  		<c:when test="${bqitms == 1}">
								  			<input type="radio" checked="checked" name="bq" value="/jx/js/kindeditor/plugins/emoticons/${bqitms-1 }.gif"/>
								  		</c:when>
								  		<c:otherwise>
								  			<input type="radio" name="bq" value="/jx/js/kindeditor/plugins/emoticons/${bqitms-1 }.gif"/>
								  		</c:otherwise>
							  		</c:choose>
							  		<c:if test="${bqitms % 8 == 0}"><br/></c:if>
								</c:forEach>
								<textarea name="lyb_comments" id="lyb_comments" cols="50" rows="10" class="txtarea"></textarea>
								
								<c:choose>
									<c:when test="${sessionScope.usr == null}">
										<p>会员帐号：<em class="err">*</em>
									  		<input type="text" name="zh" id="zh" class="txt" />
										<p>密码：<em class="err">*</em>
									  		<input type="password" name="mm" id="mm" class="txt" />
									</c:when>
									<c:otherwise>
									  		<input type="hidden" name="zh" value="${sessionScope.usr.zh}"/>
									  		<input type="hidden" name="xm" value="${sessionScope.usr.xm}"/>
									</c:otherwise>
								</c:choose>
								
								<p>验 证 码：<em class="err">*</em>
								  <input type="text" name="yzm" id='yzm' class="txt" maxlength="4"/>
								  <img id="vcode_img" name='vcode_img' src="#" />
								  <a href="#" onclick="return getYzm($('lyb-hf-form_${ly_tmp.dh }').vcode_img);"><em class="tx">看不清楚，换一张</em></a>
								<p>
								  <input type="button" class="aplbut" value="回复" onclick="return valid_lybform('lyb-hf-form_${ly_tmp.dh }');"></p>
							 </form>
						</div>
						
        				<%-- 回复列表 --%>
        				<c:if test="${ly_tmp.hfs != null}">
        					<c:forEach var="hf_tmp" items="${ly_tmp.hfs}">
	        					<span class="STYLE12 STYLE15"> 
		            			<br /><hr width="50%" size="1" color="#CCCCCC"/>${hf_tmp.xm } 回复: <br />${hf_tmp.lynr }<img src="${hf_tmp.bq }"/>
		              			</span>
		              		</c:forEach>
        				</c:if>
             		</td>
     			</tr>
		        <tr>
		          <td colspan="3"><hr size="2" color="#CCCCCC" /></td>
		        </tr>
		    </c:forEach>
        </c:if>
        
   	 </tbody>
   </table>		 
</body>
</html>
