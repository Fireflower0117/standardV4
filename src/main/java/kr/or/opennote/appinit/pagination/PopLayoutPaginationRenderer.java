package kr.or.opennote.appinit.pagination;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class PopLayoutPaginationRenderer extends AbstractPaginationRenderer {
    public PopLayoutPaginationRenderer() {
    	this.firstPageLabel = "<li class=\"btn_page first\"><a href=\"javascript:void(0);\" onclick=\"{0}(''addList'',''resultPopDetailAddList.do'',{1}); return false;\" title=\"처음\"></a></li>";
        this.previousPageLabel = "<li class=\"btn_page prev\"><a href=\"javascript:void(0);\" onclick=\"{0}(''addList'',''resultPopDetailAddList.do'',{1}); return false;\" title=\"이전\"></a></li>";
        this.currentPageLabel = "<li class=\"current\"><a href=\"javascript:void(0);\">{0}</a></li>";
        this.otherPageLabel = "<li><a href=\"javascript:void(0);\" onclick=\"{0}(''addList'',''resultPopDetailAddList.do'',{1}); return false;\">{2}</a></li>";
        this.nextPageLabel = "<li class=\"btn_page next\"><a href=\"javascript:void(0);\" onclick=\"{0}(''addList'',''resultPopDetailAddList.do'',{1}); return false;\" title=\"다음\"></a></li>";
        this.lastPageLabel = "<li class=\"btn_page last\"><a href=\"javascript:void(0);\" onclick=\"{0}(''addList'',''resultPopDetailAddList.do'',{1}); return false;\" title=\"마지막\"></a></li>";
    }
}
