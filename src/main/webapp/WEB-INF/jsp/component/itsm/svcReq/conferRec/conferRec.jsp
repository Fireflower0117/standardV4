<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("nbr", "\n"); %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>

<HEAD>
<META NAME="Generator" CONTENT="Haansoft HWP 8.0.0.466">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<script src="${pageContext.request.contextPath}/component/itsm/js/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/component/itsm/js/jquery-ui-1.12.1.custom.js"></script>
<script src="${pageContext.request.contextPath}/component/itsm/js/htmlFile.js"></script>

<script type="text/javascript">

function htmlToFile() {
    
    <%-- 보고서 내용 가져오기 --%>
    $.ajax({
        method:"POST"
        , url:"conferPrintDown.do"
        , data:opener.$("#defaultFrm").serialize()
        , dataType:"html"
        , success:function(data){
			
            var source = 'data:application/hwp;charset=utf-8,' + encodeURIComponent(data);
            
            var fileDownload = document.createElement("a");
            <%-- hwp 파일 제목  --%>
            document.body.appendChild(fileDownload);
            fileDownload.href = source;
            fileDownload.download =  "${itsmConferRecVO.cofDt }"+"_회의록.hwp";
            fileDownload.click();
            document.body.removeChild(fileDownload);
        }
    }); 
} 

</script>

<TITLE>회의록</TITLE>
<meta http_quiv="content-type" content="text/html; charset=utf-8">
<STYLE>
<!--
*{font-family: 맑은고딕; font-size: 10pt;}
table {width: 100%}
P.HStyle0, LI.HStyle0, DIV.HStyle0
	{style-name:"바탕글"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle1, LI.HStyle1, DIV.HStyle1
	{style-name:"본문"; margin-left:17.5pt; margin-right:17.5pt; margin-top:4.2pt; margin-bottom:4.2pt; text-align:justify; text-indent:0.0pt; line-height:165%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.5pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle2, LI.HStyle2, DIV.HStyle2
	{style-name:"개요 1"; margin-left:7.4pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-7.4pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle3, LI.HStyle3, DIV.HStyle3
	{style-name:"개요 2"; margin-left:17.4pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-7.4pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle4, LI.HStyle4, DIV.HStyle4
	{style-name:"개요 3"; margin-left:27.4pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-7.4pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle5, LI.HStyle5, DIV.HStyle5
	{style-name:"개요 4"; margin-left:37.4pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-7.4pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle6, LI.HStyle6, DIV.HStyle6
	{style-name:"개요 5"; margin-left:47.4pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-7.4pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle7, LI.HStyle7, DIV.HStyle7
	{style-name:"개요 6"; margin-left:57.4pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-7.4pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle8, LI.HStyle8, DIV.HStyle8
	{style-name:"개요 7"; margin-left:67.4pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-7.4pt; line-height:160%; font-size:10.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle9, LI.HStyle9, DIV.HStyle9
	{style-name:"쪽 번호"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:한양견고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle10, LI.HStyle10, DIV.HStyle10
	{style-name:"머리말"; margin-left:0.0pt; margin-right:10.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:right; text-indent:0.0pt; line-height:150%; font-size:9.0pt; font-family:한양중고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle11, LI.HStyle11, DIV.HStyle11
	{style-name:"각주"; margin-left:13.2pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:-13.2pt; line-height:130%; font-size:9.5pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle12, LI.HStyle12, DIV.HStyle12
	{style-name:"그림캡션"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:한양중고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle13, LI.HStyle13, DIV.HStyle13
	{style-name:"표캡션"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:한양중고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle14, LI.HStyle14, DIV.HStyle14
	{style-name:"수식캡션"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:한양중고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle15, LI.HStyle15, DIV.HStyle15
	{style-name:"찾아보기"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:9.0pt; font-family:한양신명조; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle16, LI.HStyle16, DIV.HStyle16
	{style-name:"MsoHeader"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:바탕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle17, LI.HStyle17, DIV.HStyle17
	{style-name:"제목 4"; margin-left:44.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-14.6pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle18, LI.HStyle18, DIV.HStyle18
	{style-name:"표제목"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:13.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle19, LI.HStyle19, DIV.HStyle19
	{style-name:"제목 2"; margin-left:32.7pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-22.7pt; line-height:180%; font-size:14.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle20, LI.HStyle20, DIV.HStyle20
	{style-name:"제목 3"; margin-left:40.6pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:-20.6pt; line-height:160%; font-size:13.0pt; font-family:휴먼명조; letter-spacing:0.7pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle21, LI.HStyle21, DIV.HStyle21
	{style-name:"문서명"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:160%; font-size:24.0pt; font-family:HY헤드라인M; letter-spacing:-1.2pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle22, LI.HStyle22, DIV.HStyle22
	{style-name:"표내용좌측정렬"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:160%; font-size:12.0pt; font-family:휴먼명조; letter-spacing:0.6pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle23, LI.HStyle23, DIV.HStyle23
	{style-name:"xl68"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; background-color:#bfbfbf; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"bold"; font-style:"normal"; color:#000000;}
P.HStyle24, LI.HStyle24, DIV.HStyle24
	{style-name:"xl69"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:center; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle25, LI.HStyle25, DIV.HStyle25
	{style-name:"xl70"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle26, LI.HStyle26, DIV.HStyle26
	{style-name:"xl67"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
P.HStyle27, LI.HStyle27, DIV.HStyle27
	{style-name:"xl66"; margin-left:0.0pt; margin-right:0.0pt; margin-top:0.0pt; margin-bottom:0.0pt; text-align:left; text-indent:0.0pt; line-height:100%; font-size:10.0pt; font-family:맑은 고딕; letter-spacing:0.0pt; font-weight:"normal"; font-style:"normal"; color:#000000;}
-->
</STYLE>
</HEAD>

<BODY>

<c:if test="${empty downType }">
	<div style="text-align:right; margin-bottom:5px; padding-right:20px;">
		<a href="#" onclick="htmlToFile();"  style="font-size:13px; line-height:28px; height:28px; padding:0 12px; border-radius:5px; text-decoration:none; border:1px solid #000; display:inline-block; color:#000; background:#f2f2f2;">hwp 다운로드</a>
	</div>
</c:if>

<P CLASS=HStyle0 STYLE='line-height:120%;'> 
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD rowspan="2" colspan="2" width="315" height="42" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle0 STYLE='text-align:center;line-height:100%;'><SPAN STYLE='font-size:10.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:100%;'><c:out value="${itsmConferRecVO.svcNm }"/></SPAN></P>
	</TD>
	<TD width="104" height="21" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'>작성자</SPAN></P>
	</TD>
	<TD width="104" height="21" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'><c:out value="${itsmConferRecVO.regNm }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="104" height="21" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'>작성일자</SPAN></P>
	</TD>
	<TD width="104" height="21" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'><c:out value="${itsmConferRecVO.regDt }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="167" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'>ACTIVITY</SPAN></P>
	</TD>
	<TD width="148" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'><c:out value="${itsmConferRecVO.cofInfo }"/></SPAN></P>
	</TD>
	<TD width="104" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'>승인자</SPAN></P>
	</TD>
	<TD width="104" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'><c:out value="${itsmConferRecVO.apvrNm }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="167" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'>표준 산출물</SPAN></P>
	</TD>
	<TD width="148" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'><c:out value="${itsmConferRecVO.cofKind }"/></SPAN></P>
	</TD>
	<TD width="104" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'>Version</SPAN></P>
	</TD>
	<TD width="104" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:0.0pt 5.4pt 0.0pt 5.4pt'>
	<P CLASS=HStyle16 STYLE='line-height:130%;'><SPAN STYLE='font-size:9.0pt;font-family:"맑은 고딕";line-height:130%;'><c:out value="${itsmConferRecVO.version }"/></SPAN></P>
	</TD>
</TR>
</TABLE>

<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-size:12.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:120%;'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-size:12.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:120%;'><BR>1. 사업개요</SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="97" height="23" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";'>사업명</SPAN></P>
	</TD>
	<TD width="538" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${itsmConferRecVO.svcNm }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="97" height="23" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";'>회의일시</SPAN></P>
	</TD>
	<TD width="538" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle20 STYLE='margin-left:0.0pt;text-indent:0.0pt;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${itsmConferRecVO.cofDt }"/>&nbsp;<c:out value="${itsmConferRecVO.cofStaHh }"/>:<c:out value="${itsmConferRecVO.cofStaMi }"/>~<c:out value="${itsmConferRecVO.cofEndHh }"/>:<c:out value="${itsmConferRecVO.cofEndMi }"/></SPAN></P>
	</TD>
</TR>
<TR>
	<TD width="97" height="23" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";'>회의제목</SPAN></P>
	</TD>
	<TD width="538" height="23" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle0 STYLE='text-align:left;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${itsmConferRecVO.cofTtl }"/></SPAN></P>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-size:12.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:120%;'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-size:12.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:120%;'><BR>2. 참석자</SPAN></P>

<P CLASS=HStyle17 STYLE='margin-left:0.0pt;text-indent:0.0pt;line-height:200%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="183" height="18" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:100%;'><SPAN STYLE='font-size:10.5pt;font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";line-height:100%;'>소속</SPAN></P>
	</TD>
	<TD width="70" height="18" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:100%;'><SPAN STYLE='font-size:10.5pt;font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";line-height:100%;'>직급</SPAN></P>
	</TD>
	<TD width="70" height="18" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:100%;'><SPAN STYLE='font-size:10.5pt;font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";line-height:100%;'>이름</SPAN></P>
	</TD>
	<TD width="168" height="18" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:100%;'><SPAN STYLE='font-size:10.5pt;font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";line-height:100%;'>소속</SPAN></P>
	</TD>
	<TD width="78" height="18" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:100%;'><SPAN STYLE='font-size:10.5pt;font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";line-height:100%;'>직급</SPAN></P>
	</TD>
	<TD width="66" height="18" valign="middle" bgcolor="#d6d6d6" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
	<P CLASS=HStyle18 STYLE='line-height:100%;'><SPAN STYLE='font-size:10.5pt;font-family:"맑은 고딕";letter-spacing:0.5pt;font-weight:"bold";line-height:100%;'>이름</SPAN></P>
	</TD>
</TR>
<c:choose>
	<c:when test="${fn:length(openList) gt fn:length(mngList) }">
		<c:forEach var="open" items="${openList }" varStatus="status">
		<TR>
			<TD width="183" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${mngList[status.index].attDeptNm }"/></SPAN></P>
			</TD>
			<TD width="70" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${mngList[status.index].attOftlNm }"/></SPAN></P>
			</TD>
			<TD width="70" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${mngList[status.index].attNm }"/></SPAN></P>
			</TD>
			<TD width="168" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:if test="${status.first }">㈜오픈노트</c:if></SPAN></P>
			</TD>
			<TD width="78" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${open.attOftlNm }"/></SPAN></P>
			</TD>
			<TD width="66" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${open.attNm }"/></SPAN></P>
			</TD>
		</TR>
		</c:forEach>
	</c:when>
	<c:otherwise>
	<c:forEach var="mng" items="${mngList }" varStatus="status">
		<TR>
			<TD width="183" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${mng.attDeptNm }"/></SPAN></P>
			</TD>
			<TD width="70" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${mng.attOftlNm }"/></SPAN></P>
			</TD>
			<TD width="70" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${mng.attNm }"/></SPAN></P>
			</TD>
			<TD width="168" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:if test="${status.first }">㈜오픈노트</c:if></SPAN></P>
			</TD>
			<TD width="78" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle0 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${openList[status.index].attOftlNm }"/></SPAN></P>
			</TD>
			<TD width="66" height="25" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 0.0pt 1.4pt 0.0pt'>
			<P CLASS=HStyle22 STYLE='text-align:center;line-height:130%;'><SPAN STYLE='font-family:"맑은 고딕";letter-spacing:0.5pt;'><c:out value="${openList[status.index].attNm }"/></SPAN></P>
			</TD>
		</TR>
	</c:forEach>
	</c:otherwise>
</c:choose>
</TABLE></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-size:12.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:120%;'><BR></SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-size:12.0pt;font-family:"맑은 고딕";font-weight:"bold";line-height:120%;'><BR>3. 회의내용</SPAN></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'>
<TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;'>
<TR>
	<TD width="636" height="379" valign="top" style='border-left:solid #000000 0.4pt;border-right:solid #000000 1.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 1.4pt;padding:1.4pt 5.1pt 1.4pt 5.1pt'>
		<c:out value="${fn:replace(itsmConferRecVO.cofCn,nbr,'<br>') }" escapeXml="false"/>
	</TD>
</TR>
</TABLE></P>

<P CLASS=HStyle0 STYLE='line-height:120%;'><SPAN STYLE='font-size:12.0pt;font-family:"맑은 고딕";line-height:120%;'><BR></SPAN></P>
<BR><BR>
</BODY>

</HTML>


