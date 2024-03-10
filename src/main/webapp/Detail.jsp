
<%@page import="java.util.List"%>
<%@page import="service.PubwifiService"%>
<%@page import="service.Pubwifi"%>
<%@page import="service.Hist"%>
<%@page import="service.HistService"%>
<%@page import="service.Bookmark"%>
<%@page import="service.BookmarkService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>와이파이 정보 구하기</title>
	<style>

		#HeaderMenu>ul{
  			display:flex;
  			flex-flow: row nowrap;
  			padding: 30px;

		}
		#HeaderMenu>ul,li{
  			margin: 0;
  			padding: 0px;
  			list-style: none;
		}
		#HeaderMenu>ul>li::after{
  			content: "|";
  			float: right;
			padding: 2px;
  			display: block;
		}
		#BookmarkMenu>ul{
			display:flex;
			flex-flow: row nowrap;
			padding: 30px;

		}
		#BookmarkMenu>ul,li{
			margin: 0;
			padding: 0px;
			list-style: none;
		}
		#BookmarkMenu>ul>li::after{

			float: right;
			padding: 2px;
			display: block;
		}
		#WiFiTable{
			width: 100%;
			table-layout: fixed;
		}
		#WiFiTable > tbody>tr>th{
			width: 25%;
			background-color: #04AA6D;
			color: white;	
		}
		#WiFiTable > tbody>tr{
			display: table-row;
		}
		#WiFiTable tbody tr:nth-child(odd) td {
  			background-color: #f2f2f2;
			
		}
		#WiFiTable tbody tr:nth-child(odd) td:hover {
			background-color: #808080;
			
		}
		#WiFiTable > tbody>tr >td{
			width: 75%;
			border: 1px solid #ddd;
			padding: 3px;
			display: table-cell;
			vertical-align: middle;
			height: 30px;
		}

		.wifi-value:hover {
  			background-color: #808080;
		}
		select {
			margin-bottom: 2px;
			margin-top: 2px;
		}
	</style>
	<script>
		function AddMGR_NO(){
			var selectElement = document.getElementById("lang");
			var selectedOption = selectElement.options[selectElement.selectedIndex];
			var selectedBookmarkName = selectedOption.value;


			if(selectedBookmarkName !=""){
				var url = "http://localhost:8080/BookmarkList.jsp";
				var params = new URLSearchParams();
				var isMGR_ADD = true;
				var MGR_NO = document.getElementById("MGR_NO").textContent;
				var selectedBookmarkID= selectedOption.id;
				params.append("ID", selectedBookmarkID);
				params.append("MGR_NO", MGR_NO);
				params.append("isMGR_ADD", isMGR_ADD);
				url += "?" + params.toString();
				window.location.href = url;
				alert("완료");
			}
			else{
				alert("값을 선택해 주세요");
			}
		}
	</script>
</head>
<body>

	<h1> 와이파이 정보 구하기 </h1>
	<div id = "HeaderMenu">
	    <ul>
	        <li><a href="Home.jsp" class="">홈</a></li>
			<li><a href="Hist.jsp" class="">위치 히스토리 목록</a></li>
			<li><a href="LoadWifi.jsp" class="">Open API 와이파이 정보 가져오기</a></li>
			<li><a href="BookmarkList.jsp" class="">북마크 보기</a></li>
			<li><a href="BookmarkManage.jsp" class="">북마크 그룹 관리</a></li>
	    </ul>
	</div>
	<div id = "BookmarkMenu">
		<ul>
			<li>
				<form action="#">
						<select name="languages" id="lang">
							<option disabled selected hidden value="">북마크 그룹 이름 선택</option>
							<%
								BookmarkService bookmarkService = new BookmarkService();
								List<Bookmark> bookmarkList = bookmarkService.selectBookmark();
								for(Bookmark bookmark: bookmarkList){
							%>
							<option id ="<%=bookmark.getID()%>"><%=bookmark.getBookMarkName()%></option>
							<%
								}
							%>
						</select>
				</form>
			</li>
			<li><button type = "button" onclick="AddMGR_NO()">북마크 추가하기</button></li>
		</ul>
	</div>
	<% 
    	String mgrno = request.getParameter("mgrNo");
    	String dist = request.getParameter("dist");
		PubwifiService pubwifiService = new PubwifiService();
		Pubwifi pubwifi = pubwifiService.singlewifi(mgrno,dist);
    %>
	<table id = "WiFiTable">
			<tbody>
				<tr>
					<th>거리(Km)</th>
					<td><%= pubwifi.getDist()%></td>
				</tr>
				<tr>
					<th>관리번호</th>
					<td id = "MGR_NO"><%= pubwifi.getMGR_NO()%></td>
				</tr>
				<tr>
					<th>자치구</th>
					<td><%= pubwifi.getWRDOFC()%></td>
				</tr>	
				<tr>
					<th>와이파이명</th>
					<td><a href="Detail.jsp?mgrNo=<%=pubwifi.getMGR_NO()%>&dist=<%=pubwifi.getDist()%>" class=""><%= pubwifi.getMAIN_NM()%></a></td>
				</tr>
				<tr>
					<th>도로명주소</th>
					<td><%= pubwifi.getADDR1()%></td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td><%= pubwifi.getADDR2()%></td>
				</tr>
				<tr>
					<th>설치위치(층)</th>
					<td><%= pubwifi.getINSTL_FL()%></td>
				</tr>
				<tr>
					<th>설치유형</th>
					<td><%= pubwifi.getINSTL_TY()%></td>
				</tr>
				<tr>
					<th>설치기관</th>
					<td><%= pubwifi.getINSTL_MBY()%></td>
				</tr>
				<tr>
					<th>서비스구분</th>
					<td><%= pubwifi.getSVC_SE()%></td>
				</tr>
				<tr>
					<th>망종류</th>
					<td><%= pubwifi.getCMCWR()%></td>
				</tr>
				<tr>
					<th>설치년도</th>
					<td><%= pubwifi.getCNSTC_Y()%></td>
				</tr>
				<tr>
					<th>실내외<br>구분</th>
					<td><%= pubwifi.getINOUT_DOOR()%></td>
				</tr>
				<tr>
					<th>WIFI접속환경</th>
					<td><%= pubwifi.getREMARS3()%></td>
				</tr>
				<tr>
					<th>X좌표</th>
					<td><%= pubwifi.getLAT()%></td>
				</tr>
				<tr>
					<th>Y좌표</th>
					<td><%= pubwifi.getLNT()%></td>
				</tr>
				<tr>
					<th>작업일자</th>
					<td><%= pubwifi.getWORK_DTTM()%></td>
				</tr>
			</tbody>
	</table>
</body>
</html>