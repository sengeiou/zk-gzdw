<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>内容管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css"
	href="resources/js/jquery-easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="resources/js/jquery-easyui/themes/icon.css" />
<script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="resources/js/jquery.blockUI.js"></script>
<script type="text/javascript"
	src="resources/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="resources/js/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="resources/js/ajaxfileupload.js"></script>

<!-- <link href="resources/js/MyCalendar/images/all.css" rel="stylesheet" type="text/css" /> -->
<link href="resources/js/MyCalendar/images/skin.css" rel="stylesheet" type="text/css" />
<link href="resources/js/MyCalendar/images/fontSize12.css" rel="stylesheet" type="text/css" />
<link href="resources/js/MyCalendar/images/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="resources/js/MyCalendar/js/calendar.js"></script>

<style type="text/css">
table td {
	font-size: 14px;
}


th {
	height: 40px;
	position: relative;
	border: 1px solid #FFFFFF;
}

.week_day {
	background-color: #EEEEEE;
	cursor: pointer;
}

.week_day:hover {
	color: red;
	font-size: 16px;
	background-color: burlywood;
}

#content {
	display: none;
}
</style>
<script type="text/javascript">
	var days = "";
	$(function() {
		$("#content_table").datagrid({
			url : "personnel/getAll.do",
			idField : "id",
			split : false,
			fit : true,
			border : 0,
			toolbar : toolBar
		});
	});
	var row;
	var toolBar = [ {
		text : '排班',
		iconCls : 'icon-edit',
		handler : function() {
			var rows = $('#content_table').datagrid("getSelections");
			if (rows.length == 0) return;
			row = rows[0];
			$("#dialog_editData").dialog({
			    title: "当前排班：" + row.name + "(选择休息日)",
			});
			//获取已排班的日期加载到日历
			rebuild()
			mOck(null,null,row.onduty);
			$("#dialog_editData").dialog("open");
		}
	}, '-', {
		iconCls : 'icon-reload',
		handler : function() {
			$("#content_table").datagrid("reload");
		}
	}
	];
	
	//提交
	function h_submit() {
		
		if (hDays == "") {
			alert("没有选中任何日期！");
		} else {
			//alert(hDays);
			$("#dialog_editData").dialog("close");
		}
		$.ajax({
            type: "get",//数据发送的方式（post 或者 get）
            url: "personnel/onduty.do",//要发送的后台地址
            data: {hDays:hDays+"",id:row.id},//要发送的数据（参数）格式为{'val1':"1","val2":"2"}
            dataType: "text",//后台处理后返回的数据格式
            success: function (data) {//ajax请求成功后触发的方法
               alert('请求成功');
               $("#content_table").datagrid("reload");
            },
            error: function (msg) {//ajax请求失败后触发的方法
                //alert(msg+"");//弹出错误信息
            }
        });
	}
	//重置
	function rebuild() {
		$("#sucaijiayuan td").removeClass("selday").attr("on", 0);
		hDays = [];
	}



	function cz(value, row, index) {
		var cz = "";
		if (value == 1) {
			cz = "<p>男</p>";
		} else {
			cz = "<p>女</p>";
		}
		return cz;
	}
	function status(value, row, index) {
		var status = "";
		if (value == 1) {
			status = "<p>忙碌</p>";
		} else if (value == 2) {
			status = "<p>空闲</p>";
		} else if (value == 3) {
			status = "<p>暂离</p>";
		} else {
			status = "<p>休息</p>";
		}
		return status;
	}
	function imgFormatter(value,row,index){
   	if('' != value && null != value)
     	value = '<img style="width:60px; height:60px" src="'+ "<%=basePath%>" + value + '">';
     	return  value;
   	}
</script>
</head>

<body>
	<div class="easyui-layout" data-options="fit:true,border:0,split:false">
		<div data-options="region:'center',border:0,split:true"
			style="width:810px">
			<input type="hidden" id="currentNodeId" />
			<!-- <table id="content_table" title="当前资料夹：未指定"> -->
			<table id="content_table">
				<thead>
					<tr>
						<th align='center'
							data-options="field:'id',width:80,halign:'center'" hidden="true">id</th>
						<th align='center'
							data-options="field:'name',width:80,halign:'center'">姓名</th>
						<th align='center'
							data-options="field:'age',width:50,halign:'center'">年龄</th>
						<th align='center'
							data-options="field:'sex',width:50,halign:'center',formatter:cz">性别</th>
						<th align='center'
							data-options="field:'work',width:80,halign:'center'">职位</th>
						<th align='center'
							data-options="field:'watch_code',width:120,halign:'center'">android手表编号</th>
						<th align='center'
							data-options="field:'work_position',width:80,halign:'center'">所处岗位位置</th>
						<th align='center'
							data-options="field:'photo',width:80,halign:'center',formatter: imgFormatter">照片</th>
						<!-- <忙碌、空闲、暂离、休息> -->
						<th align='center'
							data-options="field:'work_status',width:80,halign:'center',formatter:status">工作状态</th>
						<th align='center'
							data-options="field:'work_time',width:120,halign:'center'">工作状态时长统计</th>
						<th align='center'
							data-options="field:'onduty',width:180,halign:'center'">休息日</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>





	<!---------------------------------------------------------------------------------------------------  -->
	<div id="dialog_editData" class="easyui-dialog" closed="true"
		title="选择日期" style="width:840px;height:520px">
		<div class="main">
			<div class="pathBar" style="margin-bottom:2px;">
				<div class="pathBarPos"></div>
			</div>
			<div id="myrl"
				style="width:800px; margin-left:auto; margin-right:auto; height:460px; overflow:hidden;">
				<form name=CLD>
					<TABLE class="biao" width="800px" id="sucaijiayuan">
						<TBODY>
							<TR>
								<TD class="calTit" colSpan=7
									style="height:30px;padding-top:3px;text-align:center;"><a
									href="#" title="上一年" id="nianjian" class="ymNaviBtn lsArrow"></a>
									<a href="#" title="上一月" id="yuejian" class="ymNaviBtn lArrow"></a>
									<div style="width:250px; float:left; padding-left:230px;">
										<span id="dateSelectionRili" class="dateSelectionRili"
											style="cursor:hand;color: white; border-bottom: 1px solid white;"
											onclick="dateSelection.show()"> <span id="nian"
											class="topDateFont"></span><span class="topDateFont">年</span><span
											id="yue" class="topDateFont"></span><span class="topDateFont">月</span>
											<span class="dateSelectionBtn cal_next"
											onclick="dateSelection.show()">▼</span></span> &nbsp;&nbsp;<font
											id=GZ class="topDateFont"></font>
									</div> <!--新加导航功能-->
									<div style="left: 250px; display: none;" id="dateSelectionDiv">
										<div id="dateSelectionHeader"></div>
										<div id="dateSelectionBody">
											<div id="yearList">
												<div id="yearListPrev"
													onclick="dateSelection.prevYearPage()">&lt;</div>
												<div id="yearListContent"></div>
												<div id="yearListNext"
													onclick="dateSelection.nextYearPage()">&gt;</div>
											</div>
											<div id="dateSeparator"></div>
											<div id="monthList">
												<div id="monthListContent">
													<span id="SM0" class="month"
														onclick="dateSelection.setMonth(0)">1</span> <span
														id="SM1" class="month" onclick="dateSelection.setMonth(1)">2</span>
													<span id="SM2" class="month"
														onclick="dateSelection.setMonth(2)">3</span> <span
														id="SM3" class="month" onclick="dateSelection.setMonth(3)">4</span>
													<span id="SM4" class="month"
														onclick="dateSelection.setMonth(4)">5</span> <span
														id="SM5" class="month" onclick="dateSelection.setMonth(5)">6</span>
													<span id="SM6" class="month"
														onclick="dateSelection.setMonth(6)">7</span> <span
														id="SM7" class="month" onclick="dateSelection.setMonth(7)">8</span>
													<span id="SM8" class="month"
														onclick="dateSelection.setMonth(8)">9</span> <span
														id="SM9" class="month" onclick="dateSelection.setMonth(9)">10</span>
													<span id="SM10" class="month"
														onclick="dateSelection.setMonth(10)">11</span> <span
														id="SM11" class="month curr"
														onclick="dateSelection.setMonth(11)">12</span>
												</div>
												<div style="clear:both;"></div>
											</div>
											<div id="dateSelectionBtn">
												<div id="dateSelectionTodayBtn"
													onclick="dateSelection.goToday()">今天</div>
												<div id="dateSelectionOkBtn" onclick="dateSelection.go()">确定</div>
												<div id="dateSelectionCancelBtn"
													onclick="dateSelection.hide()">取消</div>
											</div>
										</div>
										<div id="dateSelectionFooter"></div>
									</div> <a href="#" id="nianjia" title="下一年" class="ymNaviBtn rsArrow"
									style="float:right;"></a> <a href="#" id="yuejia" title="下一月"
									class="ymNaviBtn rArrow" style="float:right;"></a></TD>
							</TR>
							<TR class="calWeekTit"
								style="font-size:12px; height:20px;text-align:center;">
								<TD width="100" class="red">星期日</TD>
								<TD width="100">星期一</TD>
								<TD width="100">星期二</TD>
								<TD width="100">星期三</TD>
								<TD width="100">星期四</TD>
								<TD width="100">星期五</TD>
								<TD width="100" class="red">星期六</TD>
							</TR>
							<SCRIPT language="JavaScript">
								var gNum;
								for (var i = 0; i < 6; i++) {
									document.write('<tr align=center height="50" id="tt">');
									for (var j = 0; j < 7; j++) {
										gNum = i * 7 + j;
										document.write('<td  id="GD' + gNum + '" on="0" ><font  id="SD' + gNum + '" style="font-size:22px;"  face="Arial"');
										if (j == 0) document.write('color=red');
										if (j == 6)
											if (i % 2 == 1) document.write('color=red');
											else document.write('color=red');
										document.write('  TITLE="">  </font><br><font  id="LD' + gNum + '"  size=2  style="white-space:nowrap;overflow:hidden;cursor:default;">  </font></td>');
									}
									document.write('</tr>');
								}
							</SCRIPT>
						</tbody>
					</TABLE>
					<table class="biao" width="800px">
						<tr>
							<td><table width="100%" border="0" cellspacing="0"
									cellpadding="0">
									<tr align="center">
										<td><input type=button value="元旦节" class="button6"
											onclick=dateSelection.goHoliday(0)></td>
										<td><input type=button value='春  节' class="button6"
											onclick=dateSelection.goHoliday(1)></td>
										<td><input type=button value='清明节' class="button6"
											onclick=dateSelection.goHoliday(3)></td>
										<td><input type=button value='五一节' class="button6"
											onclick=dateSelection.goHoliday(4)></td>
										<td><input type=button value='端午节' class="button6"
											onclick=dateSelection.goHoliday(5)></td>
										<td><input type=button value='中秋节' class="button6"
											onclick=dateSelection.goHoliday(8)></td>
										<td><input type=button value="国庆节" class="button6"
											onclick=dateSelection.goHoliday(9)></td>
									</tr>
								</table></td>
						</tr>
					</table>
					</td>
					<td width="100%" align="center"><table border="1"
							cellpadding="5" cellspacing="5">
							<tr align="center">
								<td><input type="button" value="提交" class="button6"
									onclick="h_submit();"></td>
								<td><input type="button" value="重置" class="button6"
									onclick="rebuild();"></td>
								<td width="25" height="25" bgcolor="#FBBB67">&nbsp;</td>
								<td>休息日&nbsp;&nbsp;</td>
								<td width="25" bgcolor="#FFFFFF">&nbsp;</td>
								<td>工作日&nbsp;&nbsp;</td>
								<td width="25" bgcolor="#CFDFF0">&nbsp;</td>
								<td>今 日</td>
							</tr>
						</table></td>
					</tr>
					</table>
				</form>
			</div>
		</div>
		
		<div id="details" style="margin-top:-1px;"></div>
	</div>

</body>
</html>