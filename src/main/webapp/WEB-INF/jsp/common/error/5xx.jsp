<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE HTML>
<html lang="ko-KR">
	<head>
		<meta charset="UTF-8">
		<title>오픈노트 - 표준안</title>
		<link rel="stylesheet" href="/ma/css/basic.css">
		<script type="text/javascript" src="/ma/js/jquery.min.js"></script>
		<style>
			/** error **/
			/* error btn 버튼설정 */
			.error_wrap .error_btns {margin-top: 30px;}
			.error_wrap .error_btns a {display: inline-block;width: 150px;height: 40px;border-radius: 5px;font-size: 13px;line-height: 38px;text-align: center;}
			.error_btns .btn_main {border: 1px solid var(--black);color: var(--black);background-color: #FFFFFF;}
			.error_btns .btn_prev {color: #FFFFFF;background-color: #282828;}
			
			/** error **/
			/* error500 */
			.error_wrap {display: flex;flex-direction: column;justify-content: center;position: relative;width: 900px;height: 100vh;margin: 0 auto;}
			.error_wrap h1 {position: relative;font-size: 25px;}
			.error_wrap .error_box {position: relative;padding: 60px 0 60px 20px;border: 1px solid #cccccc;}
			.error_wrap .error_info {position: relative;padding-left: 445px;background: url(/ma/images/common/bg_error500a.png) no-repeat 0 50%;}
			.error_wrap .error_info .tit {font-size: 20px;color: var(--black);letter-spacing: -2px;}
			.error_wrap .error_info .tit strong {display: block;font-size: 30px;color: var(--dark);}
			.error_wrap .error_info .txt {margin-top: 25px;font-size: 16px;line-height: 1.5;color: #808080;}
		</style>
	</head>
	<body>
		<div class="error_wrap">
		    <h1><img src="/ma/images/common/error_logo.jpg" alt="(주)오픈노트opennote"></h1>
		    <div class="error_box">
		        <div class="error_info">
		            <p class="tit"><strong>500 Error</strong>서비스가 일시적으로 원활하지 않습니다.</p>
		            <p class="txt">이용에 불편을 드려 죄송합니다. 잠시 후 다시 시도해주시기 바랍니다.</p>
		            <div class="error_btns">
		                <a href="/" class="btn btn_main">메인페이지로 이동</a>
		        		<a href="javascript:history.back();" class="btn btn_prev">이전페이지로 이동</a>
		            </div>
		        </div>
		    </div>
		</div>
	</body>
</html>