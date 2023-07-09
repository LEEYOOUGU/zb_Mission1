package service;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;
import java.net.HttpURLConnection;
import common.APIParam;
import dao.Pubwifidao;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class PubwifiService {
    public int getCount() throws IOException, ParseException {
        int total_Count = 0;
        BufferedReader rd;
        StringBuilder sb = new StringBuilder();
        String line;

        //URL 요청
        StringBuilder urlBuilder = new StringBuilder(APIParam.BASE_URL);
        urlBuilder.append("/"+URLEncoder.encode(APIParam.KEY, "UTF-8"));
        urlBuilder.append("/"+URLEncoder.encode(APIParam.TYPE, "UTF-8"));
        urlBuilder.append("/"+URLEncoder.encode(APIParam.SERVICE, "UTF-8"));
        urlBuilder.append("/"+URLEncoder.encode("1", "UTF-8"));
        urlBuilder.append("/"+URLEncoder.encode("5", "UTF-8"));
        
        String completeURL = urlBuilder.toString();
        URL reqURL = new URL(completeURL);
        HttpURLConnection conn = (HttpURLConnection) reqURL.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type","application/json");

        //요청결과
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }

        //결과 JSON 형삭으로 변환 및 꺼내기
        JSONObject result = (JSONObject) new JSONParser().parse(sb.toString());
        JSONObject data = (JSONObject) result.get("TbPublicWifiInfo");
        total_Count = Integer.parseInt(String.valueOf(data.get("list_total_count")));
        
        //연결 종료;
        rd.close();
        conn.disconnect();
        return total_Count;
    }
    public void insertData(){
        try {
            int total = getCount();
            BufferedReader rd;

            String line;
            int idx = 1;
            for(int i =0; i< total/1000+1;i++){
                StringBuilder urlBuilder = new StringBuilder(APIParam.BASE_URL);
                urlBuilder.append("/"+URLEncoder.encode(APIParam.KEY, "UTF-8"));
                urlBuilder.append("/"+URLEncoder.encode(APIParam.TYPE, "UTF-8"));
                urlBuilder.append("/"+URLEncoder.encode(APIParam.SERVICE, "UTF-8"));
                urlBuilder.append("/"+URLEncoder.encode(String.valueOf(idx), "UTF-8"));
                urlBuilder.append("/"+URLEncoder.encode(String.valueOf(idx+999), "UTF-8"));

                String completeURL = urlBuilder.toString();
                URL reqURL = new URL(completeURL);
                HttpURLConnection conn = (HttpURLConnection) reqURL.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-type","application/json");

                //요청결과
                if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                    rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                } else {
                    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
                }
                StringBuilder sb = new StringBuilder();
                while ((line = rd.readLine()) != null) {
                    sb.append(line);
                }


                JSONObject result = (JSONObject) new JSONParser().parse(sb.toString());
                JSONObject data = (JSONObject) result.get("TbPublicWifiInfo");
                JSONArray  array = (JSONArray) data.get("row");

                JSONObject temp;
                for(int j = 0; j<array.size();j++){
                    Pubwifi pubwifi = new Pubwifi();
                    temp = (JSONObject) array.get(j);
                    pubwifi.setMGR_NO(String.valueOf(temp.get("X_SWIFI_MGR_NO")));
                    pubwifi.setWRDOFC(String.valueOf(temp.get("X_SWIFI_WRDOFC")));
                    pubwifi.setMAIN_NM(String.valueOf(temp.get("X_SWIFI_MAIN_NM")));
                    pubwifi.setADDR1(String.valueOf(temp.get("X_SWIFI_ADRES1")));
                    pubwifi.setADDR2(String.valueOf(temp.get("X_SWIFI_ADRES2")));
                    pubwifi.setINSTL_FL(String.valueOf(temp.get("X_SWIFI_INSTL_FLOOR")));
                    pubwifi.setINSTL_TY(String.valueOf(temp.get("X_SWIFI_INSTL_TY")));
                    pubwifi.setINSTL_MBY(String.valueOf(temp.get("X_SWIFI_INSTL_MBY")));
                    pubwifi.setSVC_SE(String.valueOf(temp.get("X_SWIFI_SVC_SE")));
                    pubwifi.setCMCWR(String.valueOf(temp.get("X_SWIFI_CMCWR")));
                    pubwifi.setCNSTC_Y(String.valueOf(temp.get("X_SWIFI_CNSTC_YEAR")));
                    pubwifi.setINOUT_DOOR(String.valueOf(temp.get("X_SWIFI_INOUT_DOOR")));
                    pubwifi.setREMARS3(String.valueOf(temp.get("X_SWIFI_REMARS3")));
                    pubwifi.setLAT(String.valueOf(temp.get("LAT")));
                    pubwifi.setLNT(String.valueOf(temp.get("LNT")));
                    pubwifi.setWORK_DTTM(String.valueOf(temp.get("WORK_DTTM")));
                    
                    Pubwifidao pubdao = new Pubwifidao();
                    pubdao.insert(pubwifi);
                }
                rd.close();
                conn.disconnect();
                idx += 1000;
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Pubwifi> list(String LAT, String LNT){
        Pubwifidao pubdao = new Pubwifidao();
        return pubdao.selectList(LAT,LNT);

    }
    public Pubwifi singlewifi(String mgrNo, String dist){
        Pubwifidao pubdao = new Pubwifidao();
        return pubdao.selectsinglewifi(mgrNo, dist);

    }
    public void reset(){
       
        Pubwifidao pubdao = new Pubwifidao();
        pubdao.deleteAll();
    }



}
