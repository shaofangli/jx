<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>

<html>
<head>
	<script type="text/javascript">
	     var sjreg = /^(13[0-9]{9})|(15[012356789][0-9]{8})|(18[0256789][0-9]{8})$/;
		 var xmreg = /^[\u4e00-\u9fa5]+$/;
	     isXm =function (strXm) {
			if(strXm.length ==0){
				return getTxMsg(-1,'未输入真实姓名！');
			}
			if(!xmreg.test(strXm)){
				return getTxMsg(-1,'真实姓名只能输入中文！');
			}
			isValdt = true;
			return getTxMsg(1,'真实姓名输入正确！');
		}
		isDh =function (strDh,target) {
			if(strDh.length ==0){
				return getTxMsg(-1,'未输入手机号码！');
			}
			if(!sjreg.test(strDh)){
				return getTxMsg(-1,'手机号码有误！');
			}
			isValdt = true;
			return getTxMsg(1,'联系方式输入正确！');
		}
		checkDate = function(date)
		{
		    return true;
		}
		isIdCardNo = function (num)
		{
		    var factorArr = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1);
		    var error;
		    var varArray = new Array();
		    var intValue;
		    var lngProduct = 0;
		    var intCheckDigit;
		    var intStrLen = num.length;
		    var idNumber = num;    
		    // initialize
		    if ((intStrLen != 15) && (intStrLen != 18)) {
		        //error = "输入身份证号码长度不对！";
		        //alert(error);
		        //frmAddUser.txtIDCard.focus();
		        return false;
		    }    
		    // check and set value
		    for(i=0;i<intStrLen;i++) {
		        varArray[i] = idNumber.charAt(i);
		        if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
		            //error = "错误的身份证号码！.";
		            //alert(error);
		            //frmAddUser.txtIDCard.focus();
		            return false;
		        } else if (i < 17) {
		            varArray[i] = varArray[i]*factorArr[i];
		        }
		    }
		    if (intStrLen == 18) {
		        //check date
		        var date8 = idNumber.substring(6,14);
		        if (checkDate(date8) == false) {
		            //error = "身份证中日期信息不正确！.";
		            //alert(error);
		            return false;
		        }        
		        // calculate the sum of the products
		        for(i=0;i<17;i++) {
		            lngProduct = lngProduct + varArray[i];
		        }        
		        // calculate the check digit
		        intCheckDigit = 12 - lngProduct % 11;
		        switch (intCheckDigit) {
		            case 10:
		                intCheckDigit = 'X';
		                break;
		            case 11:
		                intCheckDigit = 0;
		                break;
		            case 12:
		                intCheckDigit = 1;
		                break;
		        }        
		        // check last digit
		        if (varArray[17].toUpperCase() != intCheckDigit) {
		            //error = "身份证效验位错误!...正确为： " + intCheckDigit + ".";
		            //alert(error);
		            return false;
		        }
		    } 
		    else{        //length is 15
		        //check date
		        var date6 = idNumber.substring(6,12);
		        if (checkDate(date6) == false) {
		            //alert("身份证日期信息有误！.");
		            return false;
		        }
		    }
		    //alert ("Correct.");
		    return true;
		 }

		 rdCheckdIndex = function (ckobj){
		 	for(i=0;i<ckobj.length;i++){
		 		 if(ckobj[i].checked==true)
		 		 	return i;
		 	}
		 	return -1;
		 }
         valid_zxbmform = function (formids){
         	if(trim($(formids).xm.value).length ==0 ||  rdCheckdIndex($(formids).xb) == -1  || 
         	   trim($(formids).zjhm.value).length ==0 || trim($(formids).sjhm.value).length ==0){
         		myAlert('提示信息','必填信息不能有空!',true,formids);
         		return false;
         	}/**
         	if(trim($(formids).bz.value).length > 50){
         		myAlert('提示信息','备注信息过长!',true,formids);
         		return false;
         	}*/
         	if(!xmreg.test($(formids).xm.value)){
				myAlert('提示信息','姓名只能输入中文!',true,formids);
				return false;
			}
         	if(!sjreg.test($(formids).sjhm.value)){
				myAlert('提示信息','手机号码有误!',true,formids);
				return false;
			}
			if(!isIdCardNo($(formids).zjhm.value)){
				myAlert('提示信息','无效的证件号码',true,formids);
				return false;
			}
         	myAlert('提示信息','正在提交你的报名信息,请稍后...',false,formids);
         	new Ajax.Request('<c:url value="/manage/zxbm_ajax.htm"/>', 
	        {
	                	method:'post',
	                	asynchronous:true,
	                	evalScripts : true,
	                	parameters:'method=insertZxbm&'+Form.serialize(formids),
	                	onSuccess: function(transport) {
	                		setMyAlertMsg(transport.responseText,true);
	                		if(trim(transport.responseText).indexOf('成功')!= -1){
	                			Form.reset(formids);
	                			if($('wzgl_sub')){getdcls();}
	                		}
					    }
					    
	        });
         	return false;
         }
	</script>
</head>
<body>
   <div class="text_W" id="text_W_zxbm"> 
	 <div class="text_T">${ljbt }</div>
	 <div class="text_X"> </div>
   	 <div class="text_C">
   	 <table width="600px" cellpadding="0" cellspacing="0">
	   <tr>
	    	<td height="120"><img src="images/post_ad.jpg" width="600px" height="91" /></td>
	   </tr>
  	   <tr>
    	 <td width="600px">
	    	 <form name="zxbm_form" id="zxbm_form">
				姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名<em class="err">*</em>：
			  	<input type="text" name="xm" id="xm" class="w_inputtext" style="background-color: white;" /><br/>
			  	证件号码<em class="err">*</em>：
			   	<input type="text" name="zjhm" id="zjhm" class="w_inputtext" style="background-color: white;" maxlength="18" ><br/>
			   	手机号码<em class="err">*</em>：
			  	<input type="text" name="sjhm" id="sjhm" style="background-color: white;" class="w_inputtext" maxlength="11"><br/>
			  	性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别<em class="err">*</em>：
			  	<input type="radio" name="xb" value="1" class="rad" />
				男
				<input type="radio" name="xb" value="2" class="rad"/>
				女<br/>
				<input type="hidden" name="zjlx" value="1"/>
				<%-- 
				证件类型<em class="err">*</em>：
			 	<select name="zjlx" id="zjlx">
				    <option value="1">身份证</option>
				    <option value="2">学生证</option>
			    </select><br/>--%>
			    联系地址 ：
			  	<input type="text" name="lxdz" id="lxdz" class="w_inputtext" style="background-color: white;" maxlength="18">
				<br/>
				备注 ：<br>
			  	<textarea name="bz" id="bz" cols="50" rows="10" class="m_txtarea"></textarea>　　　　　　　　　　　　　
			  	<input type="button" class="tjbut" onclick="return valid_zxbmform('zxbm_form')"/>
			</form>
		 </td>
  		</tr>
	  </table>
      </div>
   </div>
</body>
</html>
