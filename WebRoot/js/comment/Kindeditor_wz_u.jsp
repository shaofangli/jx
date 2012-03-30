<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<html>
<head>
	<link href="../../css/css.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" language="javascript" src="../prototype.js"></script>
	<script type="text/javascript" src="kindeditor-min.js"></script>
	<script type="text/javascript">
		KE.show({
				id : 'nr',
				imageUploadJson : '../../upload/upload_json.jsp?zdy_tpth=other&zdy_w=0&zdy_h=0',
				fileManagerJson : '../../upload/file_manager_json.jsp',
				allowFileManager : true,
				shadowMode : false,
				autoSetDataMode: false,
				allowPreviewEmoticons : false,
				filterMode : true,
				resizeMode : 0,
				urlType : 'absolute'
			});
		updatewzcz = function(){
			KE.util.setData('nr');
			
			if(!$('bt').value || trim($('bt').value)==''){
				myAlert('提示信息','标题不能为空！',true,'u_wznr_form');
				return false;
			}
			
			if(!$('content1').value){
				myAlert('提示信息','文章内容不能为空！',true,'u_wznr_form');
				return false;
			}
			
			myAlert('提示信息','正在保存,请稍候...',false,'u_wznr_form');
			new Ajax.Request('<c:url value="/manage/wzgl_ajax.htm"/>',
	                {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=updateAction&'+Form.serialize('u_wznr_form'),
	                	onSuccess: function(transport) {
	                		setMyAlertMsg(transport.responseText,true);
					}
					    
	        });
		}
	</script>
</head>
<body bgcolor="white">
	<div class="up_Container">
	<form id="u_wznr_form" name="u_wznr_form">
		<input type="hidden" id="dh" name="dh"/>
		标题：<input type="text" id="bt" name="bt"/>
		<textarea id="content1" name="nr" cols="100"  style="width:650px;height:510px;visibility:hidden;">
		</textarea>
		<input type="button" id="subbut" class="xgdbut" onclick="updatewzcz()"/> (换行: Shift + Enter,换段: Enter)
	</form>
	</div>
	<script type="text/javascript">
		$('content1').value= window.parent.document.getElementById('wz_nr').value;
		$('dh').value= window.parent.document.getElementById('wz_dh').value;
		$('bt').value= window.parent.document.getElementById('wz_bt').value;
	</script>
</body>
</html>
