package kr.or.opennote.appinit.pagination;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class CustomPaginationRenderer extends AbstractPaginationRenderer {
    public CustomPaginationRenderer() {
        this.firstPageLabel = "<a href=\"javascript:void(0);\" class=\"btn_page first\" onclick=\"{0}({1}); return false;\" title=\"처음\"></a>";
        this.previousPageLabel = "<a href=\"javascript:void(0);\" class=\"btn_page prev\" onclick=\"{0}({1}); return false;\" title=\"이전\"></a>";
        this.currentPageLabel = "<a href=\"javascript:void(0);\" class=\"current\">{0}</a>";
        this.otherPageLabel = "<a href=\"javascript:void(0);\" onclick=\"{0}({1}); return false;\">{2}</a>";
        this.nextPageLabel = "<a href=\"javascript:void(0);\" class=\"btn_page next\" onclick=\"{0}({1}); return false;\" title=\"다음\"></a>";
        this.lastPageLabel = "<a href=\"javascript:void(0);\" class=\"btn_page last\" onclick=\"{0}({1}); return false;\" title=\"마지막\"></a>";
    }
}
