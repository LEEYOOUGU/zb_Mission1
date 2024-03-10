package service;
import dao.Bookmarkdao;
import dao.Pubwifidao;
import java.util.List;
public class BookmarkService {
    public void insertBookmark(String bookmarkName, String bookmarkOrder){
        Bookmarkdao bookmarkdao = new Bookmarkdao();
        bookmarkdao.insertBookmark(bookmarkName, bookmarkOrder);
    }
    public List<Bookmark> selectBookmark (){
        Bookmarkdao bookmarkdao = new Bookmarkdao();
        return bookmarkdao.selectBookmark();
    }
    public void addBookmarkMGR_NO(String ID, String MGR_NO){
        Bookmarkdao bookmarkdao = new Bookmarkdao();
        bookmarkdao.addBookmarkMGR_NO(ID, MGR_NO);
    }

    public void updatetBookmark(String ID, String bookmarkName, String bookmarkOrder){
        Bookmarkdao bookmarkdao = new Bookmarkdao();
        bookmarkdao.updateBookmark(ID, bookmarkName, bookmarkOrder);
    }

    public void deleteBookmark(String ID){
        Bookmarkdao bookmarkdao = new Bookmarkdao();
        bookmarkdao.deleteBookmark(ID);
    }

}
