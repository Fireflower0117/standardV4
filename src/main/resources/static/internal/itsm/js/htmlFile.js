//<%-- 2010버전 hwp 다운로드 --%>
function htmlToFile() {
	var reportTit = "";
		if(opener.$("[NAME=anlsSe]").val() =="IN01") {
			reportTit = "관외거주자";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN02") {
			reportTit = "농업법인";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN03") {
			reportTit = "시험·실습지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN04") {
			reportTit = "상속농지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN05") {
			reportTit = "국·공유지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN06") {
			reportTit = "가격거래량";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN07") {
			reportTit = "농지이용시설";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN08") {
			reportTit = "태양광시설";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN09") {
			reportTit = "농지전용";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN10") {
			reportTit = "저활용농지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN11") {
			reportTit = "농업진흥지역";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN12") {
			reportTit = "비정기";
		}
    
    //<%-- 보고서 내용 가져오기 --%>
    $.ajax({
        method:"POST"
        , url:"/ma/fmi/osr/reportDown.do"
        , data:opener.$("#defaultFrm").serialize()
        , dataType:"html"
        , success:function(data){
			
            var source = 'data:application/hwp;charset=utf-8,' + encodeURIComponent(data);
            
            var fileDownload = document.createElement("a");
            //<%-- hwp 파일 제목  --%>
            document.body.appendChild(fileDownload);
            fileDownload.href = source;
            fileDownload.download = reportTit+" 목적 취득농지 조사결과 보고서.hwp";
            fileDownload.click();
            document.body.removeChild(fileDownload);
        }
    }); 
}



function fmlReport(type) {
	var reportTit = "";
		if(opener.$("[NAME=anlsSe]").val() =="IN01") {
			reportTit = "관외거주자";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN02") {
			reportTit = "농업법인";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN03") {
			reportTit = "시험·실습지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN04") {
			reportTit = "상속농지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN05") {
			reportTit = "국·공유지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN06") {
			reportTit = "가격거래량";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN07") {
			reportTit = "농지이용시설";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN08") {
			reportTit = "태양광시설";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN09") {
			reportTit = "농지전용";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN10") {
			reportTit = "저활용농지";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN11") {
			reportTit = "농업진흥지역";
		}else if(opener.$("[NAME=anlsSe]").val() =="IN12") {
			reportTit = "비정기";
		}else{
			reportTit = "지자체통지";
		}
    
    //<%-- 보고서 내용 가져오기 --%>
    $.ajax({
        method:"POST"
        , url:"/ma/fmi/osr/downfmlReport" + type + ".do"
        , data:opener.$("#defaultFrm").serialize()
        , dataType:"html"
        , success:function(data){
			
            var source = 'data:application/hwp;charset=EUC-KR,' + encodeURIComponent(data);
            
            var fileDownload = document.createElement("a");
            //<%-- hwp 파일 제목  --%>
            document.body.appendChild(fileDownload);
            fileDownload.href = source;
            fileDownload.download = reportTit+" 현장조사보고서.hwp";
            fileDownload.click();
            document.body.removeChild(fileDownload);
        }
    }); 
}

function sitePop(type){
	
	var childWindow;
	
	if(!$('.arrExmnReport').val()){
			
		alert("선택된 항목이 없습니다.")
		return false;
	}

	childWindow = window.open("", "childForm", "width=800, height=800, resizable = no, scrollbars = no");

	var defaultFrm = document.defaultFrm;

	defaultFrm.action = "/ma/fmi/osr/fmlReport" + type + ".do";
	defaultFrm.method = "post";
	defaultFrm.target = "childForm";
	defaultFrm.submit();

	defaultFrm.target = "";
	
	return false;
	
}

function siteReportPop(){
	
	var childWindow;
	
	childWindow = window.open("", "childForm", "width=765, height=1000, resizable = no, scrollbars = no");
	
	var defaultFrm = document.defaultFrm;

	defaultFrm.action = "/ma/fmi/osr/report.do";
	defaultFrm.method = "post";
	defaultFrm.target = "childForm";
	defaultFrm.submit();

	defaultFrm.target = "";
	
	return false;
	
}