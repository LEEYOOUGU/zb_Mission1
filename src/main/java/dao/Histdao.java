package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import service.Hist;
import service.Pubwifi;

public class Histdao {
    public void insertHist(String LAT, String LNT){
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
            
            String sql =  "insert into HIST (LAT, LNT,SRCH_DTTM) VALUES (?,?,now());";
            preparedStatement = conn.prepareStatement(sql);

            preparedStatement.setString(1, LAT);
            preparedStatement.setString(2, LNT);

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
    public List<Hist> selectHist(){
        List<Hist> HistList = new ArrayList<>();
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
            
            String sql = "select * from HIST;";       
            preparedStatement = conn.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
            while(rs.next()){

                String hist_no = rs.getString("HIST_NO");
                String lat = rs.getString("LAT");
                String lnt = rs.getString("LNT");
                String srch_dttm = rs.getString("SRCH_DTTM");
                
                Hist hist = new Hist();

                hist.setHIST_NO(hist_no);
                hist.setLAT(lat);
                hist.setLNT(lnt);
                hist.setSCRH_DATE(srch_dttm);
                HistList.add(hist);
               
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


        return HistList;
    }
    public void deleteHist(String HIST_NO){
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
            
            String sql =  "delete from HIST " + 
                            "where HIST_NO = ?;";
            preparedStatement = conn.prepareStatement(sql);

            preparedStatement.setString(1, HIST_NO);
           

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
}
