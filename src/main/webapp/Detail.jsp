
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
		.wifi-value {
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
	</style>
	<script>
		
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
					<td class="wifi-value"><%= pubwifi.getDist()%></td>
				</tr>
				<tr>
					<th>관리번호</th>
					<td class="wifi-value" ><%= pubwifi.getMGR_NO()%></td>
				</tr>
				<tr>
					<th>자치구</th>
					<td class="wifi-value" ><%= pubwifi.getWRDOFC()%></td>
				</tr>	
				<tr>
					<th>와이파이명</th>
					<td class="wifi-value" ><a href="Detail.jsp?mgrNo=<%=pubwifi.getMGR_NO()%>&dist=<%=pubwifi.getDist()%>" class=""><%= pubwifi.getMAIN_NM()%></a></td>
				</tr>
				<tr>
					<th>도로명주소</th>
					<td class="wifi-value" ><%= pubwifi.getADDR1()%></td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td class="wifi-value" ><%= pubwifi.getADDR2()%></td>
				</tr>
				<tr>
					<th>설치위치(층)</th>
					<td class="wifi-value" ><%= pubwifi.getINSTL_FL()%></td>
				</tr>
				<tr>
					<th>설치유형</th>
					<td class="wifi-value" ><%= pubwifi.getINSTL_TY()%></td>
				</tr>
				<tr>
					<th>설치기관</th>
					<td class="wifi-value" ><%= pubwifi.getINSTL_MBY()%></td>
				</tr>
				<tr>
					<th>서비스구분</th>
					<td class="wifi-value" ><%= pubwifi.getSVC_SE()%></td>
				</tr>
				<tr>
					<th>망종류</th>
					<td class="wifi-value" ><%= pubwifi.getCMCWR()%></td>
				</tr>
				<tr>
					<th>설치년도</th>
					<td class="wifi-value" ><%= pubwifi.getCNSTC_Y()%></td>
				</tr>
				<tr>
					<th>실내외<br>구분</th>
					<td class="wifi-value" ><%= pubwifi.getINOUT_DOOR()%></td>
				</tr>
				<tr>
					<th>WIFI접속환경</th>
					<td class="wifi-value" ><%= pubwifi.getREMARS3()%></td>
				</tr>
				<tr>
					<th>X좌표</th>
					<td class="wifi-value" ><%= pubwifi.getLAT()%></td>
				</tr>
				<tr>
					<th>Y좌표</th>
					<td class="wifi-value" ><%= pubwifi.getLNT()%></td>
				</tr>
				<tr>
					<th>작업일자</th>
					<td class="wifi-value" ><%= pubwifi.getWORK_DTTM()%></td>        
				</tr>
			</tbody>
	</table>
</body>
</html>