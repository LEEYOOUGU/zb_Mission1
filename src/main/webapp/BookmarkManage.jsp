
<%@page import="java.util.List"%>
<%@page import="service.Bookmark"%>
<%@page import="service.BookmarkService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 </title>
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
        #BookmarkManageTable{
            width: 100%;

        }
        #BookmarkManageTableHead > th{
            border: 1px solid #ddd;
            padding: 8px;
        }
        #BookmarkManageTableHead > tr{
            background-color: #04AA6D;
            color: white;

        }
        #BookmarkManageTableBody > tr:nth-child(odd){background-color: #f2f2f2;}
        #BookmarkManageTableBody > tr:hover {background-color: #808080;}
        #BookmarkManageTableBody > tr:nth-child(odd):hover{background-color: #808080;}
        #BookmarkManageTableBody > td{
            border: 1px solid #ddd;
            padding: 8px;
        }
    </style>
    <script>

    </script>
</head>
<body>

<h1> 북마크 그룹 </h1>
<div id ="HeaderMenu">
    <ul>
        <li><a href="Home.jsp" class="">홈</a></li>
        <li><a href="Hist.jsp" class="">위치 히스토리 목록</a></li>
        <li><a href="LoadWifi.jsp" class="">Open API 와이파이 정보 가져오기</a></li>
        <li><a href="BookmarkList.jsp" class="">북마크 보기</a></li>
        <li><a href="BookmarkManage.jsp" class="">북마크 그룹 관리</a></li>
    </ul>
</div>
<table id = "BookmarkManageTable">
    <thead id="BookmarkManageTableHead">
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>순서</th>
        <th>등록일자</th>
        <th>수정일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <button type = "button" onclick="window.location.href='http://localhost:8080/BookmarkInsert.jsp'">
        북마크 그룹 이름 추가
    </button>
    <tbody id="BookmarkManageTableBody">
    <%
        String ID = request.getParameter("ID");

        String bookmarkName = request.getParameter("bookmarkName");
        String bookmarkOrder = request.getParameter("bookmarkOrder");


        String isUpdateString = request.getParameter("isUpdate");
        boolean isUpdate = Boolean.parseBoolean(isUpdateString);

        String isInsertString = request.getParameter("isInsert");
        boolean isInsert = Boolean.parseBoolean(isInsertString);

        String isDeleteString = request.getParameter("isDelete");
        boolean isDelete = Boolean.parseBoolean(isDeleteString);

        BookmarkService bookmarkService = new BookmarkService();

        if(ID != null && bookmarkName != null && bookmarkOrder != null && isUpdate){
            bookmarkService.updatetBookmark(ID, bookmarkName,bookmarkOrder);
        }

        if(bookmarkName != null && bookmarkOrder != null && isInsert){
            bookmarkService.insertBookmark(bookmarkName,bookmarkOrder);
        }

        if(ID != null && isDelete){
            bookmarkService.deleteBookmark(ID);
        }

        List<Bookmark> bookmarkList = bookmarkService.selectBookmark();
        for(Bookmark bookmark: bookmarkList){
    %>
    <tr>
        <td><%= bookmark.getID()%></td>
        <td><%= bookmark.getBookMarkName()%></td>
        <td><%= bookmark.getBookMarkOrder()%></td>
        <td><%= bookmark.getRegisterDate()%></td>
        <td><%= (bookmark.getUpdateDate() != null) ? bookmark.getUpdateDate() : "" %></td>
        <td>
            <a href="BookmarkUpdate.jsp?ID=<%=bookmark.getID()%>">수정</a>
            <a href="BookmarkDelete.jsp?ID=<%= bookmark.getID() %>&bookMarkName=<%= bookmark.getBookMarkName() %><% if (bookmark.getMAIN_NM() != null) { %>&wifiname=<%= bookmark.getMAIN_NM() %><% } %>&register=<%= bookmark.getRegisterDate() %>&fromManage=true">삭제</a>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
