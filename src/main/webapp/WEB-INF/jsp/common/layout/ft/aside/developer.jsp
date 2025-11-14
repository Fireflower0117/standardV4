<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>









<aside id="lnb">
	
		  
			
	    
    
</aside>



<script>


$(".box_depth1_"+depth1).show();
$("#li_depth2_"+depth2).addClass("on");
$("#li_depth3_"+depth3).addClass("on");


if($(".tab_uprMenuCd_"+depth4).length){
	$(".tab_uprMenuCd_"+depth4).show();
	$("#tab_box").show();
}else if($(".tab_uprMenuCd_"+depth3).length){
	$(".tab_uprMenuCd_"+depth3).show();
	$("#tab_box").show();
}else if($(".tab_uprMenuCd_"+depth2).length){
	$(".tab_uprMenuCd_"+depth2).show();
	$("#tab_box").show();
}
if($(".tab_menuCd_"+depth4).length){
	$(".tab_menuCd_"+depth4).addClass("on");
}else if($(".tab_menuCd_"+depth3).length){
	$(".tab_menuCd_"+depth3).addClass("on");
}else if($(".tab_menuCd_"+depth2).length){
	$(".tab_menuCd_"+depth3).addClass("on");
}

$(document).ready(function(){
	$(".tab_menu li a").on("click", function(){
		location.href= $(this).attr("href");
	})
}); 

</script>