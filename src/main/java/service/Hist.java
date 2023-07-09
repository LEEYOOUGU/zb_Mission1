package service;
import common.APIParam;
import java.util.*;

public class Hist {
    private String LAT;
    private String LNT;

    private String HIST_NO;

    public String getLAT() {
        return LAT;
    }

    public void setLAT(String LAT) {
        this.LAT = LAT;
    }

    public String getLNT() {
        return LNT;
    }

    public void setLNT(String LNT) {
        this.LNT = LNT;
    }

    public String getHIST_NO() {
        return HIST_NO;
    }

    public void setHIST_NO(String HIST_NO) {
        this.HIST_NO = HIST_NO;
    }

    public String getSCRH_DATE() {
        return SCRH_DATE;
    }

    public void setSCRH_DATE(String SCRH_DATE) {
        this.SCRH_DATE = SCRH_DATE;
    }

    private String SCRH_DATE;

}
