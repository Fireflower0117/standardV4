<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<jsp:directive.include file="/WEB-INF/jsp/common/incTagLib.jsp"/>
<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<!DOCTYPE HTML>
<html lang="ko-KR">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Pragma" content="no-store"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge">
	<title>오픈노트 - 표준안</title>
	<link rel="icon" href="<c:out value='${pageContext.request.contextPath}'/>/ft/images/common/logo.png" type="image/x-icon">
	<link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/jquery-ui-1.12.1.custom.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ft/lib/swiper/swiper-bundle.min.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ma/css/basic.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ft/css/common.css">
    <link rel="stylesheet" href="<c:out value='${pageContext.request.contextPath}'/>/ft/css/member.css">
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/jquery-ui-1.12.1.custom.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/lib/swiper/swiper-bundle.min.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/common.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/cm.validate.js" charset="utf-8"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/basic.js"></script>
	<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath}'/>/ma/js/board.js"></script>
	<script src="<c:out value='${pageContext.request.contextPath}'/>/ft/js/jquery.cookie.js"></script>
	<script type="text/javascript">
		<%-- 팝업 html 세팅 --%>
		const fncSetPopup = function(resize){
			<%-- window 객체 배열 --%>
			let windowList = [];
			<%-- modal 객체 배열 --%>
			let modalList = [];
			
			<c:forEach items="${popupList }" var="popup" varStatus="status">
				if( $.cookie("n_popYn<c:out value="${popup.popupSerno}"/>") != 'N' ) {
					let popData = {'popupSerno' : '<c:out value="${popup.popupSerno}"/>', 'popupTitlNm' : '<c:out value="${popup.popupTitlNm}"/>', 'popupCtt' : `<c:out value='${popup.popupCtt}' escapeXml='false'/>`
							, 'repImgId' : '<c:out value="${popup.repImgId}"/>', 'fileSeqo' : '<c:out value="${popup.fileSeqo}"/>', 'phclFileNm' : '<c:out value="${popup.phclFileNm}"/>', 'popupTgtCd' : '<c:out value="${popup.popupTgtCd}"/>'
							, 'popupWdthSizeVal' : '<c:out value="${popup.popupWdthSizeVal}"/>', 'popupHghtSizeVal' : '<c:out value="${popup.popupHghtSizeVal}"/>'
							, 'popupLsdMargnVal' : '<c:out value="${popup.popupLsdMargnVal}"/>', 'popupUpndMargnVal' : '<c:out value="${popup.popupUpndMargnVal}"/>'};
					
					if(popData.popupTgtCd == 'PUTG03') {
						modalList.push(popData);
					} else {
						windowList.push(popData);
					}
				}
			</c:forEach>

			for (let index = 0; index < modalList.length; index++) {
			    let el = modalList[index];
			    
			    $.ajax({
			        type: 'post'
			        ,url: '/ft/mainPop.do'
			        ,data: el
			        ,dataType: 'html'
			        ,success: function(data) {
			            fncSetModelCss(data, el, resize);
			        }
			    });
			}
			
			<%-- resize가 될 경우 --%>
			if(resize == null || resize == "") {
				fncSetWindowCss(windowList);
			}
		}
		
		<%-- modal 팝업 css --%>
		const fncSetModelCss = function(html, pop, resize){
			let displayPop = $("#display_view"+ pop.popupSerno);
			
			<%-- modal이 없을 경우 --%>
			if(displayPop.css("display") == undefined) {
				$("#pcPop").append(html);
				displayPop = $("#display_view"+ pop.popupSerno);
			
				<%-- modal 팝업 class 세팅 --%>
				displayPop.removeClass();
				displayPop.addClass("main_pop");
				view_show(pop.popupSerno);
				$("#js_popup_bg").hide();
			}

			<%-- modal 팝업 가로 설정 --%>
			let popWd = fncSetPopSize(pop.popupWdthSizeVal, window.innerWidth);
			displayPop.css('width', popWd + 'px');
			
			<%-- modal 팝업 세로 설정 --%>
			let fixed = $("#pop_header" + pop.popupSerno).outerHeight() + $(".pop_footer").outerHeight();
			let popHgt = fncSetPopSize(pop.popupHghtSizeVal, window.innerHeight);
			$("#pop_content" + pop.popupSerno).css('height', (popHgt - fixed) +'px');

			<%-- modal 팝업 좌우 여백 설정 --%>
			let popX = fncSetPopPosition(parseInt(pop.popupLsdMargnVal), parseInt(popWd), window.innerWidth);
			if( popX < 0 ){
				popX = (( $(window).width() - displayPop.width()) / 2 );
			}
			displayPop.css('left', popX + 'px');
			
			<%-- modal 팝업 상단 여백 설정 --%>
			let popY = fncSetPopPosition(parseInt(pop.popupUpndMargnVal), parseInt(displayPop.height()), window.innerHeight);
			if( popY < 0 ){
				popY = (( $(window).height() - displayPop.height()) / 2 );
			}
			displayPop.css('top', popY + 'px');
			
			$(".main_pop").draggable();
			
			return false;
		}
		
		<%-- window 팝업 css --%>
		const fncSetWindowCss = function(windowList) {
			let length = windowList.length;
			let win = new Array(length);

			if(length === 0){
				return false;
			}
			
			
			<%-- window 열려 있는 메인 페이지에서 이동 할 경우 --%>
			window.onbeforeunload = function() { 
		        if( document.readyState == "complete"){ 
					try {
						for( let i = 0 ; i < length ; i++ ) {
							win[i].close();
						}
					}
					catch (e) {
						console.log(e);
					}
				}
		    };
			
			for( let i = 0 ; i < length ; i++ ) {
			
				<%-- window 팝업이 없을 경우 --%>
				if( !win[i] ) {
					
					$.ajax({
						type: 'post'
				        ,url: '/ft/mainPop.do'
					    ,data : windowList[i]
					    ,dataType : "html"
					    ,success : function(data) {
					    	if( windowList[i].popupTgtCd == 'PUTG01' ){
								win[i] = window.open("mainPop.do", "");
							} else {
								<%-- window 팝업 가로 설정 --%>
								let winWd = fncSetPopSize(windowList[i].popupWdthSizeVal, screen.availWidth, 0);
								
								<%-- window 팝업 세로 설정 --%>
								let winHg = fncSetPopSize(windowList[i].popupHghtSizeVal, screen.availHeight, 0);
								
								<%-- window 팝업 좌우 여백 설정 --%>
								let winX = fncSetPopPosition(parseInt(windowList[i].popupLsdMargnVal), parseInt(winWd), screen.availWidth);
								winX += window.screenLeft;
								
								<%-- window 팝업 상단 여백 설정 --%>
								let winY = fncSetPopPosition(parseInt(windowList[i].popupUpndMargnVal), parseInt(winHg), screen.availHeight);
								
								let winCss = 'width='+ winWd +', height='+ winHg +', left='+ winX +', top='+ winY +', status=no, location=no, menubar=no';
								
								win[i] = window.open("mainPop.do", "", winCss);
							}
					    	
				            win[i].document.write(data);
				            
				            setTimeout(function() {
					            $(win[i].document).ready(function () {
					            	$(".win_close", win[i].document).on('click', function () {
					        	        win[i].close();
					        	    });
					                $('input[name^="n_pop"]', win[i].document).on('click', function(){
					    				fncClosePop($(this).attr('id').split('_')[2], 'window');
					    				win[i].close();
					    			});
					            });
				            }, 100);
					    }
					});
				}
			}
			return false;
		}
		
		<%-- 팝업 크기 설정 --%>
		const fncSetPopSize = function(popSz, maxSz){
			let resSz = 0;
			if( nullCheck(popSz) || popSz <= 500 ) {
				resSz = 500;
			} else if( popSz >= maxSz ) {
				resSz = maxSz;
			} else {
				resSz = popSz;
			}
			return resSz;
		}

		<%-- 팝업 위치 설정 --%>
		const fncSetPopPosition = function(popMg, popSz, maxSz){
			let resCord = -1;
			if(!nullCheck(popMg)) {
				if( popSz + popMg < maxSz ) {
					resCord = popMg;
				}
			}
			return resCord;
		}
		
		<%-- 팝업 닫기 : 팝업 오늘 하루 동안 열지 않음  --%>
		const fncClosePop = function(num, popDivn) {
			let date = new Date();
			<%-- 쿠키 만료 기간 --%>
			let expDt = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate(), 14,59,59));
			if( popDivn == 'modal' ) {
				if ($("input:checkbox[name=n_pop" +num+ "]").is(":checked")) {
					$.cookie("n_popYn"+num, "N", { expires : expDt });
					view_hide(num);
				}
			} else if ( popDivn == 'window' ) {
				$.cookie("n_popYn"+num, "N", { expires : expDt });
			}
		};
	
		// visual slider
		$(document).ready(function () {
			<%-- 슬라이드 --%>
		    var visualslider2 = new Swiper('.visual_slider .swiper-container', {
		        slidesPerView: 1,
		        initialSlide: 0,
		        loop: true,
		        speed: 1000,
		        grabCursor: true,
		        watchSlidesProgress: true,
		        mousewheelControl: true,
		        keyboardControl: true,
		        autoplay: {
		            delay: 4000,
		            disableOnInteraction: false,
		        },
		        navigation: {
		            nextEl: '.btn_visual_next2',
		            prevEl: '.btn_visual_prev2'
		        },
		        pagination: {
		            el: ".pagination",
		            clickable: true
		        },
		        on: {
		            init: function () {
		                let idx = this.realIndex + 1;
		                $('.visual_slider .swiper-slide').eq(idx).addClass('active first');
		            },
		        },
		        observer: true,
		        observeParents: true
		    });
		    visualslider2.on('slideChange', function () {
		        let idx = visualslider2.activeIndex;
		        $('.visual_slider .swiper-slide').removeClass('active first');
		        $('.visual_slider .swiper-slide').eq(idx).addClass('active');
		    });
		    
		    <%-- 팝업 --%>
		    fncSetPopup();
			
			<%-- resize 될 경우 --%>
			$(window).resize( function() {
				fncSetPopup("resize");
			});
		});
	</script>
</head>
<body>
	<!-- skip menu -->
    <div class="skip" id="skipnavi" >
        <ul>
            <li><a href="#gnb">메뉴바로가기</a></li>
            <li><a href="#container">본문바로가기</a></li>
        </ul>
    </div>
    <!-- //skip menu -->
    
    <!-- wrapper -->
	<div id="wrapper">
		<header id="header">
		    <div class="gnb_bg"></div>
		    <div class="hd_top">
		        <div class="wrap">
		            <h1 class="logo"><a href="/ft/main.do"><img src="/ft/images/common/logo.png" alt="로고"></a></h1>
		            <div class="utils">
		                <ul>
		                	<c:choose>
		                		<c:when test="${empty sessionScope.ft_user_info }">
				                    <li><a href="/ft/login.do">로그인</a></li>
				                    <li><a href="/ft/join/useAgrTerms.do">회원가입</a></li>
		                		</c:when>
		                		<c:otherwise>
				                    <li><a href=""><c:out value="${sessionScope.ft_user_info.userNm }"/>님</a></li>
				                    <li><a href="/ft/logout.do">로그아웃</a></li>
				                    <li><a href="/my/userInfo/amend/list.do">마이페이지</a></li>
		                		</c:otherwise>
		                	</c:choose>
		                </ul>
		            </div>
		        </div>
		    </div>
		    <div class="gnb_area">
		        <div class="wrap">
		            <nav id="gnb">
		                <ul class="gnb">
		                	<jsp:include page="/WEB-INF/jsp/common/layout/ft/menuList/${not empty sessionScope.ft_user_info.grpAuthId ? sessionScope.ft_user_info.grpAuthId : 'default'}.jsp" flush="true"/>
		                </ul>
		            </nav>
		        </div>
		    </div>
		</header>
		<!-- pc 팝업 -->
		<div id="pcPop">
			<input type="hidden" id="childPopCookie"/>
		</div>
		<div id="main_container">
				<div class="visual_slider typeB">
				    <div class="swiper-container">
				        <div class="swiper-wrapper">
				            <div class="swiper-slide">
				                <a href="" class="slide-inner">
				                    <img src="images/content/img_visual_sample1.png" alt="">
				                    <div class="txt">
				                        <b>OPENNOTE</b>
				                        <p>
				                            고객 만족을 위한<br>
				                            최고의 가치를 제공하는<br>
				                            디지털 마케팅 서비스<br>
				                            시스템 설계구축 전문 그룹
				                        </p>
				                    </div>
				                </a>
				            </div>
				            <div class="swiper-slide">
				                <a href="" class="slide-inner">
				                    <img src="images/content/img_visual_sample2.png" alt="">
				                    <div class="txt">
				                        <b>OPENNOTE</b>
				                        <p>
				                            고객 만족을 위한<br>
				                            최고의 가치를 제공하는<br>
				                            디지털 마케팅 서비스<br>
				                            시스템 설계구축 전문 그룹
				                        </p>
				                    </div>
				                </a>
				            </div>
				            <div class="swiper-slide">
				                <a href="" class="slide-inner">
				                    <img src="images/content/img_visual_sample3.png" alt="">
				                    <div class="txt">
				                        <b>OPENNOTE</b>
				                        <p>
				                            고객 만족을 위한<br>
				                            최고의 가치를 제공하는<br>
				                            디지털 마케팅 서비스<br>
				                            시스템 설계구축 전문 그룹
				                        </p>
				                    </div>
				                </a>
				            </div>
				        </div>
				    </div>
				    <div class="swiper_btn">
				        <div class="pagination"></div>
				        <button class="btn_visual_prev2">이전</button>
				        <button class="btn_visual_next2">다음</button>
				    </div> 
				</div>
			<section id="content">
				<div class="sidebyside">
					<div class="recent_list">
					    <div class="title">
					        <b>공지사항</b>
					        <a href="" class="btn_more">더보기</a>
					    </div>
					    <ul>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					    </ul>
					</div>
					<div class="recent_list">
					    <div class="title">
					        <b>자료실</b>
					        <a href="" class="btn_more">더보기</a>
					    </div>
					    <ul>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					        <li><a href=""><p>정부, 개방형 국민인재 직위 공모 안내</p><span>2023.12.31</span></a></li>
					    </ul>
					</div>
				</div>
			</section>
		</div>
		<footer id="footer">
			<div class="inner">
				<div class="logo">오픈노트</div>
				<div class="txt">
					<ul>
						<li><a href="#"
							class="blue">개인정보처리방침</a></li>
						<li><a href="#">이메일주소무단수집금지</a></li>
					</ul>
					<div>
						<address>
							<c:if test="${not empty sessionScope.copyright_info.cprgtSerno}">
								<span>(<c:out value="${sessionScope.copyright_info.coPostNo}" />) <c:out
										value="${sessionScope.copyright_info.coAddr += ' ' += sessionScope.copyright_info.coDtlsAddr}" /></span>
								<br/>
								<span>Tel. <c:out value="${sessionScope.copyright_info.coTelNo }" /></span>
								<span>Fax. <c:out value="${sessionScope.copyright_info.coFaxNo }" /> 
								</span>
							</c:if>
						</address>
						<%-- copyright --%>
						<c:out value="${sessionScope.copyright_info.cprgtCtt }"/>
					</div>
				</div>
				<div class="fake_sel footBtn">
					<button type="button" class="btn_site">관련사이트 바로가기</button>
					<div class="family_list_box">
						<div class="family_list mCustomScrollbar">
							<ul>
								<c:choose>
									<c:when test="${fn:length(sessionScope.relSite_info) gt 0}">
										<c:forEach items="${sessionScope.relSite_info }" var="relSite" varStatus="status">
											<li><a <c:if test="${not empty relSite.relSiteUrlAddr}">href='${relSite.relSiteUrlAddr }' target='blank'</c:if>><c:out value="${relSite.relSiteNm }" /></a></li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<li class="no_data">등록된 관련사이트가 없습니다.</li>
									</c:otherwise>
								</c:choose> 
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="popup_bg" id="js_popup_bg"></div>
			<div class="loading_wrap entire" style="display: none;">
				<div class="loading_box">
					<svg class="loader" width="79px" height="79px" viewBox="0 0 80 80" xmlns="http://www.w3.org/2000/svg">
				    	<circle class="path" fill="none" stroke-width="8" stroke-linecap="round" cx="40" cy="40" r="25"></circle>
				    </svg>
					<b>loading</b>
				</div>
			</div>
		</footer>
	</div>
	<form name="fileDownFrm" id="fileDownFrm">
		<input type="hidden" name="atchFileId" id="downAtchFileId"/>
		<input type="hidden" name="fileSeqo" id="downAtchSeqo"/>
		<input type="hidden" name="fileRlNm" id="downAtchRlNm"/>
		<input type="hidden" name="fileNmPhclFileNm" id="downAtchPhclNm" />
	</form>
</body>
</html>