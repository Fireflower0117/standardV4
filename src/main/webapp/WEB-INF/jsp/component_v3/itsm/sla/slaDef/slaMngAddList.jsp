<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>

<script type="text/javaScript">
	$(document).ready(function(){

		let itmSeqo = "";

		<c:forEach var="reuslt" begin="0" end="13" varStatus="status">
			fncMonth('bgngYm_'+'${status.index}')
			$("#bgngYm_" + "${status.index}").val($("#searchbgngYm").val())
			fncCodeList("DX", "select", "선택", "", "", "idxiSeCd_"+'${status.index}', "", "ASC");
		</c:forEach>

		<c:choose>
			<c:when test="${fn:length(resultList) > 0}">
				<c:forEach var="result" items="${resultList}" varStatus="status">
					itmSeqo = "${result.itmSeqo}";
					$("#idxiSeCd_"+itmSeqo).val("${result.idxiSeCd}");

					<c:if test="${fn:length(resultList) ne 14}">
						$("#svrngSubSn_"+itmSeqo).val("${result.svrngSubSn}");
						$("#itmCn_"+itmSeqo).val("${result.itmCn}");
						$("#itmScrng_"+itmSeqo).val("${result.itmScrng}");
						$("#bgngYm_"+itmSeqo).val("${result.bgngYm}");

						$("#regId_"+itmSeqo).text(
								<c:choose>
									<c:when test="${not empty result.mdfrNm}">
										"${result.mdfrNm}"
									</c:when>
									<c:otherwise>
										"${result.rgtrNm}"
									</c:otherwise>
								</c:choose>);
						$("#regDt_"+itmSeqo).text(
								<c:choose>
									<c:when test="${not empty result.mdfcnDt}">
										"${result.mdfcnDt}"
									</c:when>
									<c:otherwise>
										"${result.regDt}"
									</c:otherwise>
								</c:choose>);

						$("#btn_update_"+itmSeqo).html('<a href="javascript:void(0);" class="btn btn_sml btn_rewrite" onclick="fncSubmitItm(\'${result.itmSeqo}\',\'not\');">수정</a>');
					</c:if>
				</c:forEach>
			</c:when>
		</c:choose>

		$("#itmCn_0").val("서비스 요구 납기 준수율")
		$("#itmCn_1").val("서비스 요구 처리율")
		$("#itmCn_2").val("서비스 장애 적기 해결율")
		$("#itmCn_3").val("긴급 서비스요구 처리율")
		$("#itmCn_4").val("SW 응답속도")
		$("#itmCn_5").val("신규개발 후 해당 SW 장애율")
		$("#itmCn_6").val("동일 장애 발생율")
		$("#itmCn_7").val("프로그램 장애 및 오류발생 건수")
		$("#itmCn_8").val("변경 서비스 적용 후 장애율")
		$("#itmCn_9").val("시스템 개선 제안")
		$("#itmCn_10").val("인력 유지율")
		$("#itmCn_11").val("현업 담당자 만족도")
		$("#itmCn_12").val("보안 관련사고 발생건수")
		$("#itmCn_13").val("보안위반 횟수")

		$("#btn_submit").on("click", function () {
			if(wrestSubmit(document.defaultFrm)){
				itsmFncProc('insert');
			}
		});

		$('.numOnly').on('input', function(event) {
			this.value=this.value.replace(/[^0-9]/g,'');
		});
	})

	<%-- 수정 submit --%>
	function fncSubmitItm(idx, divn){
		let svrngSubSn = $("#svrngSubSn_"+idx).val();
		let itmCn = $("#itmCn_"+idx).val();
		let itmScrng = $("#itmScrng_"+idx).val();
		let idxiSeCd = $("#idxiSeCd_"+idx).val();
		let bgngYm = $("#bgngYm_"+idx).val();

		if(!itmCn || !itmScrng || !idxiSeCd || !bgngYm){
			alert("항목을 모두 입력해주세요.")
			return false
		}

		$.ajax({
			type	 : "patch",
			data	 : {"svrngSubSn": svrngSubSn, "itmCn": itmCn, "itmScrng": itmScrng,
				"idxiSeCd": idxiSeCd, "bgngYm": bgngYm},
			url      : '/itsm/sla/slaDef/itmUpdate',
			dataType : "json",
			success  : function(data) {
				if(data.message == '등록되었습니다.'){
					alert(data.message)

					if(!divn){
						$("#itmCn_view_" + idx).text(itmCn);
						$("#itmScrng_view_" + idx).text(itmScrng);
						$("#idxiSeCd_view_" + idx).text(idxiSeCd == 'DX01' ? '상향지표' : idxiSeCd == 'DX02' ? '하향지표' : idxiSeCd == 'DX03' ? '별도지표' : '');
						$("#bgngYm_view_" + idx).text(bgngYm.substring(0,7));
						fncUpdateItm('cancel', idx)
					}
				}
			}
		});

	}

	<%-- 수정폼, 수정취소 --%>
	function fncUpdateItm(divn, idx){
		if(divn == 'form'){
			$("#itmCn_"+idx).removeClass('hidden')
			$("#itmCn_view_"+idx).addClass('hidden')
			$("#itmScrng_"+idx).removeClass('hidden')
			$("#itmScrng_view_"+idx).addClass('hidden')
			$("#idxiSeCd_"+idx).removeClass('hidden')
			$("#idxiSeCd_view_"+idx).addClass('hidden')
			$("#bgngYm_div_"+idx).removeClass('hidden')
			$("#bgngYm_view_"+idx).addClass('hidden')
			$("#btn_view_"+idx).addClass('hidden')
			$("#btn_update_"+idx).removeClass('hidden')

		}else if(divn == 'cancel'){
			$("#itmCn_"+idx).addClass('hidden')
			$("#itmCn_view_"+idx).removeClass('hidden')
			$("#itmScrng_"+idx).addClass('hidden')
			$("#itmScrng_view_"+idx).removeClass('hidden')
			$("#idxiSeCd_"+idx).addClass('hidden')
			$("#idxiSeCd_view_"+idx).removeClass('hidden')
			$("#bgngYm_div_"+idx).addClass('hidden')
			$("#bgngYm_view_"+idx).removeClass('hidden')
			$("#btn_view_"+idx).removeClass('hidden')
			$("#btn_update_"+idx).addClass('hidden')
		}
	}
</script>

<form:form modelAttribute="searchVO" name="defaultFrm" id="defaultFrm" method="post">
<input type="hidden" name="scrngSn" id="scrngSn" value="${fn:length(resultList) gt 0 ? resultList[0].scrngSn : ''}"/>
<form:hidden path="svcSn" id="svcSn"/>
	<div class="tbl_wrap">
		<table class="tbl_col_type02">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
			<tr>
				<th scope="col">항목</th>
				<th scope="col" colspan="3">세부지표</th>
				<th scope="col">배점</th>
				<th scope="col">지표구분</th>
				<th scope="col">시작년월</th>
				<th scope="col">수정</th>
				<th scope="col">최종수정자</th>
				<th scope="col">변경일자</th>
			</tr>
			</thead>
			<tbody>
			<c:choose>
				<c:when test="${fn:length(resultList) eq 14}">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<c:choose>
								<c:when test="${status.index eq 0}">
									<td rowspan="4">
										적시성
									</td>
								</c:when>
								<c:when test="${status.index eq 4}">
									<td rowspan="6">
										품질
									</td>
								</c:when>
								<c:when test="${status.index eq 10}">
									<td>
										인력
									</td>
								</c:when>
								<c:when test="${status.index eq 11}">
									<td>
										만족도
									</td>
								</c:when>
								<c:when test="${status.index eq 12}">
									<td rowspan="2">
										보안
									</td>
								</c:when>
							</c:choose>
							<td colspan="3">
								<input type="hidden" name="svrngSubSn" id="svrngSubSn_${status.index}" value="${result.svrngSubSn}"/>
								<input type="hidden" name="itmSeqo" id="itmSeqo_${status.index}" value="${status.index}"/>

								<input type="text" name="itmCn" id="itmCn_${status.index}" title="항목내용" class="text w100p hidden" reqruied="reqruied" maxlength="300" value="${result.itmCn}"/>
								<span id="itmCn_view_${status.index}">
									<c:out value="${result.itmCn}"/>
								</span>
							</td>
							<td class="r">
								<input type="text" name="itmScrng" id="itmScrng_${status.index}" title="배점" class="text w50p numOnly hidden" maxlength="2" reqruied="reqruied" value="${result.itmScrng}"/>
								<span id="itmScrng_view_${status.index}">
									<c:out value="${result.itmScrng}"/>
								</span>
							</td>
							<td>
								<select name="idxiSeCd" id="idxiSeCd_${status.index}" reqruied="reqruied" class="select hidden" value="${result.idxiSeCd}"/>
								<span id="idxiSeCd_view_${status.index}">
									<c:out value="${result.idxiSeNm}"/>
								</span>
							</td>
							<td>
								<div class="hidden" id="bgngYm_div_${status.index}">
									<span class="calendar_input w120">
									<input type="text" name="bgngYm" id="bgngYm_${status.index}" title="시작년월" readonly="true" reqruied="reqruied" class="text w120" value="${result.bgngYm}"/>
								</span>
								</div>
								<span id="bgngYm_view_${status.index}">
									<c:out value="${result.bgngYm}"/>
								</span>
							</td>
							<td>
								<div id="btn_view_${status.index}">
									<a href="javascript:void(0);" class="btn btn_i_rewrite" onclick="fncUpdateItm('form', '${status.index}');"><span></span></a>
								</div>
								<div id="btn_update_${status.index}" class="hidden">
									<a href="javascript:void(0);" class="btn btn_sml btn_rewrite" onclick="fncSubmitItm('${status.index}');">수정</a>
									<a href="javascript:void(0);" class="btn btn_sml btn_del" onclick="fncUpdateItm('cancel', '${status.index}');">취소</a>
								</div>
							</td>
							<td>
								<c:choose>
									<c:when test="${not empty result.mdfrNm}">
										<c:out value="${result.mdfrNm}" />
									</c:when>
									<c:otherwise>
										<c:out value="${result.rgtrNm}" />
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${not empty result.mdfcnDt}">
										<c:out value="${result.mdfcnDt}" />
									</c:when>
									<c:otherwise>
										<c:out value="${result.regDt}" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="reuslt" begin="0" end="13" varStatus="status">
						<tr>
							<c:choose>
								<c:when test="${status.index eq 0}">
									<td rowspan="4">
										적시성
									</td>
								</c:when>
								<c:when test="${status.index eq 4}">
									<td rowspan="6">
										품질
									</td>
								</c:when>
								<c:when test="${status.index eq 10}">
									<td>
										인력
									</td>
								</c:when>
								<c:when test="${status.index eq 11}">
									<td>
										만족도
									</td>
								</c:when>
								<c:when test="${status.index eq 12}">
									<td rowspan="2">
										보안
									</td>
								</c:when>
							</c:choose>
							<td colspan="3">
								<input type="hidden" name="itmList[${status.index}].svrngSubSn" id="svrngSubSn_${status.index}"/>
								<input type="hidden" name="itmList[${status.index}].itmSeqo" id="itmSeqo_${status.index}" value="${status.index}"/>

								<input type="text" name="itmList[${status.index}].itmCn" id="itmCn_${status.index}" title="항목내용" class="text w100p " maxlength="300"/>
							</td>
							<td class="r">
								<input type="text" name="itmList[${status.index}].itmScrng" id="itmScrng_${status.index}" title="배점" class="text w50p numOnly" maxlength="2"/>
							</td>
							<td>
								<select name="itmList[${status.index}].idxiSeCd" id="idxiSeCd_${status.index}" class="select w100p"/>
							</td>
							<td>
								<span class="calendar_input w120">
									<input type="text" name="itmList[${status.index}].bgngYm" id="bgngYm_${status.index}" title="시작년월" readonly="true" class="text w120"/>
								</span>
							</td>
							<td>
								<div id="btn_update_${status.index}"></div>
							</td>
							<td id="regId_${status.index}"></td>
							<td id="regDt_${status.index}"></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
</form:form>
<div class="btn_area">
<c:if test="${fn:length(resultList) ne 14}">
	<a href="javascript:void(0)" class="btn btn_mdl btn_save" id="btn_submit">등록</a>
</c:if>
</div>
</section>
<!--// content -->