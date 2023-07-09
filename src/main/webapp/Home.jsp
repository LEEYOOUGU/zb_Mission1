
<%@page import="java.util.List"%>
<%@page import="service.PubwifiService"%>
<%@page import="service.Pubwifi"%>
<%@page import="service.Hist"%>
<%@page import="service.HistService"%>
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
		#WiFiTable{
			width: 100%;
			
		}
		#WifiTableHead > th{
			border: 1px solid #ddd;
  			padding: 8px;
		}
		#WifiTableHead > tr{
			background-color: #04AA6D;
			color: white;
			
		}
		#WifiTableBody > tr:nth-child(odd){background-color: #f2f2f2;}
		#WifiTableBody > tr:nth-child(odd):hover{background-color: #808080;}
		#WifiTableBody > tr:hover {background-color: #808080;}
		#WifiTableBody > td{
			border: 1px solid #ddd;
  			padding: 8px;
		}
	</style>
	<script>
		function getLocation() {
		  if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition, showError);
		  } else {
			alert("Geolocation is not supported by this browser.");
		  }
		}
	  
		function showPosition(position) {
		  var latitude = position.coords.latitude;
		  var longitude = position.coords.longitude;

		  document.getElementById("LAT").value = latitude;
		  document.getElementById("LNT").value = longitude;
		}
	  
		function showError(error) {
		  switch (error.code) {
			case error.PERMISSION_DENIED:
			  alert("User denied the request for Geolocation.");
			  break;
			case error.POSITION_UNAVAILABLE:
			  alert("Location information is unavailable.");
			  break;
			case error.TIMEOUT:
			  alert("The request to get user location timed out.");
			  break;
			case error.UNKNOWN_ERROR:
			  alert("An unknown error occurred.");
			  break;
		  }
		}
		function load20wifi(){
			
			var DefaultHide = document.getElementById("DefaultInfo");
			var ShowDiv =  document.getElementById("AfterCall");
			var lntValue = document.getElementById("LNT").value;
		  	var latValue = document.getElementById("LAT").value;
			if(lntValue != "" && latValue != ""){
				var url = "http://localhost:8080/Home.jsp";
				var params = new URLSearchParams();
				params.append("LAT", latValue);
				params.append("LNT", lntValue);
				url += "?" + params.toString();
				window.location.href = url;
			}
			else{
				alert("위치값이 없습니다");
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
	    </ul>
	</div>
	<div id = "InputMenu">
		<form method="get" action="/">
			<label>
				LAT: <input type ="text" placeholder="0.0" name = "LAT" id = "LAT">,  
			</label>
			<label>
				LNT: <input type ="text" placeholder = "0.0" name = "LNT" id="LNT" >
			</label>
			<button type = "button" onclick="getLocation()">
				내 위치 가져오기
			</button>
			<button type = "button" onclick="load20wifi()">
				근처 WIFI 정보 보기
			</button>
		</form>
		
	</div>
	<table id = "WiFiTable">
		<thead id="WifiTableHead">
			<tr>
				<th>거리<br>(Km)</th>
				<th>관리번호</th>
				<th>자치구</th>
				<th>와이파이명</th>
				<th>도로명주소</th>
				<th>상세주소</th>
				<th>설치위치<br>(층)</th>
				<th>설치유형</th>
				<th>설치기관</th>
				<th>서비스<br>구분</th>
				<th>망종류</th>
				<th>설치년도</th>
				<th>실내외<br>구분</th>
				<th>WIFI접속<br>환경</th>
				<th>X좌표</th>
				<th>Y좌표</th>
				<th>작업일자</th>
			</tr>
		</thead>
		<% 
    		String LAT = request.getParameter("LAT");
    		String LNT = request.getParameter("LNT");
    	%>
		<tbody id="WifiTableBody">
			<% if(LNT == null && LAT == null) {
			%>
				<tr id="DefaultInfo">
					<td colspan="17" scope="rowgroup" style = "text-align: center; padding: 10px 0;">
						위치 정보를 입력한 이후에 조회해 주세요.
					</td>
				</tr>
			<%
				}else{
					Hist hist = new Hist();
					hist.setLAT(LAT);
					hist.setLNT(LNT);
					HistService histservice = new HistService();
					histservice.insertHist(hist);


					PubwifiService pubwifiService = new PubwifiService();
        			List<Pubwifi> wifiList = pubwifiService.list(LAT, LNT);

				for(Pubwifi pubwifi: wifiList){
			%>
			<tr>
				<td><%= pubwifi.getDist()%></td>
				<td><%= pubwifi.getMGR_NO()%></td>
				<td><%= pubwifi.getWRDOFC()%></td>
				
				<td><a href="Detail.jsp?mgrNo=<%=pubwifi.getMGR_NO()%>&dist=<%=pubwifi.getDist()%>" class=""><%= pubwifi.getMAIN_NM()%></a></td>
				
				<td><%= pubwifi.getADDR1()%></td>
				<td><%= pubwifi.getADDR2()%></td>
				<td><%= pubwifi.getINSTL_FL()%></td>
				<td><%= pubwifi.getINSTL_TY()%></td>
				<td><%= pubwifi.getINSTL_MBY()%></td>
				<td><%= pubwifi.getSVC_SE()%></td>
				<td><%= pubwifi.getCMCWR()%></td>
				<td><%= pubwifi.getCNSTC_Y()%></td>
				<td><%= pubwifi.getINOUT_DOOR()%></td>
				<td><%= pubwifi.getREMARS3()%></td>
				<td><%= pubwifi.getLAT()%></td>
				<td><%= pubwifi.getLNT()%></td>
				<td><%= pubwifi.getWORK_DTTM()%></td>        
			</tr>
			<%
					}
				}
			%>
		</tbody>
	</table>
</body>
</html>