package service;
import common.APIParam;
import java.util.*;

public class Bookmark {
    private String ID;
    private String bookMarkName;
    private String bookMarkOrder;
    private String registerDate;

    public String getMAIN_NM() {
        return MAIN_NM;
    }



    public void setMAIN_NM(String MAIN_NM) {
        this.MAIN_NM = MAIN_NM;
    }

    private String MAIN_NM;
    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public String getBookMarkName() {
        return bookMarkName;
    }

    public void setBookMarkName(String bookMarkName) {
        this.bookMarkName = bookMarkName;
    }

    public String getBookMarkOrder() {
        return bookMarkOrder;
    }

    public void setBookMarkOrder(String bookMarkOrder) {
        this.bookMarkOrder = bookMarkOrder;
    }

    public String getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(String registerDate) {
        this.registerDate = registerDate;
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate;
    }

    public String getMGR_NO() {
        return MGR_NO;
    }

    public void setMGR_NO(String MGR_NO) {
        this.MGR_NO = MGR_NO;
    }

    private String updateDate;
    private String MGR_NO;

}
