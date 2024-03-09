package dao;
import java.awt.print.Book;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import service.Bookmark;
import service.Hist;

public class Bookmarkdao {
    public void insertBookmark(String bookmarkName, String bookmarkOrder, String MGR_NO){
        String url = "jdbc:mariadb://localhost/Mission1";
        String dbUserId = "testuser1";
        String dbPassword = "zerobase";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            conn = DriverManager.getConnection(url,dbUserId,dbPassword);

            String sql =  "insert into HIST (bookmarkName,bookmarkOrder,registerDate,updateDate,MGR_NO) VALUES (?,?,now(),null,?);";
            preparedStatement = conn.prepareStatement(sql);

            preparedStatement.setString(1, bookmarkName);
            preparedStatement.setString(2, bookmarkOrder);
            preparedStatement.setString(3, MGR_NO);

            int affected = preparedStatement.executeUpdate();
            if(affected >0){
                System.out.println("성공");

            }
            else{
                System.out.println("실패");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(preparedStatement!= null && !preparedStatement.isClosed()){
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(conn != null && !conn.isClosed()){
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
    public void updateBookmark(String ID, String bookmarkName, String bookmarkOrder){
        String url = "jdbc:mariadb://localhost/Mission1";
        String dbUserId = "testuser1";
        String dbPassword = "zerobase";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            conn = DriverManager.getConnection(url,dbUserId,dbPassword);

            String sql =  "UPDATE BOOKMARK " +
                    "SET bookmarkName = ?, bookmarkOrder = ?, updatedate = now() " +
                    "WHERE ID = ?";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, bookmarkName);
            preparedStatement.setString(2, bookmarkOrder);
            preparedStatement.setString(3, ID);

            int affected = preparedStatement.executeUpdate();
            if(affected >0){
                System.out.println("성공");

            }
            else{
                System.out.println("실패");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(preparedStatement!= null && !preparedStatement.isClosed()){
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(conn != null && !conn.isClosed()){
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }
    public void deleteBookmark(String ID){
        String url = "jdbc:mariadb://localhost/Mission1";
        String dbUserId = "testuser1";
        String dbPassword = "zerobase";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            conn = DriverManager.getConnection(url,dbUserId,dbPassword);

            String sql =  "delete from BOOKMARK " +
                    "where ID = ?;";
            preparedStatement = conn.prepareStatement(sql);

            preparedStatement.setString(1, ID);

            int affected = preparedStatement.executeUpdate();
            if(affected >0){
                System.out.println("성공");

            }
            else{
                System.out.println("실패");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(preparedStatement!= null && !preparedStatement.isClosed()){
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(conn != null && !conn.isClosed()){
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

        public List<Bookmark> selectBookmark(){
        List<Bookmark> BookmarkList = new ArrayList<>();
        String url = "jdbc:mariadb://localhost/Mission1";
        String dbUserId = "testuser1";
        String dbPassword = "zerobase";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection(url,dbUserId,dbPassword);

            String sql =
                    "SELECT bm.ID, bm.bookmarkName, bm.bookmarkOrder, bm.registerDate, bm.updateDate, bm.MGR_NO, pw.MAIN_NM \n" +
                    "FROM BOOKMARK as bm\n" +
                    "LEFT JOIN PUB_WIFI as pw on bm.MGR_NO = pw.MGR_NO ;";
            preparedStatement = conn.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
            while(rs.next()){

                String ID = rs.getString("ID");
                String bookmarkName = rs.getString("bookmarkName");
                String bookmarkOrder = rs.getString("bookOrder");
                String registerDate = rs.getString("registerDate");
                String updateDate = rs.getString("updateDate");
                String MGR_NO = rs.getString("MGR_NO");
                String MAIN_NM = rs.getString("MAIN_NM");

                Bookmark bookmark = new Bookmark();

                bookmark.setID(ID);
                bookmark.setBookMarkName(bookmarkName);
                bookmark.setBookMarkOrder(bookmarkOrder);
                bookmark.setRegisterDate(registerDate);
                bookmark.setUpdateDate(updateDate);
                bookmark.setMGR_NO(MGR_NO);
                bookmark.setMAIN_NM(MAIN_NM);
                BookmarkList.add(bookmark);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(preparedStatement!= null && !preparedStatement.isClosed()){
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(conn != null && !conn.isClosed()){
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }


        return BookmarkList;
    }


}
