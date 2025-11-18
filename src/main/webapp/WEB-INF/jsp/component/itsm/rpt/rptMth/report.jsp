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
            fileDownload.download =  "${monthRptVO.monWeek} 월간 보고서.hwp";
            fileDownload.click();
            document.body.removeChild(fileDownload);
        }
    }); 
} 

</script>
<title>${monthRptVO.monWeek } 월간 보고서</title>
<meta http_quiv="content-type" content="text/html; charset=utf-8">
<STYLE>
<!--
*{font-family: 맑은고딕 !important;}
table {width : 100%;}
P.HStyle0, LI.HStyle0, DIV.HStyle0
	{style-name:"바탕글"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle1, LI.HStyle1, DIV.HStyle1
	{style-name:"제목 0"; margin-left:15.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-15.6pt; line-height:200%; font-size:15.0pt; font-family:HY헤드라인M; letter-spacing:0.8pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle2, LI.HStyle2, DIV.HStyle2
	{style-name:"제목 1"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:200%; font-size:15.0pt; font-family:HY헤드라인M; letter-spacing:0.8pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle3, LI.HStyle3, DIV.HStyle3
	{style-name:"제목 2"; margin-left:32.7pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-22.7pt; line-height:180%; font-size:14.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle4, LI.HStyle4, DIV.HStyle4
	{style-name:"제목 3"; margin-left:40.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-20.6pt; line-height:160%; font-size:13.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle5, LI.HStyle5, DIV.HStyle5
	{style-name:"제목 4"; margin-left:44.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-14.6pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle6, LI.HStyle6, DIV.HStyle6
	{style-name:"제목 5"; margin-left:49.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-9.6pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle7, LI.HStyle7, DIV.HStyle7
	{style-name:"제목 6"; margin-left:55.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-5.6pt; line-height:160%; font-size:10.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
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
-->
</STYLE>
</HEAD>

<BODY>
<c:if test="${empty downType }">
<div style="text-align:right; margin-bottom:5px; padding-right:20px;">
<%--<a href="#" onclick="htmlToFile();"  style="font-size:13px; line-height:28px; height:28px; padding:0 12px; border-radius:5px; text-decoration:none; border:1px solid #000; display:inline-block; color:#000; background:#f2f2f2;">hwp 다운로드</a>--%>
</div>
</c:if>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="560" height="105" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.1pt 0.0pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:22.8pt;font-family:"HY헤드라인M";letter-spacing:-3.2pt;text-decoration:"underline";line-height:130%;'><c:out value="${monthRptVO.monWeek } 공정보고"/></SPAN></P>
	<P CLASS=HStyle15><SPAN STYLE='font-size:13.3pt;line-height:160%;'><c:out value=" ${monthRptVO.thisMonthStartYmd } ~ ${monthRptVO.thisMonthEndYmd }"/></SPAN></P>
	<P CLASS=HStyle15 STYLE='line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-family:"HY헤드라인M";line-height:130%;'><c:out value="사업명 : ${monthRptVO.prjNm } "/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:100%;'><BR><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'>1. 사업 개요</SPAN></P>

<P CLASS=HStyle0>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>사업명</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='margin-left:27.0pt;text-align:left;text-indent:-27.0pt;line-height:180%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";letter-spacing:-2.0pt;'><c:out value="${monthRptVO.prjNm }"/></SPAN></P>
	</TD>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>계약기간</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle4 STYLE='margin-left:0.0pt;text-indent:0.0pt;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";line-height:160%;'> </SPAN><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";'><c:out value="${monthRptVO.cntrStartYmd } ~ ${monthRptVO.cntrEndYmd }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle19 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>계약번호</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-family:"맑은 고딕";font-size:10.0pt;'><c:out value="${monthRptVO.cntrNo }"/></SPAN></P>
	</TD>
	<TD width="70" height="28" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
	<P CLASS=HStyle19 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-family:"맑은 고딕";font-weight:"bold";line-height:130%;'>업체명</SPAN></P>
	</TD>
	<TD width="210" height="28" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle3 STYLE='margin-left:0.0pt;text-indent:0.0pt;line-height:200%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";'><c:out value="${monthRptVO.cmpnNm }"/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='line-height:100%;'><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:100%;'><BR><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'>2. 사업 진행 현황 </SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:160%;'><SPAN STYLE='font-size:13.3pt;line-height:160%;'>가. 진척도 관리</SPAN></P>

<P CLASS=HStyle0 STYLE='text-align:center;line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD rowspan="2" width="55" height="42" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>구 분</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>분 석(14%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>설 계(23%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>구 현(38%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>시 험(10%)</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='letter-spacing:0.5pt;font-weight:"bold";'>시범운영</SPAN><SPAN STYLE='letter-spacing:-2.0pt;font-weight:"bold";'>(20%)</SPAN></P>
	</TD>
	<TD rowspan="2" width="55" height="42" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>계</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";font-size:10.0pt;'><c:out value="`${monthRptVO.anlyStartYmd } ~ `${monthRptVO.anlyEndYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";font-size:10.0pt;'><c:out value="`${monthRptVO.dsgnStartYmd } ~ `${monthRptVO.dsgnEndYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";font-size:10.0pt;'><c:out value="`${monthRptVO.impStartYmd } ~ `${monthRptVO.impEndYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";font-size:10.0pt;'><c:out value="`${monthRptVO.testStartYmd }"/></SPAN></P>
	</TD>
	<TD width="90" height="20" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";font-size:10.0pt;'><c:out value="`${monthRptVO.pilotStartYmd } ~ `${monthRptVO.pilotEndYmd }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="55" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>계 획</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><c:out value="${monthRptVO.anlyPlan }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.dsgnPlan }%"/></SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.impPlan }%"/></SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.testPlan}%"/></SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.pilotPlan }%"/></SPAN></P>
	</TD>
	<TD width="55" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<c:set var="planTot" value="${rptVO.anlyPlan + rptVO.dsgnPlan + rptVO.impPlan + rptVO.testPlan + rptVO.pilotPlan}"/>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${planTot}%"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="55" height="22" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'>실 적</SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><c:out value="${monthRptVO.anlyPrfr }%"/></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.dsgnPrfr }%"/></SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.impPrfr }%"/></SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.testPrfr }%"/></SPAN></P>
	</TD>
	<TD width="90" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${monthRptVO.pilotPrfr }%"/></SPAN></P>
	</TD>
	<TD width="55" height="22" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<c:set var="prfrTot" value="${rptVO.anlyPrfr + rptVO.dsgnPrfr + rptVO.impPrfr + rptVO.testPrfr + rptVO.pilotPrfr}"/>
	<P CLASS=HStyle0 STYLE='text-align:center;'><SPAN STYLE='font-weight:"bold";'><c:out value="${prfrTot}%"/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='line-height:80%;'><SPAN STYLE='font-size:13.3pt;line-height:80%;'><BR><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:100%; text-align:left; display: flex; justify-content : space-between;'><SPAN STYLE='font-size:13.3pt;line-height:100%;'>나. 인력 투입 현황&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</SPAN><SPAN STYLE='font-size:9.5pt;line-height:100%;'>(단위 : M/M)</SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:200%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>

<c:if test="${empty monthRptVO.monWeek5 }">
	<TR>
		<TD rowspan="2" width="160" height="59" valign="middle" bgcolor="#bbbbbb" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle66><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>담당 업무</SPAN></P>
		</TD>
		<TD colspan="4" width="400" height="30" valign="middle" bgcolor="#bbbbbb" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle65><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>투입실적</SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="100" height="30" valign="middle" bgcolor="#bbbbbb" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek1 }"/></SPAN></P>
		</TD>
		<TD width="100" height="30" valign="middle" bgcolor="#bbbbbb" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek2 }"/></SPAN></P>
		</TD>
		<TD width="100" height="30" valign="middle" bgcolor="#bbbbbb" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek3 }"/></SPAN></P>
		</TD>
		<TD width="100" height="30" valign="middle" bgcolor="#bbbbbb" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek4 }"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="160" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>사업/프로젝트 관리</SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj1}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj2}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj3}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj4}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="160" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>기획</SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan1}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan2}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan3}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan4}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="160" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>디자인/퍼블리싱</SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn1}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn2}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn3}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn4}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="160" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>개발</SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev1}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev2}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev3}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev4}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="160" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>투입 총계</SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot1" value="${monthRptVO.empPrj1 + monthRptVO.empPlan1 + monthRptVO.empDsgn1 + monthRptVO.empDev1}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot1}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot2" value="${monthRptVO.empPrj2 + monthRptVO.empPlan2 + monthRptVO.empDsgn2 + monthRptVO.empDev2}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot2}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot3" value="${monthRptVO.empPrj3 + monthRptVO.empPlan3 + monthRptVO.empDsgn3 + monthRptVO.empDev3}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot3}명"/></SPAN></P>
		</TD>
		<TD width="100" height="29" valign="middle" style='text-align:center; border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot4" value="${monthRptVO.empPrj4 + monthRptVO.empPlan4 + monthRptVO.empDsgn4 + monthRptVO.empDev4}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot4}명"/></SPAN></P>
		</TD>
	</TR>
</c:if>
<c:if test="${not empty monthRptVO.monWeek5 }">
	<TR>
		<TD rowspan="2" width="150" height="59" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle66><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>담당 업무</SPAN></P>
		</TD>
		<TD colspan="5" width="400" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle65><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>투입실적</SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="90" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek1 }"/></SPAN></P>
		</TD>
		<TD width="90" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek2 }"/></SPAN></P>
		</TD>
		<TD width="90" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek3 }"/></SPAN></P>
		</TD>
		<TD width="90" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek4 }"/></SPAN></P>
		</TD>
		<TD width="90" height="30" valign="middle" bgcolor="#bbbbbb" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle59><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'><c:out value="${monthRptVO.monWeek5 }"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="100" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>사업/프로젝트 관리</SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj1}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj2}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj3}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj4}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPrj5}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="100" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>기획</SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan1}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan2}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan3}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan4}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empPlan5}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="100" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>디자인/퍼블리싱</SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn1}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn2}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn3}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn4}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDsgn5}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="100" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>개발</SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev1}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev2}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev3}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev4}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:dotted #000000 0.9pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${monthRptVO.empDev5}명"/></SPAN></P>
		</TD>
	</TR>
	<TR>
		<TD width="100" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<P CLASS=HStyle69><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;font-weight:"bold";line-height:160%;'>투입 총계</SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot1" value="${monthRptVO.empPrj1 + monthRptVO.empPlan1 + monthRptVO.empDsgn1 + monthRptVO.empDev1}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot1}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot2" value="${monthRptVO.empPrj2 + monthRptVO.empPlan2 + monthRptVO.empDsgn2 + monthRptVO.empDev2}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot2}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot3" value="${monthRptVO.empPrj3 + monthRptVO.empPlan3 + monthRptVO.empDsgn3 + monthRptVO.empDev3}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot3}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot4" value="${monthRptVO.empPrj4 + monthRptVO.empPlan4 + monthRptVO.empDsgn4 + monthRptVO.empDev4}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot4}명"/></SPAN></P>
		</TD>
		<TD width="90" height="29" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:dotted #000000 0.9pt;border-bottom:solid #000000 1.1pt;padding:0.0pt 0.0pt 0.0pt 0.0pt'>
		<c:set var="empTot5" value="${monthRptVO.empPrj5 + monthRptVO.empPlan5 + monthRptVO.empDsgn5 + monthRptVO.empDev5}" />
		<P CLASS=HStyle61><SPAN STYLE='font-size:10.0pt;letter-spacing:0.0pt;line-height:160%;'><c:out value="${empTot5}명"/></SPAN></P>
		</TD>
	</TR>
</c:if>

</TABLE></P>

<P CLASS=HStyle0 STYLE='line-height:80%;'><SPAN STYLE='font-size:13.3pt;line-height:80%;'><BR><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:100%;'><SPAN STYLE='font-size:13.3pt;line-height:100%;'>다. 이슈/변경/특이사항 관리</SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="80" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.5pt;font-weight:"bold";line-height:130%;'>구분</SPAN></P>
	</TD>
	<TD width="240" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.5pt;font-weight:"bold";line-height:130%;'>이슈내용</SPAN></P>
	</TD>
	<TD width="240" height="30" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-size:10.5pt;font-weight:"bold";line-height:130%;'>조치계획</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="80" height="76" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle19 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:10.5pt;font-weight:"bold";line-height:130%;'>이슈</SPAN></P>
	<P CLASS=HStyle19 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:10.5pt;font-weight:"bold";line-height:130%;'>&nbsp;및 </SPAN></P>
	<P CLASS=HStyle19 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:10.5pt;font-weight:"bold";line-height:130%;'>특이사항</SPAN></P>
	</TD>
	<TD width="240" height="76" valign="top" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:5.7pt 1.4pt 5.7pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${fn:replace(monthRptVO.issueCn,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
	<TD width="240" height="76" valign="top" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:5.7pt 1.4pt 5.7pt 1.4pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${fn:replace(monthRptVO.actnPlan,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'>3. 전월 실적 및 금월 계획 </SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="70" height="50" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:110%;'><SPAN STYLE='font-weight:"bold";'>비고</SPAN></P>
	</TD>
	<TD width="245" height="50" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:110%;'><SPAN STYLE='font-family:"맑은 고딕";font-weight:"bold";'>금월 실적</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";'><c:out value="${monthRptVO.thisMonthStartYmd} ~ ${monthRptVO.thisMonthEndYmd }"/></SPAN></P>
	</TD>
	<TD width="245" height="50" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";font-weight:"bold";'>차월 계획</SPAN></P>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";'><c:out value="${monthRptVO.nextMonthStartYmd} ~ ${monthRptVO.nextMonthEndYmd }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="70" height="875" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-weight:"bold";line-height:130%;'>내용</SPAN></P>
	</TD>
	<TD width="245" height="875" valign="top" bgcolor="#ffffff" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:5.7pt 5.7pt 5.7pt 5.7pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${fn:replace(monthRptVO.thisPrfr,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
	<TD width="245" height="875" valign="top" bgcolor="#ffffff" style='border-left:solid #000000 0.6pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:5.7pt 5.7pt 5.7pt 5.7pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${fn:replace(monthRptVO.nextPlan,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:80%;'><BR><BR></SPAN></P>
<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'>4. 주요 논의 및 협조사항</SPAN></P>

<P CLASS=HStyle0>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="60" height="29" valign="middle" bgcolor="#d8d8d8" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-weight:"bold";line-height:130%;'>구분</SPAN></P>
	</TD>
	<TD width="120" height="29" valign="middle" bgcolor="#d8d8d8" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-weight:"bold";line-height:130%;'>항목</SPAN></P>
	</TD>
	<TD width="300" height="29" valign="middle" bgcolor="#d8d8d8" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-weight:"bold";line-height:130%;'>내용</SPAN></P>
	</TD>
	<TD width="80" height="29" valign="middle" bgcolor="#d8d8d8" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-size:12.4pt;font-weight:"bold";line-height:130%;'>비고</SPAN></P>
	</TD>
</TR>
<c:choose>
	<c:when test="${fn:length(dscsList) gt 0 }">
		<c:forEach var="dscs" items="${dscsList }" varStatus="dscsStatus">
			<TR>
				<TD width="60" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${dscs.dscsGbn }"/></SPAN></P>
				</TD>
				<TD width="120" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${dscs.dscsItem }"/></SPAN></P>
				</TD>
				<TD width="300" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'>1<c:out value="${dscs.dscsCn }"/></SPAN></P>
				</TD>
				<TD width="80" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
				<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'><c:out value="${dscs.dscsRmrk }"/></SPAN></P>
				</TD>
			</TR>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<TR>
			<TD colspan="4" width="560" height="54" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
			<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;line-height:160%;'></SPAN></P>
			</TD>
		</TR>
	</c:otherwise>
</c:choose>
</TABLE></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:80%;'><BR><BR></SPAN></P>

<P CLASS=HStyle0><SPAN STYLE='font-size:14.3pt;font-family:"HY헤드라인M";line-height:160%;'>5. 비고</SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:160%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="560" height="50" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";font-weight:"bold";'>회의내용</SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="560" height="539" valign="top" bgcolor="#ffffff" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.1pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.1pt;padding:5.7pt 5.7pt 5.7pt 5.7pt'>
	<P CLASS=HStyle0><SPAN STYLE='font-size:10.5pt;letter-spacing:0.7pt;line-height:160%;'><c:out value="${fn:replace(monthRptVO.rptMonthRmrk,nbr,'<br>') }" escapeXml="false" /></SPAN></P>
	</TD>
</TR>
</TABLE></P>
<BR><BR>
</BODY>

</HTML>
