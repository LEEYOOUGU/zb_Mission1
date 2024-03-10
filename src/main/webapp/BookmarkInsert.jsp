

<%@page import="java.util.List"%>
<%@page import="service.Hist"%>
<%@page import="service.HistService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 그룹 수정</title>
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
        #BookmarkInsertTable{
            width: 100%;
            table-layout: fixed;
        }
        #BookmarkInsertTable > tbody>tr>th{
            width: 15%;
            background-color: #04AA6D;
            color: white;
        }
        #BookmarkInsertTable > tbody>tr{
            display: table-row;
        }
        #BookmarkInsertTable tbody tr:nth-child(odd) td {
            background-color: #f2f2f2;

        }
        .BookmarkInsert_value {
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
        function updateBookMark(){

            var url = "http://localhost:8080/BookmarkManage.jsp";
            var params = new URLSearchParams();
            var bookmarkName =  document.getElementById("bookmarkName").value;
            var bookmarkOrder =  document.getElementById("bookmarkOrder").value;
            var isInsert = true;
            if(bookmarkName != "" && bookmarkOrder != ""){
                params.append("bookmarkName", bookmarkName);
                params.append("bookmarkOrder", bookmarkOrder);
                params.append("isInsert",isInsert);
                url += "?" + params.toString();
                alert("성공");
                window.location.href = url;
            }
            else{
                alert("다시 입력해주세요");
            }

        }
    </script>
</head>
<body>

<h1> 북마크 그룹 추가 </h1>
<div id = "HeaderMenu">
    <ul>
        <li><a href="Home.jsp" class="">홈</a></li>
        <li><a href="Hist.jsp" class="">위치 히스토리 목록</a></li>
        <li><a href="LoadWifi.jsp" class="">Open API 와이파이 정보 가져오기</a></li>
        <li><a href="BookmarkList.jsp" class="">북마크 보기</a></li>
        <li><a href="BookmarkManage.jsp" class="">북마크 그룹 관리</a></li>
    </ul>
</div>
<table id = "BookmarkInsertTable">
    <tbody>
    <tr>
        <th>북마크이름</th>
        <td class="BookmarkInsert_value"><input type ="text" placeholder="" id = "bookmarkName"></td>
    </tr>
    <tr>
        <th>순서</th>
        <td class="BookmarkInsert_value"><input type ="text" placeholder="" id="bookmarkOrder" ></td>
    </tr>
    <td class="lastTd" colspan="2"><button type = "button" onclick="updateBookMark()">추가</button></td>
    </tbody>
</table>
</body>
</html>