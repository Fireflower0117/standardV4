<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>




<div id="container">

				
				
<script>
var depthLi1 = "";
var depthLi2 = "";
var depthLi3 = "";
var depthLi4 = "";

var depthNm1 = "";
var depthNm2 = "";
var depthNm3 = "";
var depthNm4 = "";


if($(".tab_menuCd_"+depth4).length){
	depthLi4 = "<li class='last'>" + $(".tab_menuCd_"+depth4).data("menunm") + "</li>";
	depthNm4 = $(".tab_menuCd_"+depth4).data("menunm")
}

var lastCheck3 = depthLi4 == "" ? "last" : "";
if($("#li_depth3_" + depth3).length){ 
	depthLi3 = "<li class='" + lastCheck3 + "'>" + $("#li_depth3_" + depth3).data("menunm") + "</li>";
	depthNm3 = $("#li_depth3_" + depth3).data("menunm");
}else if($(".tab_menuCd_" + depth3).length){
	depthLi3 = "<li class='" + lastCheck3 + "'>" + $(".tab_menuCd_" + depth3).data("menunm") + "</li>";
	depthNm3 = $(".tab_menuCd_"+depth3).data("menunm");
}

var lastCheck2 = depthLi3 == "" ? "last" : "";
if($("#li_depth2_" + depth2).length){
	depthLi2 = "<li class='" + lastCheck2 + "'>" + $("#li_depth2_" + depth2).data("menunm") + "</li>";
	depthNm2 = $("#li_depth2_" + depth2).data("menunm");
}else if($(".tab_menuCd_" + depth2).length){
	depthLi2 = "<li class='" + lastCheck2 + "'>" + $(".tab_menuCd_" + depth2).data("menunm") + "</li>";
	depthNm2 = $(".tab_menuCd_"+depth2).data("menunm");
}

var lastCheck1 = depthLi2 == "" ? "last" : "";
if($("#li_depth1_" + depth1).length){
	depthLi1 = "<li class='" + lastCheck1 + "'>" + $("#li_depth1_" + depth1).data("menunm") + "</li>";
	depthNm1 = $("#li_depth1_" + depth1).data("menunm");
}

var liList = "<li class='home'><i class='xi-home'></i></li>";
liList += depthLi1 + depthLi2 + depthLi3 + depthLi4;
$(".breadcrumb").html(liList);


var pageTitle = depthNm4;
pageTitle = pageTitle == "" ? depthNm3 : pageTitle;
pageTitle = pageTitle == "" ? depthNm2 : pageTitle;
pageTitle = pageTitle == "" ? depthNm1 : pageTitle;
$(".page_title").html(pageTitle);


if(depth2 != null && depth2 != ""){
	$("#gnb").addClass("main_type");
}else{
	$("#gnb").addClass("sub_type");
}

$("#li_depth1_" + depth1).addClass("visible");


$("#li_depth2_" + depth2).addClass("active");
$("#li_depth2_" + depth2).addClass("open");


$("#li_depth3_" + depth3).addClass("on");


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