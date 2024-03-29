

<%@page import="java.util.List"%>
<%@page import="service.Hist"%>
<%@page import="service.HistService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 삭제</title>
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
        #BookmarkUpdateTable{
            width: 100%;
            table-layout: fixed;
        }
        #BookmarkUpdateTable > tbody>tr>th{
            width: 15%;
            background-color: #04AA6D;
            color: white;
        }
        #BookmarkUpdateTable > tbody>tr{
            display: table-row;
        }
        #BookmarkUpdateTable tbody tr:nth-child(odd) td {
            background-color: #f2f2f2;

        }
        .BookmarkUpdate_value {
            width: 85%;
            border: 1px solid #ddd;
            padding: 3px;
            display: table-cell;
            vertical-align: middle;
            height: 30px;
        }
        .lastTd {
            width: 100%;
            border: 1px solid #ddd;
            padding: 3px;
            background-color: white;
            text-align: center;
            vertical-align: middle;
            height: 30px;
            display: table-cell;
        }

    </style>
    <script>
        function DeleteBookMark(){
            var params = new URLSearchParams(window.location.search);
            var ID = params.get("ID");
            var fromManage = params.get("fromManage");
            var isDelete = true
            var url = (fromManage == "true") ? "http://localhost:8080/BookmarkManage.jsp" : "http://localhost:8080/BookmarkList.jsp"
            params = new URLSearchParams();
            params.append("ID", ID);
            params.append("isDelete",isDelete);
            url += "?" + params.toString();
            alert("성공");
            window.location.href = url;
        }
        function ReturnBookmark(){
            var params = new URLSearchParams(window.location.search);
            var fromManage = params.get("fromManage");
            params = new URLSearchParams();
            var url = (fromManage == "true") ? "http://localhost:8080/BookmarkManage.jsp" : "http://localhost:8080/BookmarkList.jsp"
            window.location.href = url;
        }
    </script>
</head>
<body>

<h1> 북마크 삭제 </h1>
<div id = "HeaderMenu">
    <ul>
        <li><a href="Home.jsp" class="">홈</a></li>
        <li><a href="Hist.jsp" class="">위치 히스토리 목록</a></li>
        <li><a href="LoadWifi.jsp" class="">Open API 와이파이 정보 가져오기</a></li>
        <li><a href="BookmarkList.jsp" class="">북마크 보기</a></li>
        <li><a href="BookmarkManage.jsp" class="">북마크 그룹 관리</a></li>
    </ul>
</div>
<span><br>북마크를 삭제하시겠습니까?</span>
<table id = "BookmarkUpdateTable">
    <tbody>
    <tr>
        <th>북마크이름</th>
        <td><%= request.getParameter("bookMarkName") %></td>
    </tr>
    <tr>
        <th>와이파이명</th>
        <td><%= request.getParameter("wifiname") != null ? request.getParameter("wifiname") : "" %></td>
    </tr>
    <tr>
        <th>등록일자</th>
        <td><%= request.getParameter("register") %></td>
    </tr>
    <td class="lastTd" colspan="2"><span style="cursor: pointer; color: blue; text-decoration: underline;" onclick="ReturnBookmark()">돌아가기</span> | <button type = "button" onclick="DeleteBookMark()">삭제</button></td>
    </tbody>
</table>
</body>
</html>