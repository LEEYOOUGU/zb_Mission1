

<%@page import="java.util.List"%>
<%@page import="service.Hist"%>
<%@page import="service.HistService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위치 히스토리 목록</title>
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
        #HistTable{
            width: 100%;
            border-collapse: collapse;
        }
        #HistTableHead > th{
            border: 1px solid #ddd;
            padding: 8px;
        }
        #HistTableHead > tr{
            background-color: #04AA6D;
            color: white;

        }
        #HistTableBody > tr:nth-child(odd){background-color: #f2f2f2;}
        #HistTableBody > tr:hover {background-color: #808080;}
        #HistTableBody > tr:nth-child(odd):hover{background-color: #808080;}
        #HistTableBody > td{
            border: 1px solid #ddd;
            padding: 8px;
        }
    </style>
    <script>
        function deleteHist(HIST_NO){
            var url = "http://localhost:8080/Hist.jsp";
            var params = new URLSearchParams();
            params.append("HIST_NO", HIST_NO);
            url += "?" + params.toString();
            window.location.href = url;
        }
    </script>
</head>
<body>

<h1> 위치 히스토리 목록 </h1>
<div id = "HeaderMenu">
    <ul>
        <li><a href="Home.jsp" class="">홈</a></li>
        <li><a href="Hist.jsp" class="">위치 히스토리 목록</a></li>
        <li><a href="LoadWifi.jsp" class="">Open API 와이파이 정보 가져오기</a></li>
    </ul>
</div>
<table id = "HistTable">
    <thead id="HistTableHead">
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody id="HistTableBody">
    <%
        String histno = request.getParameter("HIST_NO");
        HistService histservice = new HistService();
        if(histno != null){
            histservice.deleteHist(histno);
        }
        List<Hist> HistList = histservice.selectHist();

        for(Hist hist: HistList){
    %>
    <tr>
        <td><%= hist.getHIST_NO()%></td>
        <td><%= hist.getLAT()%></td>
        <td><%= hist.getLNT()%></td>
        <td>
            <button class="delete-button" onclick='deleteHist("<%= hist.getHIST_NO()%>")'>삭제</button>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>