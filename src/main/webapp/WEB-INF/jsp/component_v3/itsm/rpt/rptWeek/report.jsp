<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("nbr", "\n"); %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
<META NAME="Generator" CONTENT="Haansoft HWP 8.0.0.466">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<script
	src="${pageContext.request.contextPath}/component/itsm/js/jquery-1.11.3.min.js"></script>
<script
	src="${pageContext.request.contextPath}/component/itsm/js/jquery-ui-1.12.1.custom.js"></script>
<script src="${pageContext.request.contextPath}/component/itsm/js/htmlFile.js"></script>
<script type="text/javascript">
function htmlToFile() {
    
    <%-- 보고서 내용 가져오기 --%>
    $.ajax({
        method:"POST"
        , url:"weekReportDown.do"
        , data:opener.$("#defaultFrm").serialize()
        , dataType:"html"
        , success:function(data){
			
            var source = 'data:application/hwp;charset=utf-8,' + encodeURIComponent(data);
            
            var fileDownload = document.createElement("a");
            <%-- hwp 파일 제목  --%>
            document.body.appendChild(fileDownload);
            fileDownload.href = source;
            fileDownload.download =  "${rptVO.monWeek }"+" 주간 보고서.hwp";
            fileDownload.click();
            document.body.removeChild(fileDownload);
        }
    }); 
} 

</script>
<title>${rptVO.monWeek } 공정보고</title>
<meta http_quiv="content-type" content="text/html; charset=utf-8">
<STYLE>
* {font-family: 맑은고딕 !important;}
table {width : 100%;}
.pt10 {font-size: 10pt !important;}
P.HStyle0, LI.HStyle0, DIV.HStyle0
	{style-name:"바탕글"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle1, LI.HStyle1, DIV.HStyle1
	{style-name:"제목 0"; margin-left:15.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-15.6pt; line-height:200%; font-size:15.0pt; font-family:HY헤드라인M; letter-spacing:0.8pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle2, LI.HStyle2, DIV.HStyle2
	{style-name:"제목 1"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:200%; font-size:15.0pt; font-family:HY헤드라인M; letter-spacing:0.8pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle3, LI.HStyle3, DIV.HStyle3
	{style-name:"제목 2"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt]; line-height:180%; font-size:14.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle4, LI.HStyle4, DIV.HStyle4
	{style-name:"제목 3"; margin-left:40.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-20.6pt; line-height:160%; font-size:13.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle5, LI.HStyle5, DIV.HStyle5
	{style-name:"제목 4"; margin-left:44.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-14.6pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle6, LI.HStyle6, DIV.HStyle6
	{style-name:"제목 5"; margin-left:49.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-9.6pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle7, LI.HStyle7, DIV.HStyle7
	{style-name:"제목 6"; margin-left:55.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-5.6pt; line-height:160%; font-size:11.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle8, LI.HStyle8, DIV.HStyle8
	{style-name:"표지문서명"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:28.0pt; font-family:HY헤드라인M; letter-spacing:-1.4pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle9, LI.HStyle9, DIV.HStyle9
	{style-name:"표지일자"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:HY헤드라인M; letter-spacing:0.8pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle10, LI.HStyle10, DIV.HStyle10
	{style-name:"표지조직명1"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:18.0pt; font-family:HY헤드라인M; letter-spacing:0.9pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle11, LI.HStyle11, DIV.HStyle11
	{style-name:"표지조직명2"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:16.0pt; font-family:HY헤드라인M; letter-spacing:0.8pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle12, LI.HStyle12, DIV.HStyle12
	{style-name:"목차제목"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:20.0pt; font-family:HY헤드라인M; letter-spacing:-1.0pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle13, LI.HStyle13, DIV.HStyle13
	{style-name:"목차"; margin-left:30.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:300%; font-size:16.0pt; font-family:바탕; letter-spacing:0.8pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle14, LI.HStyle14, DIV.HStyle14
	{style-name:"붙임"; margin-left:85.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-51.5pt; line-height:180%; font-size:15.0pt; font-family:바탕; letter-spacing:0.8pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle15, LI.HStyle15, DIV.HStyle15
	{style-name:"문서명"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:24.0pt; font-family:HY헤드라인M; letter-spacing:-1.2pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle16, LI.HStyle16, DIV.HStyle16
	{style-name:"결재"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:휴먼명조; letter-spacing:0.5pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle17, LI.HStyle17, DIV.HStyle17
	{style-name:"표타이틀"; margin-left:9.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:-9.6pt; line-height:160%; font-size:13.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle18, LI.HStyle18, DIV.HStyle18
	{style-name:"표제목"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:13.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle19, LI.HStyle19, DIV.HStyle19
	{style-name:"표내용좌측정렬"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle20, LI.HStyle20, DIV.HStyle20
	{style-name:"표내용중앙정렬"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle21, LI.HStyle21, DIV.HStyle21
	{style-name:"표내용우측정렬"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:right; text-indent:0.0pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle22, LI.HStyle22, DIV.HStyle22
	{style-name:"머리말꼬리말좌측정렬"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:8.0pt; font-family:맑은 고딕; letter-spacing:0.4pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle23, LI.HStyle23, DIV.HStyle23
	{style-name:"머리말꼬리말중앙정렬"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:8.0pt; font-family:맑은 고딕; letter-spacing:0.4pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle24, LI.HStyle24, DIV.HStyle24
	{style-name:"머리말꼬리말우측정렬"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:right; text-indent:0.0pt; line-height:100%; font-size:8.0pt; font-family:맑은 고딕; letter-spacing:0.4pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle25, LI.HStyle25, DIV.HStyle25
	{style-name:"MsoHeader"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:바탕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle26, LI.HStyle26, DIV.HStyle26
	{style-name:"MS바탕글"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:바탕체; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle27, LI.HStyle27, DIV.HStyle27
	{style-name:"xl44630"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle28, LI.HStyle28, DIV.HStyle28
	{style-name:"xl44632"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle29, LI.HStyle29, DIV.HStyle29
	{style-name:"xl44633"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle30, LI.HStyle30, DIV.HStyle30
	{style-name:"xl44634"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle31, LI.HStyle31, DIV.HStyle31
	{style-name:"xl44635"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle32, LI.HStyle32, DIV.HStyle32
	{style-name:"xl44637"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle33, LI.HStyle33, DIV.HStyle33
	{style-name:"xl44638"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#ffffff; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle34, LI.HStyle34, DIV.HStyle34
	{style-name:"xl44640"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#ffffff; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle35, LI.HStyle35, DIV.HStyle35
	{style-name:"xl44636"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle36, LI.HStyle36, DIV.HStyle36
	{style-name:"xl44628"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#ffffff; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#1f497d;}
P.HStyle37, LI.HStyle37, DIV.HStyle37
	{style-name:"xl44631"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d8d8d8; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle38, LI.HStyle38, DIV.HStyle38
	{style-name:"xl44627"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#ffffff; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle39, LI.HStyle39, DIV.HStyle39
	{style-name:"xl44621"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle40, LI.HStyle40, DIV.HStyle40
	{style-name:"xl44624"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle41, LI.HStyle41, DIV.HStyle41
	{style-name:"xl44620"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle42, LI.HStyle42, DIV.HStyle42
	{style-name:"xl44623"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle43, LI.HStyle43, DIV.HStyle43
	{style-name:"xl44622"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; background-color:#ddd9c3; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle44, LI.HStyle44, DIV.HStyle44
	{style-name:"xl44625"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle45, LI.HStyle45, DIV.HStyle45
	{style-name:"xl44629"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle46, LI.HStyle46, DIV.HStyle46
	{style-name:"xl44626"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle47, LI.HStyle47, DIV.HStyle47
	{style-name:"xl44619"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle48, LI.HStyle48, DIV.HStyle48
	{style-name:"xl44618"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle49, LI.HStyle49, DIV.HStyle49
	{style-name:"xl44614"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#d9d9d9; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle50, LI.HStyle50, DIV.HStyle50
	{style-name:"xl44616"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:8.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle51, LI.HStyle51, DIV.HStyle51
	{style-name:"xl44615"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:8.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle52, LI.HStyle52, DIV.HStyle52
	{style-name:"xl44617"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:8.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle53, LI.HStyle53, DIV.HStyle53
	{style-name:"xl68"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle54, LI.HStyle54, DIV.HStyle54
	{style-name:"xl73"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle55, LI.HStyle55, DIV.HStyle55
	{style-name:"xl63"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle56, LI.HStyle56, DIV.HStyle56
	{style-name:"xl64"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle57, LI.HStyle57, DIV.HStyle57
	{style-name:"xl69"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle58, LI.HStyle58, DIV.HStyle58
	{style-name:"xl65"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle59, LI.HStyle59, DIV.HStyle59
	{style-name:"xl72"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle60, LI.HStyle60, DIV.HStyle60
	{style-name:"xl70"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#ff0000;}
P.HStyle61, LI.HStyle61, DIV.HStyle61
	{style-name:"xl66"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle62, LI.HStyle62, DIV.HStyle62
	{style-name:"xl71"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#ff0000;}
P.HStyle63, LI.HStyle63, DIV.HStyle63
	{style-name:"xl67"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle64, LI.HStyle64, DIV.HStyle64
	{style-name:"xl74"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle65, LI.HStyle65, DIV.HStyle65
	{style-name:"xl76"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle66, LI.HStyle66, DIV.HStyle66
	{style-name:"xl75"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle67, LI.HStyle67, DIV.HStyle67
	{style-name:"xl77"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle68, LI.HStyle68, DIV.HStyle68
	{style-name:"xl78"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle69, LI.HStyle69, DIV.HStyle69
	{style-name:"xl81"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle70, LI.HStyle70, DIV.HStyle70
	{style-name:"xl82"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle71, LI.HStyle71, DIV.HStyle71
	{style-name:"xl83"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle72, LI.HStyle72, DIV.HStyle72
	{style-name:"xl84"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle73, LI.HStyle73, DIV.HStyle73
	{style-name:"xl86"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#ff0000;}
P.HStyle74, LI.HStyle74, DIV.HStyle74
	{style-name:"xl87"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle75, LI.HStyle75, DIV.HStyle75
	{style-name:"xl88"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle76, LI.HStyle76, DIV.HStyle76
	{style-name:"xl113"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle77, LI.HStyle77, DIV.HStyle77
	{style-name:"xl110"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle78, LI.HStyle78, DIV.HStyle78
	{style-name:"xl112"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle79, LI.HStyle79, DIV.HStyle79
	{style-name:"xl111"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle80, LI.HStyle80, DIV.HStyle80
	{style-name:"xl114"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle81, LI.HStyle81, DIV.HStyle81
	{style-name:"xl115"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle82, LI.HStyle82, DIV.HStyle82
	{style-name:"xl116"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
	P.HStyle83, LI.HStyle83, DIV.HStyle83
	{style-name:"xl116"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:12.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
</STYLE>
</head>
<body>
<c:if test="${empty downType }">
<div style="text-align:right; margin-bottom:5px; padding-right:20px;">
<%--<a href="#" onclick="htmlToFile();"  style="font-size:13px; line-height:28px; height:28px; padding:0 12px; border-radius:5px; text-decoration:none; border:1px solid #000; display:inline-block; color:#000; background:#f2f2f2;">hwp 다운로드</a>--%>
</div>
</c:if>
	<P CLASS=HStyle0 STYLE='text-align:left;line-height:200%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="560" height="105" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.1pt 0.0pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:22.8pt;font-family:"HY헤드라인M";letter-spacing:-3.2pt;text-decoration:"underline";line-height:130%;'><c:out value="${rptVO.monWeek } 공정보고"/></SPAN></P>
	<P CLASS=HStyle15><SPAN STYLE='font-size:13.3pt;line-height:160%;'><c:out value=" ${rptVO.weekStartYmd } ~ ${rptVO.weekEndYmd }"/></SPAN></P>
	<P CLASS=HStyle15 STYLE='line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-family:"HY헤드라인M";line-height:130%;'><c:out value="사업명 : ${rptVO.prjNm } "/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'><BR>1. 사업 개요</SPAN></P>

<P CLASS=HStyle0>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>사업명</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='margin-left:27.0pt;text-align:left;text-indent:-27.0pt;line-height:180%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'><c:out value="${rptVO.prjNm }"/></SPAN></P>
	</TD>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>계약기간</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle4 STYLE='margin-left:0.0pt;text-indent:0.0pt;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";line-height:130%;'> </SPAN><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'><c:out value="  ${rptVO.cntrStartYmd } ~ ${rptVO.cntrEndYmd }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle19 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>계약번호</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'><c:out value="${rptVO.cntrNo }"/></SPAN></P>
	</TD>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle19 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>업체명</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle3 STYLE='margin-left:0.0pt;text-indent:0.0pt;line-height:200%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'><c:out value="${rptVO.cmpnNm }"/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'><BR>2. 사업진행현황</SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:13.3pt;line-height:160%;'>가. 진척도 관리</SPAN></P>

<P CLASS=HStyle3 STYLE='text-align:center;line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD rowspan="2" width="50" height="42" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'>구 분</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'>분 석(14%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'>설 계(23%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'>구 현(38%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'>시 험(10%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;letter-spacing:0.5pt;font-weight:"bold";'>시범운영(15%)</SPAN></P>
	</TD>
	<TD rowspan="2" width="50" height="42" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'>계</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:7.5pt;font-weight:"bold"; letter-spacing: -.1em;' CLASS=pt10><c:out value="‘${rptVO.anlyStartYmd } ~ ‘${rptVO.anlyEndYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:7.5pt;font-weight:"bold"; letter-spacing: -.1em;' CLASS=pt10><c:out value="‘${rptVO.dsgnStartYmd } ~ ‘${rptVO.dsgnEndYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:7.5pt;font-weight:"bold"; letter-spacing: -.1em;' CLASS=pt10><c:out value="‘${rptVO.impStartYmd } ~ ‘${rptVO.impEndYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:7.5pt;font-weight:"bold"; letter-spacing: -.1em;' CLASS=pt10><c:out value="‘${rptVO.testStartYmd } ~ ‘${rptVO.testEndYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:7.5pt;font-weight:"bold"; letter-spacing: -.1em;' CLASS=pt10><c:out value="‘${rptVO.pilotStartYmd } ~ ‘${rptVO.pilotEndYmd }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<c:set var="planTot" value="${rptVO.anlyPlan + rptVO.dsgnPlan + rptVO.impPlan + rptVO.testPlan + rptVO.pilotPlan}"/>
	<TD width="50" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'>계 획</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;font-size:10pt;'><c:out value="${rptVO.anlyPlan }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;font-size:10pt;'><c:out value="${rptVO.dsgnPlan }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;font-size:10pt;'><c:out value="${rptVO.impPlan }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;font-size:10pt;'><c:out value="${rptVO.testPlan }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;font-size:10pt;'><c:out value="${rptVO.pilotPlan }%"/></P>
	</TD>
	<TD width="50" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'><c:out value="${planTot}%"/></SPAN></P>
	</TD>
</TR>
<TR>
	<c:set var="prfrTot" value="${rptVO.anlyPrfr + rptVO.dsgnPrfr + rptVO.impPrfr + rptVO.testPrfr + rptVO.pilotPrfr}"/>
	<TD width="50" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='font-size:10pt;text-align:center;'><SPAN STYLE='font-weight:"bold";'>실 적</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='font-size:10pt;text-align:center;'><c:out value="${rptVO.anlyPrfr }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='font-size:10pt;text-align:center;'><c:out value="${rptVO.dsgnPrfr }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='font-size:10pt;text-align:center;'><c:out value="${rptVO.impPrfr }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='font-size:10pt;text-align:center;'><c:out value="${rptVO.testPrfr }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='font-size:10pt;text-align:center;'><c:out value="${rptVO.pilotPrfr }%"/></P>
	</TD>
	<TD width="50" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-size:10pt;font-weight:"bold";'><c:out value="${prfrTot }%"/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:13.3pt;line-height:100%;'><BR><BR></SPAN></P>
<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:13.3pt;line-height:160%;'>나. 인력 투입 현황</SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD rowspan="2" width="160" height="59" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle66><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>담당 업무</SPAN></P>
	</TD>
	<TD width="160" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle65><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>금주 실적</SPAN></P>
	</TD>
	<TD width="160" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle65><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>차주 계획</SPAN></P>
	</TD>
	<TD rowspan="2" width="80" height="59" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle68><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>비고</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="160" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle59><SPAN STYLE='font-size:8.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;' CLASS=pt10><c:out value="${befWeek.weekStartYmd} ~ ${befWeek.weekEndYmd }"/></SPAN></P>
	</TD>
	<TD width="160" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle59><SPAN STYLE='font-size:8.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;' CLASS=pt10><c:out value="${befWeek.nextWeekStartYmd} ~ ${befWeek.nextWeekEndYmd }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<c:set var="thisEmpTot" value="${rptVO.thisEmpPrj + rptVO.thisEmpPlan + rptVO.thisEmpDsgn + rptVO.thisEmpDev}"/>
	<c:set var="nextEmpTot" value="${rptVO.nextEmpPrj + rptVO.nextEmpPlan + rptVO.nextEmpDsgn + rptVO.nextEmpDev}"/>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>사업/프로젝트 관리</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.thisEmpPrj}명"/></SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.nextEmpPrj}명"/>&nbsp;</SPAN></P>
	</TD>
	<TD rowspan="5" width="80" height="145" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle70 STYLE='text-align:justify;'><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.rptRmrk }"/>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>기획</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.thisEmpPlan}명"/>&nbsp;</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.nextEmpPlan}명" />&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>디자인/퍼블리싱</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.thisEmpDsgn}명"/>&nbsp;</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.nextEmpDsgn}명"/>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>개발</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.thisEmpDev}명"/>&nbsp;</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${rptVO.nextEmpDev}명"/>&nbsp;</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>투입 총계</SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${thisEmpTot }명"/></SPAN></P>
	</TD>
	<TD width="160" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${nextEmpTot }명"/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:13.3pt;line-height:100%;'><BR><BR></SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:13.3pt;line-height:160%;'>다. 이슈/변경/특이사항 관리</SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="80" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-weight:"bold";line-height:130%;'>구분</SPAN></P>
	</TD>
	<TD width="240" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-weight:"bold";line-height:130%;'>이슈내용</SPAN></P>
	</TD>
	<TD width="240" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-weight:"bold";line-height:130%;'>조치계획</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="80" height="50" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt; overflow:hidden;'>
	<P CLASS=HStyle83 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:10.5pt;font-weight:"bold";line-height:130%;'>이슈 및<br>특이사항</SPAN></P>
	</TD>
	<TD width="240" height="50" valign="top" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:5.7pt 1.4pt 5.7pt 1.4pt; overflow:hidden;'>
	<P CLASS=HStyle83><SPAN STYLE='font-size:10.0pt;line-height:160%;'><c:out value="${fn:replace(rptVO.issueCn,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
	<TD width="240" height="50" valign="top" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:5.7pt 1.4pt 5.7pt 1.4pt; overflow:hidden;'>
	<P CLASS=HStyle83><SPAN STYLE='font-size:10.0pt;line-height:160%;'><c:out value="${fn:replace(rptVO.actnPlan,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
</TR>
</TABLE>
<SPAN></SPAN>
<SPAN></SPAN>
</P>
<BR><BR>
<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'><BR></SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'>3. 금주 실적 및 익주 계획 </SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="70" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt; overflow:hidden;' >
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:110%;'><SPAN STYLE='font-weight:"bold";'>비고</SPAN></P>
	</TD>
	<TD width="250" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:110%;'><SPAN STYLE='font-family:"맑은 고딕";font-weight:"bold";'>금주 실적</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";'>&nbsp;<c:out value="${befWeek.weekStartYmd} ~ ${befWeek.weekEndYmd }"/></SPAN></P>
	</TD>
	<TD width="250" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";font-weight:"bold";'>차주 계획</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";'>&nbsp;<c:out value="${befWeek.nextWeekStartYmd} ~ ${befWeek.nextWeekEndYmd }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="70" height="780" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-weight:"bold";line-height:130%;'>내용</SPAN></P>
	</TD>
	<TD width="250" height="780" valign="top" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.6pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:5.7pt 5.7pt 5.7pt 5.7pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${fn:replace(rptVO.thisPrfr,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
	<TD width="250" height="780" valign="top" style='border-left:solid #000000 0.6pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:5.7pt 5.7pt 5.7pt 5.7pt'>
	<P CLASS=HStyle0 STYLE='line-height:140%;'><SPAN STYLE='font-size:10.5pt;line-height:140%;'><c:out value="${fn:replace(rptVO.nextPlan,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle3 STYLE='line-height:140%;'><SPAN STYLE='font-size:13.3pt;line-height:140%;'>붙임 1. 요청자료 목록</SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:140%;'><SPAN STYLE='font-size:13.3pt;line-height:140%;'>붙임 2. 지시 및 조치사항 </SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:13.3pt;line-height:160%;'><BR></SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:16.2pt;font-family:"HY헤드라인M";line-height:160%;'>1. 요청자료 목록</SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:150%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="40" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 1.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>번호</SPAN></P>
	</TD>
	<TD width="60" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>구분</SPAN></P>
	</TD>
	<TD width="250" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>자료</SPAN></P>
	</TD>
	<TD width="50" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>요청일</SPAN></P>
	</TD>
	<TD width="60" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>처리</SPAN></P>
	</TD>
	<TD width="100" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 1.4pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>비고</SPAN></P>
	</TD>
</TR>
<c:choose>
   	<c:when test="${fn:length(mtrlList) gt 0 }">
   		<c:forEach var="mtrl" items="${mtrlList }" varStatus="mtrlStatus">
			<TR>
				<TD width="40" height="27" valign="middle" style='border-left:solid #000000 1.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:150%;'><SPAN STYLE='font-size:9.5pt;font-family:"맑은 고딕";line-height:150%;'><c:out value="${mtrlStatus.count }"/></SPAN></P>
				</TD>
				<TD width="100" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:left;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:9.5pt;font-family:"맑은 고딕";line-height:100%;'><c:out value="${mtrl.mtrlGbn }"/></SPAN></P>
				</TD>
				<TD width="210" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='margin-left:2.4pt;text-align:left;'><SPAN STYLE='font-size:9.5pt;font-family:"맑은 고딕";letter-spacing:0.4pt;line-height:160%;'><c:out value="${mtrl.mtrlCn }"/></SPAN></P>
				</TD>
				<TD width="50" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle19 STYLE='margin-left:2.4pt;text-align:center;'><SPAN STYLE='font-size:9.5pt;font-family:"맑은 고딕";letter-spacing:0.4pt;line-height:160%;'><c:out value="${mtrl.reqDt }"/></SPAN></P>
				</TD>
				<TD width="60" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:center;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:9.5pt;font-family:"맑은 고딕";line-height:100%;'><c:out value="${mrtl.procGbn }"/></SPAN></P>
				</TD>
				<TD width="100" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:left;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:9.5pt;font-family:"맑은 고딕";line-height:100%;'><c:out value="${mtrl.mtrlRmrk }"/></SPAN></P>
				</TD>
			</TR>
   		</c:forEach>
   	</c:when>
   	<c:otherwise>
   		<TR>
			<TD width="40" height="27" valign="middle" style='border-left:solid #000000 1.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='text-align:center;line-height:150%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";line-height:150%;'></SPAN></P>
			</TD>
			<TD width="100" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:left;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";line-height:100%;'></SPAN></P>
			</TD>
			<TD width="210" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='margin-left:2.4pt;text-align:left;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";letter-spacing:0.4pt;line-height:160%;'></SPAN></P>
			</TD>
			<TD width="50" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle19 STYLE='margin-left:2.4pt;text-align:center;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";letter-spacing:0.4pt;line-height:160%;'></SPAN></P>
			</TD>
			<TD width="60" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:center;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";line-height:100%;'></SPAN></P>
			</TD>
			<TD width="100" height="27" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:left;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";line-height:100%;'></SPAN></P>
			</TD>
		</TR>
   	</c:otherwise>
</c:choose>
</TABLE></P>


<P CLASS=HStyle0><SPAN STYLE='font-size:13.3pt;line-height:160%;'><BR></SPAN></P>

<P CLASS=HStyle3 STYLE='line-height:160%;'><SPAN STYLE='font-size:16.2pt;font-family:"HY헤드라인M";line-height:160%;'><BR>2. 지시 및 조치사항</SPAN></P>

<p class="HStyle0" style="margin-left:1.0pt;line-height:150%;">
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="40" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 1.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>번호</SPAN></P>
	</TD>
	<TD width="300" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:150%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>지시내용</SPAN></P>
	</TD>
	<TD width="50" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>지시일</SPAN></P>
	</TD>
	<TD width="60" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>처리</SPAN></P>
	</TD>
	<TD width="100" height="32" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.7pt;border-right:solid #000000 1.4pt;border-top:solid #000000 1.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle58 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:0.0pt;font-weight:"bold";line-height:130%;'>비고</SPAN></P>
	</TD>
</TR>
<c:choose>
     <c:when test="${fn:length(actnList) gt 0 }">
     	<c:forEach var="actn" items="${actnList }" varStatus="actnStatus">
			<TR>
				<TD width="40" height="35" valign="middle" style='border-left:solid #000000 1.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='text-align:center;line-height:150%;'><SPAN STYLE='font-family:"맑은 고딕";font-size:10pt;'><c:out value="${actnStatus.count }"/></SPAN></P>
				</TD>
				<TD width="300" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:left;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";line-height:100%;'><c:out value="${actn.instrCn }"/></SPAN></P>
				</TD>
				<TD width="50" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle19 STYLE='margin-left:2.4pt;text-align:center;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";letter-spacing:0.4pt;line-height:160%;'><c:out value="${actn.instrDt }"/></SPAN></P>
				</TD>
				<TD width="60" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:center;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'><c:out value="${actn.actnGbn }"/></SPAN></P>
				</TD>
				<TD width="100" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
				<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:left;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'><c:out value="${actn.actnRmrk }"/></SPAN></P>
				</TD>
			</TR>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<TR>
			<TD width="40" height="35" valign="middle" style='border-left:solid #000000 1.4pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='text-align:center;line-height:150%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'></SPAN></P>
			</TD>
			<TD width="300" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='margin-left:16.4pt;text-align:left;text-indent:-14.0pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";line-height:100%;'></SPAN></P>
			</TD>
			<TD width="50" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle19 STYLE='margin-left:2.4pt;text-align:center;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";letter-spacing:0.4pt;line-height:160%;'></SPAN></P>
			</TD>
			<TD width="60" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 0.7pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:center;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'></SPAN></P>
			</TD>
			<TD width="100" height="35" valign="middle" style='border-left:solid #000000 0.7pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='margin-left:0.6pt;text-align:left;text-indent:0.6pt;line-height:100%;'><SPAN STYLE='font-size:10pt;font-family:"맑은 고딕";'></SPAN></P>
			</TD>
		</TR>
	</c:otherwise>
</c:choose>
</TABLE></P>

<P CLASS=HStyle0 STYLE='line-height:150%;'><SPAN STYLE='font-family:"신명 순명조,한컴돋움";'><BR></SPAN></P>
<BR><BR>
</body>

</HTML>
