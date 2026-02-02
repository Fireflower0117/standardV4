<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<script type="text/javascript">
$(function(){
	<%--엑셀 보고서 다운로드--%>
	$('#btn_excel').on('click', function(){
		$("#domainUrl").val("<c:out value='${seoVO.domainUrl}' />");
		$("#seoSerno").val("<c:out value='${seoVO.seoSerno}' />");
		$("#searchCondition").val("<c:out value='${seoVO.seoType}' />");
		fncExcelDown();
	});

	<%-- 데이터 없을때 td colspan 잡기 --%>
	$(".no_data").attr("colspan", $("th").length);

	<%-- FAQ 박스 조절 --%>
	$('.js_accCont').hide();
	if ($('[class*="js_accWrap"]').length) {
		$('.js_accHead').click(function () {
			// if each
			if ($(this).parents('[class*="js_accWrap"]').hasClass('js_accWrap_each')) {
				$(this).parents('.js_accBox').siblings('.js_accBox').removeClass('open');
				$(this).parents('.js_accBox').siblings('.js_accBox').find('.js_accCont').stop().slideUp(200);
			}

			// open
			if ($(this).parents('.js_accBox').hasClass('open')) {
				$(this).parents('.js_accBox').removeClass('open').find('.js_accCont').stop().slideUp(200);
			} else {
				$(this).parents('.js_accBox').addClass('open').find('.js_accCont').stop().slideDown(200);
			}
			return false;
		});
	}
	  
	<c:if test="${seoVO.conYn eq 'Y'}" >
		chart1 = Highcharts.chart('pieChart1_1', {
		    chart: {
		        type: 'pie',
		        height: '300', // 차트 높이 지정
		    },
		    navigation: false, // 차트 메뉴 버튼 유/무
		    credits: {
		        enabled: false // 하단 하이차트 주소 숨김
		    },
		    title: {
		        text: '<strong><fmt:formatNumber value="${seoVO.totalScore}" pattern="#,##0"/></strong><span style="font-size: 16px;color: #000;">%</span>', // 타이틀에 값을 넣어 커스텀
		        useHTML: true,
		        verticalAlign: 'middle', // title 정렬방식. top, middle, bottom
		        y: 45, // y축 기준 위치
		        x: -40, // x축 기준 위치
		        style: {
		            fontSize: '60px',
		            fontWeight: 'bold',
		            fontFamily: 'Pretendard',
		            color: '#29285c',
		        }
		    },
		    subtitle: {
		    	text: '<strong>최적화</strong>',
				useHTML: true,
				verticalAlign: 'middle', // title 정렬방식. top, middle, bottom
				x: -42, // x축 기준 위치
				y: 45, // y축 기준 위치
				style: {
					color: '#181c2d',
					fontSize: '18px',
					fontFamily: 'Pretendard',
				},
		    },
		    plotOptions: {
		        pie: {
		            innerSize: 150, // 원형 차트 내부 공간 크기 지정 (도넛형)
		            showInLegend: true, // pie 차트에서는 기본값 false
		            dataLabels: {
		                enabled: false // 라벨 숨기기(기본값 true)
		            },
		        }
		    },
		    series: [{
		    	name: '최적화',
				data: [
				{
					name: '적합',
					y: <c:out value="${seoVO.fitCnt}"/>,
					color: "#3bae6c"
				},	
				{
					name: '미흡',
					y: <c:out value="${seoVO.subparCnt}"/>,
					color: "#fbbe19"
				}, {
					name: '부적합',
					y: <c:out value="${seoVO.unfitCnt}"/>,
					color: "#ff4556"
				} ]
		    }],
		    legend: {
				title: { // legend title
					text: '최적화',
					style: {
						fontSize: '20px',
						fontWeight: 'bold',
						fontFamily: 'Pretendard',
						textAlign: 'left',
						whiteSpace: 'normal'
					}
				},
				width: 65, // legend 영역 width. default: 좌우 legend의 경우 차트 너비의 절반 / 상하 legend의 경우 차트 너비
				maxHeight: 147, // legend 영역 max height. 높이가 줄어들면 navigation이 생김
				itemStyle: { // legend 아이템 스타일
					fontSize: '15px',
					fontWeight: '400',
					fontFamily: "pretendard",
				},
				itemMarginTop: 5, // legend가 vertical일때 아이템 사이 간격
				align: 'right', // 가로정렬. left, center(기본값), right
				layout: 'proximate', // legend 아이템 정렬방식. horizontal(기본값), vertical, proximate(차트에 가장 가깝게 배치)
				y: 50, // y축 기준 위치
				navigation: {
					enabled: true,
					animation: true, // 슬라이드될 때 애니메이션 적용 유무. 기본값: true
					arrowSize: 10,
					inactiveColor: '#ddd',
					activeColor: '#00b974',
				}
			},
		});

	<%--건수 화면 표시--%>
	let totalOptimized =0;
	let totalWarnings =0;
	let totalErrors =0;
	 $(".js_accBox").each(function() {
		let target = $(this).children(".js_accHead").find("a>p");
		let greenCnt = $(this).children(".js_accCont").find(".greenBk").length;
		let yellowCnt = $(this).children(".js_accCont").find(".yellowBk").length;
		let redCnt = $(this).children(".js_accCont").find(".redBk").length;

		//초기세팅
		let txt = "";
		if (greenCnt > 0) {
			totalOptimized += greenCnt;
			txt += "<span class=\"state green\">" + greenCnt + "</span>";
		}
		if (yellowCnt > 0) {
			totalWarnings += yellowCnt;
			txt += "<span class=\"state yellow\">" + yellowCnt + "</span>";
		}
		if (redCnt > 0) {
			totalErrors += redCnt;
			txt += "<span class=\"state red\">" + redCnt + "</span>";
		}

		target.append(txt);
	}); 
	 
	 $(".data.success").find(".num").html(totalOptimized);
	 $(".data.warning").find(".num").html(totalWarnings);
	 $(".data.danger").find(".num").html(totalErrors);
	 
	</c:if>

});
</script>
<div>
<input type="hidden" id="seoSernoTemp" value="<c:out value="${seoVO.seoSerno}" />" />
<c:choose>
	<c:when test="${seoVO.conYn eq 'Y'}" >
		<div class="board_top mar_t35">
		<div class="board_left">
			<h5 class="lg_tit"><i class="xi-dashboard"></i> 성능 문제 진단하기</h5>
		</div>
		<div class="board_right">
			<button type="button" id="btn_excel" class="btn btn_excel">보고서 다운로드</button>
		</div>
	</div>
	<!-- 240227 수정 -->
	<div class="score_area">
		<div class="chart_area"><div id="pieChart1_1"></div></div>
		<div class="chart_data">
			<div class="data success">
				<span class="ic"><i class="xi-check-circle-o"></i></span>
				<span class="txt">적합</span>
				<span class="eng">Optimized</span>
				<span class="num"></span>
			</div>
			<div class="data warning">
				<span class="ic"><i class="xi-warning itagInit"></i></span>
				<span class="txt">미흡</span>
				<span class="eng">Warnings</span>
				<span class="num"></span>
			</div>
			<div class="data danger">
				<span class="ic"><i class="xi-close-circle-o"></i></span>
				<span class="txt">부적합</span>
				<span class="eng">Errors</span>
				<span class="num"></span>
			</div>
		</div>
	</div>
	<!--// 240227 수정 -->
	<div class="msg_box mar_t20"><!-- 여기에 필요한경우 red, yellow, green, blue 클래스 추가 -->
		<p>이 진단은 웹과 앱의 SEO 내용을 검증한 결과입니다.<br> 모든 사항을 전부 감지할 수는 없으므로, 권장사항은 참고용으로 사용하시기 바랍니다.</p>
	</div>
	<!-- 범례 추가 부분 -->
		<div class="board_top">
			<div class="board_left">
				<h5 class="md_tit">메타 명세서</h5>
			</div>
			<div class="board_right">
				<div class="state_legend">
					<span class="radius greenBk"></span><span class="legend_label">적합</span>
					<span class="radius yellowBk"></span><span class="legend_label">미흡</span>
					<span class="radius redBk"></span><span class="legend_label">부적합</span>
				</div>
			</div>
		</div>
		<!--// 추가 끝 -->
	<div class="faq_list js_accWrap ">
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.metaTageResult eq '적합' ? 'success' : (seoVO.metaTageResult eq '부적합' ? 'danger' : 'warning')}">
				<a href="javascript:void(0)">
					<span><i class="${seoVO.metaTageResult eq '적합' ? 'xi-check-circle' : ( seoVO.metaTageResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
	                <p>meta tag가 적절히 사용되었는가? </p>
	                <i class="xi-angle-down-min"></i>
	            </a>
	        </dt>
			<dd class="js_accCont cusor">
				<table class="data_tbl">
	            	<colgroup>
	            		<col style="width: 45%;">
	            		<col style="width: 45%;">
	            		<col style="width: 10%;">
	            	</colgroup>
	            	<thead>
           				<tr>
	            			<th>카테고리</th>
	            			<th>상세내용</th>
	            			<th>적합여부</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta name=\"title\" > 요소" /></td>
	            			<td class="l pad_l25" >검색 결과에 노출되고 키워드 강조를 통해 검색 엔진에서의 순위를 높이며,<br/> 소셜 미디어 공유에도 도움이 됩니다.</td>
	            			<td><div data-tableId="titleMeta" class="radius optView <c:out value="${seoVO.titleMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<c:if test="${seoVO.seoType eq '2' }" >
		            		<tr>
		            			<td class="l pad_l25" >문서에 &lt;meta&gt; 태그 [title], [description] 속성 내용이 중복 여부.</td>
		            			<td class="l pad_l25" >서로 다른 제목, 설명을 사용하는 것은 각 페이지의 콘텐츠를 더 잘 설명하고<br/>  다양한 키워드를 포함할 수 있는 기회를 제공합니다.<br/> 동일한 내용을 사용하면 키워드 다양성이 부족해질 수 있습니다.</td>
		            			<td><div data-tableId="metaTitleEqual" class="radius optView <c:out value="${seoVO.metaTitleEqualYn eq '적합' ? 'greenBk' : 'redBk' }" />"></div></td>
		            		</tr>
		            		<tr>
		            			<td class="l pad_l25" >문서에 &lt;meta&gt; 태그 [title] 요소 텍스트 길이 적정 여부</td>
		            			<td class="l pad_l25" rowspan="2" >너무 긴 내용은 주요 키워드를 앞쪽에 포함시키기 어렵게 만들 수 있습니다.</br> 이는 검색 엔진이 해당 페이지의 주제를 정확하게 이해하는 데 어려움을 줄 수 있습니다.</td>
		            			<td><div data-tableId="titleMetaOpt" class="radius optView <c:out value="${seoVO.metaTitleOptYn eq '적합' ? 'greenBk' : 'redBk' }" />"></div></td>
		            		</tr>
		            		<tr>
		            			<td class="l pad_l25" >문서에 &lt;meta&gt; 태그 [description] 요소 텍스트 길이 적정 여부</td>
		            			<td><div data-tableId="metaDescrpOpt" class="radius optView <c:out value="${seoVO.metaDescrpOptYn eq '적합' ? 'greenBk' : 'redBk' }" />"></div></td>
		            		</tr>
	            		</c:if>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta name=\"description\" > 요소" /></td>
	            			<td class="l pad_l25" >검색 결과에 노출되어 사용자의 클릭 유도를 돕고,<br/> 페이지의 주요 키워드를 강조하여 검색 엔진의 이해를 도와줍니다</td>
	            			<td><div data-tableId="descriptionMeta" class="radius optView <c:out value="${seoVO.descriptionMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta charset > 요소" /></td>
	            			<td class="l pad_l25" >페이지의 문자 인코딩을 지정하여 검색 엔진이 페이지를 올바르게 해석하고<br/> 크롤링할 수 있도록 도와줍니다</td>
	            			<td><div data-tableId="charsetMeta" class="radius optView <c:out value="${seoVO.charsetMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta http-equiv=\"X-UA-Compatible\" > 요소" /></td>
	            			<td class="l pad_l25" >브라우저 호환성을 보장하여 페이지의 일관된 렌더링을 유지하는데 도움이 됩니다.</td>
	            			<td><div data-tableId="uaCompatibleMeta" class="radius optView <c:out value="${seoVO.uaCompatibleMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta name=\"viewport\" > 요소" /></td>
	            			<td class="l pad_l25" >모바일 장치에서 웹 페이지가 올바르게 표시되도록 보장함으로써 모바일 최적화에 도움이 됩니다.</td>
	            			<td><div data-tableId="viewportMeta" class="radius optView <c:out value="${seoVO.viewportMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            	</tbody>
	            </table>		
			</dd>
		</dl>
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.sitemapResult eq '적합' ? 'success' : (seoVO.sitemapResult eq '부적합' ? 'danger' : 'warning')}">
				<a href="javascript:void(0)">
					<span><i class="${seoVO.sitemapResult eq '적합' ? 'xi-check-circle' : ( seoVO.sitemapResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
					<p>사이트맵(sitemap.xml)이 존재하는가?</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
		    <dd class="js_accCont cusor">
	            <span><div class="radius <c:out value="${seoVO.sitemapResult eq '적합' ? 'greenBk' : 'redBk' }" />"></div></span>
	            <c:out value="sitemap.xml 파일이 ${seoVO.sitemapResult eq '적합' ? '유효함' : '없음'}" />
	        </dd>
		</dl>
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.robotsResult eq '적합' ? 'success' : (seoVO.robotsResult eq '부적합' ? 'danger' : 'warning')}">
				<a href="javascript:void(0)">
					<span><i class="${seoVO.robotsResult eq '적합' ? 'xi-check-circle' : (seoVO.robotsResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
					<p>robots.txt가 존재하는가?</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
			<dd class="js_accCont cusor">
	            <span><div class="radius <c:out value="${seoVO.robotsResult eq '적합' ? 'greenBk' : 'redBk' }" />"></div></span>
	            <c:out value="robots.txt 파일이 ${seoVO.robotsResult eq '적합' ? '유효함' : '없음'}" />
	        </dd>
		</dl>
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.snsOptiResult eq '적합' ? 'success' : (seoVO.snsOptiResult eq '부적합' ? 'danger' : 'warning')}">
				<a href="javascript:void(0)">
					<span><i class="${seoVO.snsOptiResult eq '적합' ? 'xi-check-circle' : (seoVO.snsOptiResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
					<p>소셜미디어 최적화가 되었는가?</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
			<dd class="js_accCont cusor">
				<table class="data_tbl">
	            	<colgroup>
	            		<col style="width: 45%;">
	            		<col style="width: 45%;">
	            		<col style="width: 10%;">
	            	</colgroup>
	            	<thead>
           				<tr>
	            			<th>카테고리</th>
	            			<th>상세내용</th>
	            			<th>적합여부</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta property=\"og:type\" > 요소" /></td>
	            			<td class="l pad_l25" rowspan="5" >소셜 미디어에서 공유된 콘텐츠는 검색 엔진에도 영향을 미칠 수 있습니다.<br/> 적절한 Open Graph 태그를 사용하여 콘텐츠를 설명하고 이미지를 제공하면 엔진 최적화에 도움이 됩니다.</td>
	            			<td><div data-tableId="ogTypeMeta" class="radius optView <c:out value="${seoVO.ogTypeMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta property=\"og:title\" > 요소" /></td>
	            			<td><div data-tableId="ogTitleMeta" class="radius optView <c:out value="${seoVO.ogTitleMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta property=\"og:description\" > 요소" /></td>
	            			<td><div data-tableId="ogDescriptionMeta" class="radius optView <c:out value="${seoVO.ogDescriptionMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta property=\"og:image\" > 요소" /></td>
	            			<td><div data-tableId="ogImageMeta" class="radius optView <c:out value="${seoVO.ogImageMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta property=\"og:url\" > 요소" /></td>
	            			<td><div data-tableId="ogUrlMeta" class="radius optView <c:out value="${seoVO.ogUrlMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
            		</tbody>
           		</table>
			</dd>
		</dl>
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.urlStructResult eq '적합' ? 'success' : (seoVO.urlStructResult eq '부적합' ? 'danger' : 'warning')}">
				<a href="javascript:void(0)">
					<span><i class="${seoVO.urlStructResult eq '적합' ? 'xi-check-circle' : (seoVO.urlStructResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
					<p>URL 주소가 구조화 되었는가?</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
			<dd class="js_accCont cusor">
				<table class="data_tbl">
	            	<colgroup>
	            		<col style="width: 45%">
	            		<col style="width: 45%">
	            		<col style="width: 10%">
	            	</colgroup>
	            	<thead>
           				<tr>
	            			<th>카테고리</th>
            				<th>상세내용</th>
	            			<th>적합여부</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		<tr>
	            			<td class="l pad_l25" >url 하이픈 존재 여부</td>
	            			<td class="l pad_l25" ><c:out value="${seoVO.urlHyphenYn eq 'Y' ? '유효한 URL 입니다.' : '_대신 \"-\"(하이픈) 사용권장' }" /></td>
	            			<td><div data-tableId="urlHyphen" class="radius optView  <c:out value="${seoVO.urlHyphenYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >url ASCII 사용 여부</td>
	            			<td class="l pad_l25" ><c:out value="${seoVO.urlAscIIYn eq 'Y' ? 'ASCII 사용 중입니다.' : 'UTF-8 사용권장' }" /></td>
	            			<td><div class="radius <c:out value="${seoVO.urlAscIIYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >url 긴 숫자ID 사용 여부</td>
	            			<td class="l pad_l25" ><c:out value="${seoVO.urlLognIdyn eq 'Y' ? '긴 숫자ID를 사용하지 않습니다.' : 'ID 숫자를 사용하는 경우 10자리 미만으로 줄여주세요.' }" /></td>
	            			<td><div data-tableId="urlLognId" class="radius optView  <c:out value="${seoVO.urlLognIdyn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            	</tbody>
	            </table>		
			</dd>
		</dl>
	</div>
	
	<!-- 페이지 품질 시작 -->
	<div class="board_top">
		<div class="board_left">
			<h5 class="md_tit">페이지 품질</h5>
		</div>
	</div>
	<div class="faq_list js_accWrap">
		<c:if test="${seoVO.seoType eq '2'}">
			<dl class="js_accBox">
				<dt class="js_accHead <c:out value="${seoVO.frameUseResult eq '적합' ? 'success' : 'danger' }"/> " >
					<a href="javascript:void(0)">
						<span><i class="<c:out value="${seoVO.frameUseResult eq '적합' ? 'xi-check-circle' : 'xi-close-circle' }"/> itagInit"></i></span>
						<p>프레임 (Frames)</p>
						<i class="xi-angle-down-min"></i>
					</a>
				</dt>
				<dd class="js_accCont cusor">
					<span><div class="radius <c:out value="${seoVO.frameUseResult eq '적합' ? 'greenBk' : 'redBk' }" />"></div></span>
		            <c:out value="페이지에 프레임 (Frames)이 ${seoVO.frameUseResult eq '적합' ? '없음' : '있음'}" />
				</dd>
			</dl>
		</c:if>
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.imgOptiResult eq '적합' ? 'success' : (seoVO.imgOptiResult eq '부적합' ? 'danger' : 'warning')}">
				<a href="javascript:void(0)">
					<span><i class="${seoVO.imgOptiResult eq '적합' ? 'xi-check-circle' : (seoVO.imgOptiResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
					<p>이미지 최적화가 되었는가?</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
			<dd class="js_accCont cusor">
				<table class="data_tbl">
	            	<colgroup>
	            		<col style="width: 45%;">
	            		<col style="width: 45%;">
	            		<col style="width: 10%;">
	            	</colgroup>
	            	<thead>
           				<tr>
	            			<th>카테고리</th>
	            			<th>상세내용</th>
	            			<th>적합여부</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		<tr>
	            			<td class="l pad_l25" >올바른 이미지 형식</td>
	            			<td class="l pad_l25" ><c:out value="${seoVO.imgUprightUseMessage}"/></td>
	            			<td><div data-tableId="imgUpright" data-tdIndex="<c:out value='${seoVO.seoSerno}' />" class="radius optSubList <c:out value="${seoVO.imgUprightUseResult eq '적합' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >이미지 파일 이름 최적화</td>
	            			<td class="l pad_l25" ><pre><c:out value="${seoVO.imgNmOptiMessage}"/></pre></td>
	            			<td><div data-tableId="imgNmOpti" data-tdIndex="<c:out value='${seoVO.seoSerno}' />" class="radius optSubList <c:out value="${seoVO.imgNmOptiResult eq '적합' ? 'greenBk' : (seoVO.imgNmOptiResult eq '부적합' ? 'redBk' : 'yellowBk') }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >반응형 이미지 최적화</td>
	            			<td class="l pad_l25" ><c:out value="${seoVO.imgResponOptiMessage}"/></td>
	            			<td><div data-tableId="imgResponOpti" class="radius optView <c:out value="${seoVO.imgResponOptiResult eq '적합' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >이미지 용량 최적화</td>
	            			<td class="l pad_l25" ><c:out value="${seoVO.imgOverMessage}"/></td>
	            			<td><div data-tableId="imgOver" class="radius optSubList <c:out value="${seoVO.imgOverYn eq 'Y' ? 'greenBk' : 'redBk' }" /> "></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >이미지 캡션 사용</td>
	            			<td class="l pad_l25" ><c:out value="${seoVO.imgCaptionMessage}"/></td>
	            			<td><div data-tableId="imgCaption" class="radius optSubList <c:out value="${seoVO.imgCaptionResult eq '적합' ? 'greenBk' : (seoVO.imgCaptionResult eq '부적합' ? 'redBk' : 'yellowBk') }" />"></div></td>
	            		</tr>
	            	</tbody>
	            </table>
			</dd>
		</dl>
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.mobileYn eq '적합' ? 'success' : (seoVO.mobileYn eq '부적합' ? 'danger' : 'warning')}">
	            <a href="javascript:void(0)">
					<span><i class="${seoVO.mobileYn eq '적합' ? 'xi-check-circle' : (seoVO.mobileYn eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
	                <p>모바일 친화적인가?</p>
	                <i class="xi-angle-down-min"></i>
	            </a>
	        </dt>
	        <dd class="js_accCont cusor">
	        	<table class="data_tbl">
	            	<colgroup>
	            		<col style="width: 45%;">
	            		<col style="width: 45%;">
	            		<col style="width: 10%;">
	            	</colgroup>
	            	<thead>
           				<tr>
	            			<th>카테고리</th>
	            			<th>상세내용</th>
	            			<th>적합여부</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta name=\"viewport\" > 요소" /></td>
	            			<td class="l pad_l25" >모바일 장치에서 웹 페이지가 올바르게 표시되도록 보장함으로써 모바일 최적화에 도움이 됩니다.</td>
	            			<td><div data-tableId="viewportMeta" class="radius optView <c:out value="${seoVO.viewportMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta name=\"title\" > 요소" /></td>
	            			<td class="l pad_l25" >검색 결과에 노출되고 키워드 강조를 통해 검색 엔진에서의 순위를 높이며,<br/> 소셜 미디어 공유에도 도움이 됩니다.</td>
	            			<td><div data-tableId="titleMeta" class="radius optView <c:out value="${seoVO.titleMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <meta name=\"description\" > 요소" /></td>
	            			<td class="l pad_l25" >검색 결과에 노출되어 사용자의 클릭 유도를 돕고,<br/>페이지의 주요 키워드를 강조하여 검색 엔진의 이해를 도와줍니다.</td>
	            			<td><div data-tableId="descriptionMeta" class="radius optView <c:out value="${seoVO.descriptionMetaYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="HTTP 상태코드" /></td>
	            			<td class="l pad_l25" >유효하지 않은 상태코드는 검색 엔진에서 웹 페이지의 인덱싱과 순위에 <br/>부정적인 영향을 미칠 수 있습니다.</td>
	            			<td><div class="radius <c:out value="${seoVO.conYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="robots.txt 존재 여부" /></td>
							<td class="l pad_l25" >검색 엔진 크롤러의 액세스를 제어하고, 크롤링 프로세스를 최적화하고,<br/> 검색 결과의 품질을 개선하며, 프라이버시를 보호할 수 있습니다.</td>
							<td>
								<c:choose>
									<c:when test="${seoVO.robotsResult eq '적합'}">
										<div class="radius <c:out value="${seoVO.robotsResult eq '적합' ? 'greenBk' : 'redBk' }" />"></div>
									</c:when>
									<c:otherwise>
										<a title="구글 robots.txt 작성법" href="https://developers.google.com/search/docs/crawling-indexing/robots/create-robots-txt?hl=ko" target="_blank" >
											<div class="radius <c:out value="${seoVO.robotsResult eq '적합' ? 'greenBk' : 'redBk' }" />"></div>
										</a>
									</c:otherwise>
								</c:choose>
							</td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="img의 alt태그 존재여부" /></td>
	            			<td class="l pad_l25" >검색엔진은 이미지 파일 자체를 읽을 수 없기 때문에<br/> Alt 속성을 통해서 이미지를 이해하고 색인화합니다. </td>
	            			<td><div data-tableId="imgCaption" class="radius optSubList <c:out value="${seoVO.imgCaptionResult eq '적합' ? 'greenBk' : (seoVO.imgCaptionResult eq '부적합' ? 'redBk' : 'yellowBk') }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <link rel> [hreflang] 요소 여부" /></td>
	            			<td class="l pad_l25" >웹 사이트의 다국어 및 지역화 페이지를 효과적으로 관리 및 엔진 및 사용자들에게<br/> 적절한 페이지를 제공합니다.</td>
	            			<td><div data-tableId="hreflang" class="radius optView <c:out value="${seoVO.hreflangYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" ><c:out value="문서에 <link rel=canonical> 요소 여부" /></td>
	            			<td class="l pad_l25" >중복 콘텐츠를 방지하고 검색 엔진에게 적절한 페이지를 지정함으로써<br/> 검색 결과의 품질을 향상하는데 도움이 됩니다.</td>
	            			<td><div data-tableId="canonical" class="radius optView <c:out value="${seoVO.canonicalYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
						<tr>
							<td class="l pad_l25" >글꼴 크기 최적화</td>
							<td class="l pad_l25" >모바일 퍼스트 인덱싱을 채택하여 모바일 버전의 웹사이트를 우선적으로 색인화합니다.</br>작은 폰트는 모바일 환경에서 특히 문제가 될 수 있습니다.</td>
							<td><div data-tableId="fontSizeOpt" class="radius optSubList <c:out value="${seoVO.fontSizeOptYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
						</tr>
	            	</tbody>
	            </table>	
	        </dd>
	    </dl>
		<dl class="js_accBox">
			<dt class="js_accHead ${seoVO.loadTimeResult eq '적합' ? 'success' : (seoVO.loadTimeResult eq '부적합' ? 'danger' : 'warning')}">
				<a href="javascript:void(0)">
					<span><i class="${seoVO.loadTimeResult eq '적합' ? 'xi-check-circle' : (seoVO.loadTimeResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') } itagInit"></i></span>
					<p>페이지 로딩속도</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
			<dd class="js_accCont cusor">
				<span><div class="radius <c:out value="${seoVO.loadTimeResult eq '적합' ? 'greenBk' : (seoVO.loadTimeResult eq '부적합' ? 'redBk' : 'yellowBk') }" />"></div></span>
				<c:out value="페이지 로딩속도는 ${seoVO.loadTime} ms 입니다."/>
			</dd>
		</dl>
	</div>
	<!-- 페이지 품질 끝 -->
	
	<!-- 페이지 구조 시작 -->
	<div class="board_top">
		<div class="board_left">
			<h5 class="md_tit">페이지 구조</h5>
		</div>
	</div>
	<div class="faq_list js_accWrap">
		<dl class="js_accBox">
			<dt class="js_accHead <c:out value="${seoVO.headingOneResult eq '적합' ? 'success' : (seoVO.headingOneResult eq '부적합' ? 'danger' : 'warning')}" />">
				<a href="javascript:void(0)">
					<span><i class="<c:out value="${seoVO.headingOneResult eq '적합' ? 'xi-check-circle' : ( seoVO.headingOneResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') }" /> itagInit"  ></i></span>
					<p>표제(Headings) 최적화</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
		    <dd class="js_accCont cusor">
		    	<table class="data_tbl">
	            	<colgroup>
	            		<col style="width: 45%;">
	            		<col style="width: 45%;">
	            		<col style="width: 10%;">
	            	</colgroup>
	            	<thead>
           				<tr>
	            			<th>카테고리</th>
	            			<th>상세내용</th>
	            			<th>적합여부</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		<tr>
	            			<td class="l pad_l25" >H1 표제 (H1 Heading) 여부</td>
	            			<td class="l pad_l25" rowspan="2" >페이지의 주요 키워드를 강조하고 페이지의 구조를 명확하게 할 수 있습니다.<br/> 추가로 페이지의 내용을 나타내기 위해 h2, h3 등의 보조 제목 태그를 사용할 수 있습니다.</td>
	            			<td><div data-tableId="headingOne" class="radius optView  <c:out value="${seoVO.headingOneYn ne '부적합' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
            			<tr>
	            			<td class="l pad_l25" >H1 이외의 표제 (Headings)이(가) 여부</td>
	            			<td><div data-tableId="headingOther" class="radius optView  <c:out value="${seoVO.headingOtherYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >H1 표제 (H1 Heading) 숫자 최적화</td>
	            			<td class="l pad_l25" >여러 개의 h1 태그가 있을 경우 페이지의 주요 키워드가 분산되어<br/> 검색 엔진이 페이지의 주제를 파악하기 어려워집니다.</td>
	            			<td><div data-tableId="headingOneDup" class="radius optView  <c:out value="${seoVO.headingOneYn eq '적합' ? 'greenBk' : (seoVO.headingOneYn eq '부적합' ? 'redBk' : 'yellowBk') }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >H1 표제 (H1 Heading) 빈 텍스트 여부</td>
	            			<td class="l pad_l25" rowspan="2" >headings 태그를 사용하지 않으면 검색 엔진이 페이지의 콘텐츠를 올바르게 이해하고<br/> 색인화하는 데 어려움을 겪을 수 있습니다.<br/>페이지가 검색 결과에 표시되지 않거나 올바르게 랭킹되지 않을 수 있을 수 있습니다.</td>
	            			<td><div data-tableId="headingOneCont" data-tdIndex="<c:out value='${seoVO.seoSerno}' />" class="radius optSubList <c:out value="${seoVO.headingOneContYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >H1 이외의 표제 (Headings) 빈 텍스트 여부</td>
	            			<td><div data-tableId="headingOtherCont" data-tdIndex="<c:out value='${seoVO.seoSerno}' />" class="radius optSubList <c:out value="${seoVO.headingOtherContYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            	</tbody>
	            </table>
	        </dd>
		</dl>
		<dl class="js_accBox">
			<dt class="js_accHead <c:out value="${seoVO.linkOptResult eq '적합' ? 'success' : (seoVO.linkOptResult eq '부적합' ? 'danger' : 'warning')}" />">
				<a href="javascript:void(0)">
					<span><i class="<c:out value="${seoVO.linkOptResult eq '적합' ? 'xi-check-circle' : ( seoVO.linkOptResult eq '부적합' ? 'xi-close-circle' : 'xi-warning') }" /> itagInit"  ></i></span>
					<p>링크 최적화</p>
					<i class="xi-angle-down-min"></i>
				</a>
			</dt>
		    <dd class="js_accCont cusor">
		    	<table class="data_tbl">
	            	<colgroup>
	            		<col style="width: 45%;">
	            		<col style="width: 45%;">
	            		<col style="width: 10%;">
	            	</colgroup>
	            	<thead>
           				<tr>
	            			<th>카테고리</th>
	            			<th>상세내용</th>
	            			<th>적합여부</th>
	            		</tr>
	            	</thead>
	            	<tbody>
	            		<tr>
	            			<td class="l pad_l25" >onclick 및 href에 함수 사용 여부</td>
	            			<td class="l pad_l25" >링크 표현시 javascript를 사용한다면 검색로봇이 링크를 해석하기 어렵습니다.</td>
	            			<td><div data-tableId="linkOptFnc" data-tdIndex="<c:out value='${seoVO.seoSerno}' />" class="radius optSubList <c:out value="${seoVO.linkOptFncYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >href 적정 사용 여부</td>
	            			<td class="l pad_l25" >검색로봇이 구조를 올바르게 이해하지 못하고 웹페이지를 적절하게 색인화하지 못할 수 있습니다.</td>
	            			<td><div data-tableId="linkOptATag" data-tdIndex="<c:out value='${seoVO.seoSerno}' />" class="radius optSubList <c:out value="${seoVO.linkOptATagYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            		<tr>
	            			<td class="l pad_l25" >a태그 빈 텍스트 여부</td>
	            			<td class="l pad_l25" >내용이 없는 링크는 검색 엔진이 페이지의 콘텐츠와 관련된 링크를 이해하고 적절하게 색인화하는 데 어려움을 줄 수 있습니다.</td>
	            			<td><div data-tableId="linkOptATagTxt" data-tdIndex="<c:out value='${seoVO.seoSerno}' />" class="radius optSubList <c:out value="${seoVO.linkOptATagTxtYn eq 'Y' ? 'greenBk' : 'redBk' }" />"></div></td>
	            		</tr>
	            	</tbody>
            	</table>
           	</dd>
          	</dl>	
	</div>
	<!-- 페이지 구조 끝 -->
	</c:when>
	<c:otherwise>
		<div class="board_top">
			<div class="board_left">
				<h5 class="md_tit">에러 정보</h5>
			</div>
		</div>
		<div class="faq_list js_accWrap">
			<dl class="js_accBox">
				<dt class="js_accHead danger no cursor" >
					<a href="javascript:void(0)">
						<span><i class="xi-close-circle itagInit"></i></span>
						<p>URL 정보 이상 또는 데이터 수집에 실패 했습니다.</p>
					</a>
				</dt>
			</dl>
		</div>
		<!-- 페이지 구조 끝 -->
	</c:otherwise>
</c:choose>
</div>	
	

