package service;

import dao.Histdao;
import dao.Pubwifidao;

import java.util.List;

public class HistService {

    public void insertHist(Hist hist){
        Histdao histdao = new Histdao();
        histdao.insertHist(hist.getLAT(),hist.getLNT());
    }
    public List<Hist> selectHist(){
        Histdao histdao = new Histdao();
        return histdao.selectHist();
    }
    
    public void deleteHist(String hist_no){
        Histdao histdao = new Histdao();
        histdao.deleteHist(hist_no);
    }

}
