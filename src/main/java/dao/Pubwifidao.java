package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import service.Pubwifi;


public class Pubwifidao {
    public void insert(List<Pubwifi> pubwifis) throws SQLException{
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
            conn.setAutoCommit(false);
            
            String sql = "INSERT INTO PUB_WIFI VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            int batchSize = 1000;
            int count = 0;
            preparedStatement = conn.prepareStatement(sql);
            for(Pubwifi pubwifi: pubwifis){
                preparedStatement.setString(1, pubwifi.getMGR_NO());
                preparedStatement.setString(2, pubwifi.getWRDOFC());
                preparedStatement.setString(3, pubwifi.getMAIN_NM());
                preparedStatement.setString(4, pubwifi.getADDR1());
                preparedStatement.setString(5, pubwifi.getADDR2());
                preparedStatement.setString(6, pubwifi.getINSTL_FL());
                preparedStatement.setString(7, pubwifi.getINSTL_TY());
                preparedStatement.setString(8, pubwifi.getINSTL_MBY());
                preparedStatement.setString(9, pubwifi.getSVC_SE());
                preparedStatement.setString(10, pubwifi.getCMCWR());
                preparedStatement.setString(11, pubwifi.getCNSTC_Y());
                preparedStatement.setString(12, pubwifi.getINOUT_DOOR());
                preparedStatement.setString(13, pubwifi.getREMARS3());
                preparedStatement.setString(14, pubwifi.getLAT());
                preparedStatement.setString(15, pubwifi.getLNT());
                preparedStatement.setString(16, pubwifi.getWORK_DTTM());
                preparedStatement.addBatch();
                if(++count % batchSize == 0){
                    preparedStatement.executeBatch();
                    conn.commit();
                }
            }
            if(count % batchSize == 0){
                    preparedStatement.executeBatch();
                    conn.commit();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            conn.rollback();
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


    public List<Pubwifi> selectList(String LAT, String LNT){
        List<Pubwifi> wifiList = new ArrayList<>();
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
            
            String sql = "select *, "+
                "ROUND( "+
                    "6371 * "+
                    "acos( "+
                        "cos(radians(?)) *"+
                        "cos(radians(LAT)) *"+
                        "cos(radians(LNT) -"+
                            "radians(?)) +"+
                        "sin(radians(?)) *"+
                        "sin(radians(LAT))"+
                        "), 4"+
                    ") AS distance "+
                    "FROM PUB_WIFI "+
                    "ORDER BY distance "+
                    "limit 20;";
                                
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, String.valueOf(LAT));
            preparedStatement.setString(2, String.valueOf(LNT));
            preparedStatement.setString(3, String.valueOf(LAT));
                        
            rs = preparedStatement.executeQuery();
            while(rs.next()){
                System.out.println(rs.getString("distance"));
                System.out.println(rs.getString("MGR_NO"));
                String dist = rs.getString("distance");
                String mgrNo = rs.getString("MGR_NO");
                String wrdofc = rs.getString("WRDOFC");
                String main_nm = rs.getString("MAIN_NM");
                String addr1 = rs.getString("ADDR1");
                String addr2 = rs.getString("ADDR2");
                String instl_fl = rs.getString("INSTL_FL");
                String instl_ty = rs.getString("INSTL_TY");
                String instl_mby = rs.getString("INSTL_MBY");
                String svc_se = rs.getString("SVC_SE");
                String cmcwr = rs.getString("CMCWR");
                String cnstc_y = rs.getString("CNSTC_Y");
                String inout_door = rs.getString("INOUT_DOOR");
                String remars3 = rs.getString("REMARS3");
                String lnt = rs.getString("LNT");
                String lat = rs.getString("LAT");
                String work_dttm = rs.getString("WORK_DTTM");

                Pubwifi pubwifi = new Pubwifi();
                pubwifi.setDist(dist);
                pubwifi.setMGR_NO(mgrNo);
                pubwifi.setWRDOFC(wrdofc);
                pubwifi.setMAIN_NM(main_nm);
                pubwifi.setADDR1(addr1);
                pubwifi.setADDR2(addr2);
                pubwifi.setINSTL_FL(instl_fl);
                pubwifi.setINSTL_TY(instl_ty);
                pubwifi.setINSTL_MBY(instl_mby);
                pubwifi.setSVC_SE(svc_se);
                pubwifi.setCMCWR(cmcwr);
                pubwifi.setCNSTC_Y(cnstc_y);
                pubwifi.setINOUT_DOOR(inout_door);
                pubwifi.setREMARS3(remars3);
                pubwifi.setLNT(lnt);
                pubwifi.setLAT(lat);
                pubwifi.setWORK_DTTM(work_dttm);
                wifiList.add(pubwifi);
               
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

        return wifiList;
    }
    public Pubwifi selectsinglewifi(String mgrNo,String dist){
        Pubwifi pubwifi = new Pubwifi();
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
            
            String sql = "SELECT * from "+
                            "PUB_WIFI "+ 
                        "where MGR_NO = ?;";
                            
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, mgrNo);           
            rs = preparedStatement.executeQuery();
            while(rs.next()){
                String wrdofc = rs.getString("WRDOFC");
                String main_nm = rs.getString("MAIN_NM");
                String addr1 = rs.getString("ADDR1");
                String addr2 = rs.getString("ADDR2");
                String instl_fl = rs.getString("INSTL_FL");
                String instl_ty = rs.getString("INSTL_TY");
                String instl_mby = rs.getString("INSTL_MBY");
                String svc_se = rs.getString("SVC_SE");
                String cmcwr = rs.getString("CMCWR");
                String cnstc_y = rs.getString("CNSTC_Y");
                String inout_door = rs.getString("INOUT_DOOR");
                String remars3 = rs.getString("REMARS3");
                String lnt = rs.getString("LNT");
                String lat = rs.getString("LAT");
                String work_dttm = rs.getString("WORK_DTTM");

                pubwifi.setDist(dist);
                pubwifi.setMGR_NO(mgrNo);
                pubwifi.setWRDOFC(wrdofc);
                pubwifi.setMAIN_NM(main_nm);
                pubwifi.setADDR1(addr1);
                pubwifi.setADDR2(addr2);
                pubwifi.setINSTL_FL(instl_fl);
                pubwifi.setINSTL_TY(instl_ty);
                pubwifi.setINSTL_MBY(instl_mby);
                pubwifi.setSVC_SE(svc_se);
                pubwifi.setCMCWR(cmcwr);
                pubwifi.setCNSTC_Y(cnstc_y);
                pubwifi.setINOUT_DOOR(inout_door);
                pubwifi.setREMARS3(remars3);
                pubwifi.setLNT(lnt);
                pubwifi.setLAT(lat);
                pubwifi.setWORK_DTTM(work_dttm);
               
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

        return pubwifi;
    }


    public void deleteAll(){
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
            
            String sql = "DELETE FROM PUB_WIFI";
            preparedStatement = conn.prepareStatement(sql);
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
