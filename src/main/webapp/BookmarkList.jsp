
<%@page import="java.util.List"%>
<%@page import="service.Bookmark"%>
<%@page import="service.BookmarkService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>북마크 목록</title>
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
        #BookmarkTable{
            width: 100%;

        }
        #BookmarkTabelHead > th{
            border: 1px solid #ddd;
            padding: 8px;
        }
        #BookmarkTableHead > tr{
            background-color: #04AA6D;
            color: white;

        }
        #BookmarkTableBody > tr:nth-child(odd){background-color: #f2f2f2;}
        #BookmarkTableBody > tr:hover {background-color: #808080;}
        #BookmarkTableBody > tr:nth-child(odd):hover{background-color: #808080;}
        #BookmarkTableBody > td{
            border: 1px solid #ddd;
            padding: 8px;
        }
    </style>
    <script>

    </script>
</head>
<body>

<h1> 북마크 목록 </h1>
<div id = "HeaderMenu">
    <ul>
        <li><a href="Home.jsp" class="">홈</a></li>
        <li><a href="Hist.jsp" class="">위치 히스토리 목록</a></li>
        <li><a href="LoadWifi.jsp" class="">Open API 와이파이 정보 가져오기</a></li>
        <li><a href="BookmarkList.jsp" class="">북마크 보기</a></li>
        <li><a href="BookmarkManage.jsp" class="">북마크 그룹 관리</a></li>
    </ul>
</div>


<table id = "BookmarkTable">
    <thead id="BookmarkTableHead">
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>와이파이명</th>
        <th>등록일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody id="BookmarkTableBody">
    <%

        String ID = request.getParameter("ID");
        String MGR_NO = request.getParameter("MGR_NO");

        String isDeleteString = request.getParameter("isDelete");
        boolean isDelete = Boolean.parseBoolean(isDeleteString);

        String isMGR_ADDString = request.getParameter("isMGR_ADD");
        boolean isMGR_ADD = Boolean.parseBoolean(isMGR_ADDString);

        BookmarkService bookmarkService = new BookmarkService();
        if(ID != null && isDelete){
            bookmarkService.deleteBookmark(ID);
        }
        if(ID != null && MGR_NO != null && isMGR_ADD){
            bookmarkService.addBookmarkMGR_NO(ID, MGR_NO);
        }


        List<Bookmark> bookmarkList = bookmarkService.selectBookmark();


        for(Bookmark bookmark: bookmarkList){
    %>
    <tr>
        <td><%= bookmark.getID()%></td>
        <td><%= bookmark.getBookMarkName()%></td>
        <td><a href="Detail.jsp?mgrNo=<%=bookmark.getMGR_NO()%>&dist=0"><%= (bookmark.getMAIN_NM() != null) ? bookmark.getMAIN_NM(): "" %></a></td>
        <td><%= bookmark.getRegisterDate()%></td>
        <td>
            <a href="BookmarkDelete.jsp?ID=<%= bookmark.getID() %>&bookMarkName=<%= bookmark.getBookMarkName() %><% if (bookmark.getMAIN_NM() != null) { %>&wifiname=<%= bookmark.getMAIN_NM() %><% } %>&register=<%= bookmark.getRegisterDate() %>&fromList=true">삭제</a>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>