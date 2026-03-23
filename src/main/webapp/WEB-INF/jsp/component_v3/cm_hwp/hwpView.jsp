<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<html>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<head><title>회원정보</title>
    <meta http_quiv="content-type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/external/jquery-ui/css/jquery-ui-1.12.1.custom.js"></script>
</head>
<TITLE>결과보고서</TITLE>
<style>
    P.HStyle0, LI.HStyle0, DIV.HStyle0
    {style-name:"바탕글"; text-align:justify; text-indent:0.0pt; line-height:160%; font-size:10.0pt; font-family:함초롬바탕; letter-spacing:0.0pt; font-weight:normal; font-style:normal; color:#000000;}
    .btn.hwp {border: 1px solid #4CB1F9; color: #4CB1F9; display: inline-block; font-size:13px; line-height:28px; height:28px; padding:0 12px; background-color: white;border-radius:5px; text-decoration:none;cursor:pointer}
</style>
</HEAD>

<body id="body">

<script>
    $(document).ready(function() {
        $('.btn_down').on('click', function() {
            fmlReport();
        });
    });

    const fmlReport = function() {
        $.ajax({
            method:"POST"
            , url:"/ma/us/hwp/hwpViewDown"
            , data:opener.$("#defaultFrm").serialize()
            , dataType:"html"
            , success:function(data){

                var source = 'data:application/hwp;charset=EUC-KR,' + encodeURIComponent(data);

                var fileDownload = document.createElement("a");
                //<%-- hwp 파일 제목  --%>
                document.body.appendChild(fileDownload);
                fileDownload.href = source;
                fileDownload.download = "회원정보.hwp";
                fileDownload.click();
                document.body.removeChild(fileDownload);
            },error: function (xhr, status, error) {

                // 로그인 세션 없는 경우
                if (xhr.status == 401) {
                    window.location.reload();
                }
            }
        });
    }
</script>
<c:if test="${downType eq '.do' }">
    <div style="text-align:right; margin-bottom:5px;">
        <button class="btn_down btn hwp"><img src="/internal/standard/common/images/icon/file_word.svg" alt="word" style="vertical-align: -5px;margin-right:3px;">hwp 다운로드</button>
    </div>
</c:if>

<%-- 보고서 시작 --%>
    <TABLE>
        <tr>
            <td colspan="3" width="600px" height="24" valign="middle" style='border:none;padding:1.4pt 5.1pt 12pt 5.1pt'>
                <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-size:16.0pt;font-family:"HY견고딕";line-height:100%;'>회원정보</span></p>
            </td>
        </tr>
        <c:set var="numbering" value="0"/>
        <c:if test="${fn:length(hwpList) > 0 }">
            <c:forEach var="result" items="${hwpList }" varStatus="status">
                <tr>
                    <td colspan="3" width="600px" height="100" valign="middle" style='border:none;'>
                        <c:set var="numbering" value="${numbering + 1}"/>
                        <p CLASS=HStyle0 style='line-height:100%;margin-bottom: 6pt;'><span style='font-size:13.0pt;font-family:"HY견고딕";line-height:100%;'><c:out value="${numbering}"/>.<c:out value="${empty result.userId ? '-' : result.userId}" /></span></p>
                            <p CLASS=HStyle0 style='line-height:100%;'>
                            <TABLE border="1" cellspacing="0" cellpadding="0" style='border-collapse:collapse;border:none;margin-bottom: 3px;'>
                                <COLGROUp>
                                    <col style="width:150px">
                                    <col style="width:200px">
                                    <col style="width:150px">
                                    <col style="width:200px">
                                </COLGROUp>
                                <tr>
                                    <td width="100px" height="17" valign="middle" bgcolor="#dfe6f7" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;font-size:8.0pt;'>이름</span></p>
                                    </td>
                                    <td width="200px" height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;letter-spacing:-1.0pt;font-size:7.0pt;'><c:out value="${empty result.userNm ? '-' : result.userNm }" /></span></p>
                                    </td>
                                    <td width="100px" height="17" valign="middle" bgcolor="#dfe6f7" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;font-size:8.0pt;'>이메일</span></p>
                                    </td>
                                    <td width="200px" height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;letter-spacing:-1.0pt;font-size:7.0pt;'><c:out value="${empty result.userEmailAddr ? '-' : result.userEmailAddr }" /></span></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="17" valign="middle" bgcolor="#dfe6f7" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;font-size:8.0pt;'>주소</span></p>
                                    </td>
                                    <td colspan="3" height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;letter-spacing:-1.0pt;font-size:7.0pt;'><c:out value="${empty result.homeAddr ? '-' : result.homeAddr }" />(<c:out value="${empty result.homeAddrDtls ? '-' : result.homeAddrDtls }" />)</span></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="17" valign="middle" bgcolor="#dfe6f7" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;font-size:8.0pt;'>권한</span></p>
                                    </td>
                                    <td height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;letter-spacing:-1.0pt;font-size:7.0pt;'><c:out value="${empty result.grpAuthNm ? '-' : result.grpAuthNm }" />(<c:out value="${empty result.homeAddrDtls ? '-' : result.homeAddrDtls }" />)</span></p>
                                    </td>
                                    <td height="17" valign="middle" bgcolor="#dfe6f7" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;font-size:8.0pt;'>SNS 계정 연동여부</span></p>
                                    </td>
                                    <td height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'>
                                            <span style='font-family:"맑은 고딕";font-weight:bold;letter-spacing:-1.0pt;font-size:7.0pt;'>
                                                <c:choose>
                                                    <c:when test="${result.snsSeCd eq 'K' }">
                                                        <span>카카오 연동 완료</span>
                                                    </c:when>
                                                    <c:when test="${result.snsSeCd eq 'N' }">
                                                        <span>네이버 연동 완료</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span>SNS 연동 없음</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="17" valign="middle" bgcolor="#dfe6f7" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;font-size:8.0pt;'>차단여부</span></p>
                                    </td>
                                    <td height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;letter-spacing:-1.0pt;font-size:7.0pt;'><c:out value="${result.brkYn eq 'Y' ? '차단' : '미차단' }" /></span></p>
                                    </td>
                                    <td height="17" valign="middle" bgcolor="#dfe6f7" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;font-size:8.0pt;'>사용여부</span></p>
                                    </td>
                                    <td height="17" valign="middle" style='border-left:solid #000000 0.4pt;border-right:solid #000000 0.4pt;border-top:solid #000000 0.4pt;border-bottom:solid #000000 0.4pt;padding:1.4pt 1.4pt 1.4pt 1.4pt'>
                                        <p CLASS=HStyle0 style='text-align:center;line-height:100%;'><span style='font-family:"맑은 고딕";font-weight:bold;letter-spacing:-1.0pt;font-size:7.0pt;'><c:out value="${result.useYn eq 'Y' ? '사용' : '미사용' }" /></span></p>
                                    </td>
                                </tr>
                            </TABLE>
                        </p>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </TABLE>
</body>
</html>