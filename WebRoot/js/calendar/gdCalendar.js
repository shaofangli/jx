var beforeYear 	= 1;		//日历显示的过去的年数
var afterYear 	= 1;		//日历显示的未来的年数 
var DaysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31,30, 31, 30, 31);
var ArrMonth = new Array("1", "2", "3","4", "5", "6", "7","8", "9","10","11", "12");
//var ArrMonthName = new Array("Jan", "Feb", "Mar","Apr", "May", "Jun", "Jul","Aug", "Sep","Oct","Nov", "Dec");
var ArrMonthName = new Array("01", "02", "03","04", "05", "06", "07","08", "09","10","11", "12");

var now = new Date();
var nowYear = now.getFullYear();
var nowMonth = now.getMonth()+1;
var nowDay = now.getDate();
var nowDate = nowYear + "-" + ((nowMonth < 10) ? ("0" + nowMonth) : nowMonth) + "-" + ((nowDay < 10) ? ("0" + nowDay) : nowDay);
var strCal = "";

/**
 * ������·�������
 */
function GetDaysInMonth(year,month){
	if (month == 2){
		return (((year % 4 == 0) && ((year % 100) != 0)) ||(year % 400 == 0)) ? 29 : 28;
	}else{
		return DaysInMonth[month-1];
	}
}
/**
 * ������select����
 */
function InitCalYear(){
	var ii = 0;
	var StarYear = nowYear + afterYear;
	var EndYear = nowYear - beforeYear;
	/**
	for(var i = StarYear;i >= EndYear;i--){
		$("CalYear").options[ii] = new Option(i,i);
		if ($("CalYear").options[ii].value == nowYear){
			$("CalYear").options[ii].selected = true;
		}
		ii++;
	}*/
	$("CalYear").value=nowYear;
}
/**
 * ����·�select����
 */
function InitCalMonth(){
	/**
	for(var i = 0;i < 12;i++){
		$("CalMonth").options[i] = new Option(ArrMonthName[i],ArrMonth[i]);
		if ($("CalMonth").options[i].value == nowMonth){
			$("CalMonth").options[i].selected = true;
		}
	}*/
	$("CalMonth").value=nowMonth;
	$("CalDayd").value=nowDay;
}

var oldclassname = new String();
function ButtonOver(id){
	//oldclassname = $(id).className;
	//$(id).className = "DayOver";
}

function ButtonOut(id){
	//$(id).className = oldclassname;
}

/**
 * �����ݴ�������
 */
function ChgYear(id){
	var Year = id.options[id.selectedIndex].value;
	var MonthIndex = $("CalMonth").selectedIndex;
	var Month = $("CalMonth").options[MonthIndex].value;
	InitCalendar(Year,Month);
}

function ChgMonth(id){
	var Month = id.options[id.selectedIndex].value;
	var YearIndex = $("CalYear").selectedIndex;
	var Year = $("CalYear").options[YearIndex].value;
	InitCalendar(Year,Month);
}
function getkjcd(ldt){
	l = 0;
	l = ldt;
	if(l<9)
		return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	else
		return "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
}
/**
 * ������¸���������
 */
function InitCalendar(Year,Month){
	if (!Year && !Month){
		Year = nowYear;
		Month = nowMonth;
	}

	var DayInMonth = GetDaysInMonth(Year,Month);
	var ThisMonthWeek = new Date(Year,parseInt(Month)-1,1);
	var Week = ThisMonthWeek.getDay();

	strCal = "周日&nbsp;周一&nbsp;周二&nbsp;周三&nbsp;周四&nbsp;周五&nbsp;周六&nbsp;&nbsp;<br/>";
	for(var i=0;i<Week;i++){
		strCal += "<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
	}

	var intWeek = i;
	for(var j=1;j<=DayInMonth;j++){
		var strDate = Year + "-" + ((Month < 10) ? ("0" + Month) : Month) + "-" + ((j < 10) ? ("0" + j) : j);
		if (strDate == nowDate){
			strCal += "<span id=\"day_" + intWeek + "_" + j + "\"><em class=\"err\">" + j +getkjcd(j)+"</em></span>";
		}else{
			strCal += "<span id=\"day_" + intWeek + "_" + j + "\"><em class=\"tx\">" + j +getkjcd(j)+ "</em></span>";
		}
		if (intWeek == 6){
			intWeek = 0;
			strCal += "<br/>";
		}else{
			intWeek++;
		}
	}

	for(k=intWeek;k<=6;k++){
		strCal += "<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>";
	}

	strCal += "<br/>";
	$('CalBody').innerHTML = strCal;
}

