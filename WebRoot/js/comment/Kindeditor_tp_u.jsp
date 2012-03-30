<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<html>
<head>
	<link href="../../css/css.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" language="javascript" src="../prototype.js"></script>
	<script type="text/javascript" src="kindeditor-min.js"></script>
	<script type="text/javascript">
		var cz_tp_lx = window.parent.document.getElementById('lxdh').value;
		var tp_wd=0;
		var tp_gd=0;
		var tp_pt='';
		if(cz_tp_lx==1){
			tp_wd=665;
			tp_gd=250;
			tp_pt='top';
		}
		if(cz_tp_lx==2){
		 	tp_wd=185;
			tp_gd=125;
			tp_pt='bottom';
		}
		KE.show({
				id : 'nr',
				imageUploadJson : '../../upload/upload_json.jsp?zdy_w='+tp_wd+'&zdy_h='+tp_gd+'&zdy_tpth='+tp_pt,
				fileManagerJson : '../../upload/file_manager_json.jsp',
				allowFileManager : true,
				shadowMode : false,
				autoSetDataMode: false,
				allowPreviewEmoticons : false,
				filterMode : true,
				resizeMode : 0,
				urlType : 'absolute',
				items : ['image','cut','selectall'],
				htmlTags:{ img : ['src']},
				afterCreate : function(id) {
					KE.readonly(id);
					KE.g[id].newTextarea.disabled = true;
				}
			});
		updatetpcz = function(){
			KE.util.setData('nr');
			
			if(!$('bt').value || trim($('bt').value)==''){
				myAlert('提示信息','图片标题不能为空！',true,'u_tpnr_form');
				return false;
			}
			
			if(!$('content1').value){
				myAlert('提示信息','图片不能为空！',true,'u_tpnr_form');
				return false;
			}
			
			myAlert('提示信息','正在保存,请稍候...',false,'u_tpnr_form');
			new Ajax.Request('<c:url value="/manage/tpgl_ajax.htm"/>',
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=updateAction&'+Form.serialize('u_tpnr_form'),
	                	onSuccess: function(transport) {
	                		setMyAlertMsg(transport.responseText,true);
					}
					    
	        });
		}
	</script>
</head>
<body bgcolor="white">
	<div class="up_Container">
	<form id="u_tpnr_form" name="u_tpnr_form">
		<input type="hidden" id="dh" name="dh"/>
		标题：<input type="text" id="bt" name="bt"/> 
		<select id="sx" name="sx">
			<c:forEach begin="1" end="20" var="sx_tmp">
				 <option value="${sx_tmp }" id="sx_${sx_tmp }">第${sx_tmp }张</option>
			</c:forEach>
		</select>
		<textarea id="content1" name="nr" cols="100"  style="width:650px;height:510px;visibility:hidden;">
		</textarea>
		<input type="button" id="subbut" class="xgdbut"  onclick="updatetpcz()"/> (换行: Shift + Enter,换段: Enter)
	</form>
	</div>
	<script type="text/javascript">
		$('content1').value= window.parent.document.getElementById('tp_nr').value;
		$('dh').value= window.parent.document.getElementById('tp_dh').value;
		$('bt').value= window.parent.document.getElementById('tp_bt').value;
		$('sx_'+window.parent.document.getElementById('tp_sx').value).selected="selected";
	</script>
</body>
</html>
