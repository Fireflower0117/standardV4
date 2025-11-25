-- stan.t_acs_log_mng definition

CREATE TABLE `t_acs_log_mng` (
  `ACS_LOG_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '접속로그일련번호',
  `ACS_LOG_IP_ADDR` varchar(60) DEFAULT NULL COMMENT '접속로그IP주소',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `IP_ERR_YN` char(1) DEFAULT 'N' COMMENT 'IP오류여부',
  `LGIN_YN` char(1) DEFAULT 'N' COMMENT '로그인여부',
  `LGIN_LMT_YN` char(1) DEFAULT 'N' COMMENT '로그인제한여부',
  `ACS_ID` varchar(100) DEFAULT NULL COMMENT '접속ID',
  `AUTH_AREA_CD` varchar(10) DEFAULT NULL COMMENT '권한영역코드',
  PRIMARY KEY (`ACS_LOG_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=9336 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='접속로그관리';


-- stan.t_atch_file definition

CREATE TABLE `t_atch_file` (
  `ATCH_FILE_ID` varchar(20) NOT NULL COMMENT '첨부파일 아이디',
  `USE_YN` varchar(1) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
  `REG_DATE` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `REG_ID` varchar(20) DEFAULT NULL COMMENT '등록자 아이디',
  PRIMARY KEY (`ATCH_FILE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='첨부파일관리';


-- stan.t_atch_file_detail definition

CREATE TABLE `t_atch_file_detail` (
  `SEQ` int(11) NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `ATCH_FILE_ID` varchar(20) NOT NULL COMMENT '첨부파일 아이디',
  `FILE_SN` int(11) NOT NULL COMMENT '파일 순번',
  `FILE_STRE_COURS` varchar(200) DEFAULT NULL COMMENT '물리 파일 경로',
  `STRE_FILE_NM` varchar(100) DEFAULT NULL COMMENT '물리 파일 명',
  `ORIGN_FILE_NM` varchar(100) DEFAULT NULL COMMENT '실제 파일 명',
  `FILE_EXTSN` varchar(50) DEFAULT NULL COMMENT '확장자',
  `FILE_CN` longtext DEFAULT NULL COMMENT '파일 내용',
  `FILE_SIZE` varchar(50) DEFAULT NULL COMMENT '파일 크기',
  `FILE_TYPE` varchar(80) DEFAULT NULL COMMENT '파일 타입',
  `DEL_YN` varchar(1) NOT NULL DEFAULT 'N' COMMENT '삭제 여부',
  `REG_DATE` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일',
  `REG_ID` varchar(20) DEFAULT NULL COMMENT '등록자 ',
  `IMAGE_WIDTH` int(11) DEFAULT 0 COMMENT '이미지 넓이',
  `IMAGE_HEIGHT` int(11) DEFAULT 0 COMMENT '이미지 높이',
  `ATCH_FILE` blob DEFAULT NULL COMMENT '첨부파일',
  `PARENT_SEQ` int(11) DEFAULT NULL COMMENT '글 일련번호',
  `FILE_IMSI` varchar(1) DEFAULT NULL COMMENT '파일임시여부',
  PRIMARY KEY (`SEQ`,`ATCH_FILE_ID`,`FILE_SN`,`DEL_YN`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='첨부파일 상세관리';


-- stan.t_atch_file_mng definition

CREATE TABLE `t_atch_file_mng` (
  `ATCH_FILE_ID` varchar(50) NOT NULL DEFAULT '0' COMMENT '첨부파일ID',
  `FILE_SEQO` int(22) NOT NULL COMMENT '파일순서',
  `PHCL_FILE_PTH_NM` varchar(200) DEFAULT NULL COMMENT '물리파일경로명',
  `PHCL_FILE_NM` varchar(250) DEFAULT NULL COMMENT '물리파일명',
  `RL_FILE_NM` varchar(100) DEFAULT NULL COMMENT '실제파일명',
  `FILE_EXTN_NM` varchar(5) DEFAULT NULL COMMENT '파일확장자명',
  `FILE_CN` varchar(60) DEFAULT NULL COMMENT '파일내용',
  `FILE_SZ_VAL` varchar(10) DEFAULT NULL COMMENT '파일크기값',
  `FILE_TP_NM` varchar(255) DEFAULT NULL COMMENT '파일유형명',
  `FILE_REF_VAL` varchar(100) DEFAULT NULL COMMENT '파일참조값',
  `IMG_WDTH_SZ_VAL` int(22) DEFAULT NULL COMMENT '이미지가로크기값',
  `IMG_HGHT_SZ_VAL` int(22) DEFAULT NULL COMMENT '이미지세로크기값',
  `REGR_SERNO` int(22) DEFAULT NULL COMMENT '등록자일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '등록일시',
  `TMPR_FILE_YN` char(50) DEFAULT NULL COMMENT '임시파일여부',
  `DEL_YN` char(50) DEFAULT NULL COMMENT '삭제여부',
  `FILE_BYTE` longblob DEFAULT NULL COMMENT '첨부파일BYTE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- stan.t_bltnb_mng definition

CREATE TABLE `t_bltnb_mng` (
  `BLTNB_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시판 일련번호',
  `MENU_CD` varchar(20) DEFAULT NULL COMMENT '메뉴코드',
  `BLTNB_CL` char(2) NOT NULL DEFAULT '0' COMMENT '게시판 구분',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `BLTNB_TITL` varchar(200) DEFAULT NULL COMMENT '제목',
  `BLTNB_CTT` longtext DEFAULT NULL COMMENT '내용',
  `NTI_YN` char(1) DEFAULT 'N' COMMENT '공지여부',
  `NTI_STRT_DT` date DEFAULT NULL COMMENT '공지시작일시',
  `NTI_END_DT` date DEFAULT NULL COMMENT '공지종료일시',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일 ID',
  `OPPB_YN` char(1) DEFAULT NULL COMMENT '공개여부',
  `SCRET_YN` char(1) DEFAULT 'N' COMMENT '비밀여부',
  `BLTNB_PSWD` varchar(100) DEFAULT NULL COMMENT '비밀번호',
  PRIMARY KEY (`BLTNB_SERNO`) USING BTREE,
  KEY `인덱스 2` (`MENU_CD`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='게시판 관리 테이블';


-- stan.t_bltnb_rcmd_mng definition

CREATE TABLE `t_bltnb_rcmd_mng` (
  `RCMD_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시판 추천 일련번호',
  `MENU_CD` varchar(20) DEFAULT NULL COMMENT '메뉴코드',
  `BLTNB_SERNO` int(11) NOT NULL COMMENT '게시판 일련번호',
  `RCMD_YN` char(1) DEFAULT 'Y' COMMENT '추천여부',
  `BLTNB_CL` char(2) NOT NULL DEFAULT '0' COMMENT '게시판 구분',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`RCMD_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='게시판 추천관리  테이블';


-- stan.t_bltnb_repl_mng definition

CREATE TABLE `t_bltnb_repl_mng` (
  `REPL_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'QNA 답변 일련번호',
  `BLTNB_SERNO` int(11) NOT NULL COMMENT '게시글 일련번호',
  `UPR_REPL_SERNO` int(11) DEFAULT NULL COMMENT '부모 답변 일련번호',
  `REPL_CTT` mediumtext DEFAULT NULL COMMENT '답변 내용',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`REPL_SERNO`),
  KEY `BLTNB_SERNO` (`BLTNB_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='게시판 댓글 테이블';


-- stan.t_bnr_mng definition

CREATE TABLE `t_bnr_mng` (
  `BNR_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '배너일련번호',
  `BNR_TITL_NM` varchar(200) DEFAULT NULL COMMENT '배너제목명',
  `EXPL` longtext DEFAULT NULL COMMENT '설명',
  `BNR_OTPT_STRT_DT` timestamp NULL DEFAULT NULL COMMENT '배너출력시작일시',
  `BNR_OTPT_END_DT` timestamp NULL DEFAULT NULL COMMENT '배너출력종료일시',
  `OTPT_YN` char(1) DEFAULT 'Y' COMMENT '출력여부',
  `CL_VAL` varchar(5) DEFAULT NULL COMMENT '구분값',
  `URL_USE_YN` char(1) DEFAULT 'Y' COMMENT 'URL사용여부',
  `URL_ADDR` varchar(2000) DEFAULT NULL COMMENT 'URL주소',
  `BNR_OTPT_PRD_YN` char(1) DEFAULT NULL COMMENT '배너출력기간여부',
  `BNR_TGT` varchar(10) DEFAULT NULL COMMENT '배너대상',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `ATFL_ID` int(11) DEFAULT NULL COMMENT '첨부파일아이디',
  PRIMARY KEY (`BNR_SERNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='배너관리';


-- stan.t_board_mng definition

CREATE TABLE `t_board_mng` (
  `BOARD_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시글 일련번호',
  `BOARD_TITL` varchar(150) DEFAULT NULL COMMENT '제목',
  `BOARD_CTT` longtext DEFAULT NULL COMMENT '내용',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  PRIMARY KEY (`BOARD_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='(샘플)게시판관리';


-- stan.t_cd_mng definition

CREATE TABLE `t_cd_mng` (
  `CD_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '코드 일련번호',
  `CD_UPPO_VAL` varchar(10) DEFAULT NULL COMMENT '코드 상위 값',
  `CD_VAL` varchar(10) NOT NULL COMMENT '코드 값',
  `CD_NM` varchar(100) DEFAULT NULL COMMENT '코드 명',
  `CD_LVL_VAL` int(11) DEFAULT NULL COMMENT '코드 레벨 값',
  `CD_SORT_SEQO` int(11) DEFAULT NULL COMMENT '코드 정렬 순서',
  `CD_DTLS_EXPL` varchar(255) DEFAULT NULL COMMENT '코드 상세 설명',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT current_timestamp() COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`CD_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- stan.t_cont_mng definition

CREATE TABLE `t_cont_mng` (
  `CONT_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '콘텐츠 일련번호',
  `MENU_CD` varchar(30) NOT NULL COMMENT '메뉴 코드',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'Y' COMMENT '사용여부',
  `EDITR_CONT` longtext DEFAULT NULL COMMENT '에디터 작성내용',
  PRIMARY KEY (`CONT_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='콘텐츠 관리';


-- stan.t_cont_tmpl_file_mng definition

CREATE TABLE `t_cont_tmpl_file_mng` (
  `TMPL_FILE_SERNO` int(11) NOT NULL COMMENT '첨부파일ID',
  `FILE_SEQO` int(11) NOT NULL DEFAULT 0 COMMENT '파일순서',
  `RL_FILE_NM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '실제파일명',
  `FILE_EXTN_NM` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '파일확장자명',
  `FILE_TP_NM` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '파일유형명',
  `FILE_SZ_VAL` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '파일크기값',
  `IMG_WDTH_SZ_VAL` int(22) DEFAULT NULL COMMENT '이미지가로크기값',
  `IMG_HGHT_SZ_VAL` int(22) DEFAULT NULL COMMENT '이미지세로크기값',
  `REGR_SERNO` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '등록자일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '등록일시',
  `DEL_YN` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'N' COMMENT '삭제여부',
  `FILE_BYTE` longblob DEFAULT NULL COMMENT '첨부파일BYTE',
  PRIMARY KEY (`TMPL_FILE_SERNO`,`FILE_SEQO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- stan.t_cont_tmpl_fvrt_mng definition

CREATE TABLE `t_cont_tmpl_fvrt_mng` (
  `FVRT_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `TMPL_SERNO` int(11) DEFAULT NULL COMMENT '템플릿 일련번호',
  `REGR_SERNO` varchar(20) DEFAULT NULL COMMENT '등록자SEQ',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일',
  `UPDR_SERNO` varchar(20) DEFAULT NULL COMMENT '수정자SEQ',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`FVRT_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='컨텐츠 즐겨찾기';


-- stan.t_cont_tmpl_mng definition

CREATE TABLE `t_cont_tmpl_mng` (
  `TMPL_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `TMPL_EXPL` varchar(200) DEFAULT NULL COMMENT '템플릿 설명',
  `EDITR_CONT` longtext DEFAULT NULL COMMENT '에디터 작성내용',
  `PRVW_FILE_SERNO` varchar(200) DEFAULT NULL COMMENT '미리보기 파일 일련번호',
  `TMPL_CL` varchar(10) DEFAULT NULL COMMENT '템플릿 구분',
  `TMPL_TP` varchar(10) DEFAULT NULL COMMENT '템플릿 유형',
  `TMPL_FILE_SERNO` varchar(200) DEFAULT NULL COMMENT '템플릿 파일 일련번호',
  PRIMARY KEY (`TMPL_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='콘텐츠 템플릿 테이블';


-- stan.t_cprgt_mng definition

CREATE TABLE `t_cprgt_mng` (
  `CPRGT_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '저작권 일련번호',
  `CPRGT_CTT` varchar(200) DEFAULT NULL COMMENT '저작권 내용',
  `CO_ADDR` varchar(200) DEFAULT NULL COMMENT '회사주소',
  `CO_DTLS_ADDR` varchar(200) DEFAULT NULL COMMENT '회사상세주소',
  `CO_LTNO_ADDR` varchar(200) DEFAULT NULL COMMENT '회사지번주소',
  `CO_POST_NO` char(5) DEFAULT NULL COMMENT '회사우편번호',
  `CO_ENG_ADDR` varchar(200) DEFAULT NULL COMMENT '회사영문주소',
  `CO_FAX_NO` varchar(11) DEFAULT NULL COMMENT '회사팩스번호',
  `CO_TEL_NO` varchar(11) DEFAULT NULL COMMENT '회사전화번호',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`CPRGT_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='저작권 관리 (메인 하단)';


-- stan.t_dmn_mng definition

CREATE TABLE `t_dmn_mng` (
  `DMN_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '도메인일련번호',
  `DMN_NM` varchar(60) DEFAULT NULL COMMENT '도메인명',
  `DMN_ENG_NM` varchar(60) DEFAULT NULL COMMENT '도메인영문명',
  `DMN_GRP` varchar(60) DEFAULT NULL COMMENT '도메인그룹',
  `LGCL_DATA_TP` varchar(60) DEFAULT NULL COMMENT '논리데이터타입',
  `DATA_LEN` int(15) DEFAULT NULL COMMENT '길이',
  `DATA_LEN_DCPT` int(15) DEFAULT NULL COMMENT '길이(소수점)',
  `CG_CD` varchar(200) DEFAULT NULL COMMENT '분류어',
  `DMN_EXPL` varchar(4000) DEFAULT NULL COMMENT '도메인설명',
  `CD_TP` varchar(60) DEFAULT NULL COMMENT '코드유형',
  `CD_DTLS_TP` varchar(60) DEFAULT NULL COMMENT '코드상세유형',
  `UPPO_DMN_NM` varchar(60) DEFAULT NULL COMMENT '상위도메인명',
  `LWPO_DMN_NM` varchar(60) DEFAULT NULL COMMENT '하위도메인명',
  `ECH_CD_SCHM` varchar(60) DEFAULT NULL COMMENT '개별코드스키마',
  `ECH_CD_TBL` varchar(60) DEFAULT NULL COMMENT '개별코드테이블',
  `DMN_TP` varchar(60) DEFAULT NULL COMMENT '도메인유형',
  `SYS_NM` varchar(60) DEFAULT NULL COMMENT '시스템명',
  `PINF_YN` char(1) DEFAULT NULL COMMENT '개인정보여부',
  `ENC_YN` char(1) DEFAULT NULL COMMENT '암호화여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT current_timestamp() COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`DMN_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=33221 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='도메인관리';


-- stan.t_err_log_mng definition

CREATE TABLE `t_err_log_mng` (
  `ERR_LOG_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '오류로그일련번호 ',
  `ERR_TP_NM` varchar(500) DEFAULT NULL COMMENT '오류유형명',
  `ERR_EXPL` varchar(1000) DEFAULT NULL COMMENT '오류설명',
  `SVR_ERR_CTT` text DEFAULT NULL COMMENT '서버오류내용',
  `MENU_CG_NM` varchar(100) DEFAULT NULL COMMENT '메뉴분류명',
  `ERR_PTH_NM` varchar(500) DEFAULT NULL COMMENT '오류경로명',
  `ERR_OCCR_URL_ADDR` varchar(2000) DEFAULT NULL COMMENT '오류발생URL주소',
  `ERR_OCCR_IP_ADDR` varchar(15) DEFAULT NULL COMMENT '오류발생IP주소',
  `ERR_OCCR_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '오류발생일시',
  `USE_YN` char(1) DEFAULT NULL COMMENT '사용여부',
  PRIMARY KEY (`ERR_LOG_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=10089 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='오류 로그 관리';


-- stan.t_exception definition

CREATE TABLE `t_exception` (
  `SEQ` int(11) NOT NULL COMMENT '일련번호',
  `ERR_TYPE` varchar(500) DEFAULT NULL COMMENT '에러타입',
  `ERR_MSG` varchar(4000) DEFAULT NULL COMMENT '에러메세지',
  `FULL_ERR_MSG` longtext DEFAULT NULL COMMENT '전체에러메세지',
  `PARAM_VAL` varchar(4000) DEFAULT NULL COMMENT '파라미터',
  `ERR_MENU_CD` varchar(20) DEFAULT NULL COMMENT '메뉴코드',
  `ERR_PAGE` varchar(500) DEFAULT NULL COMMENT '에러페이지',
  `ERR_PAGE_URL` varchar(500) DEFAULT NULL COMMENT '에러페이지URL',
  `RGST_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '에러발생일',
  `USE_YN` varchar(1) DEFAULT 'Y' COMMENT '사용여부',
  `IP` varchar(100) DEFAULT NULL COMMENT 'IP',
  `RGST_ID` varchar(20) DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='에러관리';


-- stan.t_faq definition

CREATE TABLE `t_faq` (
  `SEQ` int(10) NOT NULL COMMENT '일련번호',
  `FAQ_NUM` int(1) DEFAULT NULL COMMENT 'FAQ 구분',
  `CONT` longtext DEFAULT NULL COMMENT 'FAQ 내용',
  `TITLE` varchar(200) DEFAULT NULL COMMENT 'FAQ 제목',
  `RGST_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '작성 시간',
  `RVSE_DT` timestamp NULL DEFAULT NULL COMMENT '수정 시간',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='FAQ';


-- stan.t_grp_auth_mng definition

CREATE TABLE `t_grp_auth_mng` (
  `GRP_AUTH_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '그룹 권한 일련번호',
  `GRP_AUTH_ID` varchar(30) NOT NULL COMMENT '그룹 권한 ID',
  `GRP_AUTH_NM` varchar(100) DEFAULT NULL COMMENT '그룹 권한 명',
  `GRP_AUTH_EXPL` varchar(4000) DEFAULT NULL COMMENT '그룹 권한 설명',
  `DEL_YN` char(1) DEFAULT 'N' COMMENT '삭제 여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련 번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT current_timestamp() COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`GRP_AUTH_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- stan.t_hday_mng definition

CREATE TABLE `t_hday_mng` (
  `HDAY_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '휴일 일련번호',
  `HDAY_DT` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '휴일일시',
  `HDAY_NM` varchar(60) DEFAULT NULL COMMENT '휴일명',
  `HDAY_YN` char(1) DEFAULT NULL COMMENT '휴일여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`HDAY_SERNO`),
  UNIQUE KEY `HDAY_DT_HDAY_YN` (`HDAY_DT`,`HDAY_YN`)
) ENGINE=InnoDB AUTO_INCREMENT=2003 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='휴일 및 기념일 관리';


-- stan.t_ids definition

CREATE TABLE `t_ids` (
  `TABLE_NAME` varchar(20) NOT NULL COMMENT '테이블명',
  `NEXT_ID` int(11) NOT NULL DEFAULT 0 COMMENT '순번',
  `test` char(50) DEFAULT NULL,
  PRIMARY KEY (`TABLE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='idgen';


-- stan.t_lgin_plcy_mng definition

CREATE TABLE `t_lgin_plcy_mng` (
  `LGIN_PLCY_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '로그인정책일련번호',
  `PWD_CHG_CYCL_DD` int(11) DEFAULT 0 COMMENT '비밀번호변경주기일',
  `PWD_CHG_CYCL_USE_YN` char(1) DEFAULT 'N' COMMENT '비밀번호변경주기사용여부',
  `SCSS_ACC_PSSN_PRD_DD` int(11) DEFAULT 0 COMMENT '탈퇴계정보유기간일',
  `LGIN_LMT_CNT` int(11) DEFAULT 0 COMMENT '로그인제한횟수',
  `LGIN_LMT_USE_YN` char(1) DEFAULT 'N' COMMENT '로그인제한사용여부',
  `BASC_GRP_AUTH_ID` varchar(30) DEFAULT NULL COMMENT '기본그룹권한ID',
  `MBRS_BASC_GRP_AUTH_ID` varchar(30) DEFAULT NULL COMMENT '회원기본그룹권한ID',
  `REGEPS_ID` varchar(30) DEFAULT NULL COMMENT '정규표현식ID관리',
  `REGEPS_PSWD` varchar(30) DEFAULT NULL COMMENT '정규표현식비밀번호관리',
  `REGEPS_EMAIL` varchar(30) DEFAULT NULL COMMENT '정규표현식이메일관리',
  `REGEPS_PHONE` varchar(30) DEFAULT NULL COMMENT '정규표현식핸드폰번호관리',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `SCSS_ACC_PSSN_PRD_CD` varchar(10) DEFAULT NULL COMMENT '탈퇴계정정보보유기간코드',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`LGIN_PLCY_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='로그인 정책관리';


-- stan.t_logo_mng definition

CREATE TABLE `t_logo_mng` (
  `LOGO_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '로고일련번호',
  `ITM_CD` varchar(10) NOT NULL COMMENT '항목코드',
  `LNK_YN` char(1) DEFAULT 'N' COMMENT '링크여부',
  `URL` varchar(1000) DEFAULT NULL COMMENT 'URL',
  `LNK_TGT_CD` varchar(10) DEFAULT NULL COMMENT '링크대상코드',
  `ACTVT_YN` char(1) DEFAULT 'Y' COMMENT '활성화여부',
  `ATCH_FILE_ID` int(11) DEFAULT NULL COMMENT '첨부파일ID',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`LOGO_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='로고관리';


-- stan.t_menu_auth_mng definition

CREATE TABLE `t_menu_auth_mng` (
  `GRP_AUTH_ID` varchar(30) NOT NULL COMMENT '그룹 권한 ID',
  `MENU_CD` varchar(30) NOT NULL COMMENT '메뉴 코드',
  `WRT_AUTH_YN` char(1) DEFAULT 'R' COMMENT '작성 권한 여부',
  `MENU_SE_CD` varchar(10) DEFAULT 'MA' COMMENT '메뉴 구분 코드',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT NULL COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`GRP_AUTH_ID`,`MENU_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- stan.t_menu_log_mng definition

CREATE TABLE `t_menu_log_mng` (
  `MENU_LOG_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '메뉴로그일련번호',
  `MENU_URL_ADDR` varchar(1000) DEFAULT NULL COMMENT '메뉴URL주소',
  `ACS_IP_ADDR` varchar(200) DEFAULT NULL COMMENT '접속IP주소',
  `MENU_CD` varchar(30) DEFAULT NULL COMMENT '메뉴코드',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  PRIMARY KEY (`MENU_LOG_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=2623 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='메뉴로그관리';


-- stan.t_menu_mng definition

CREATE TABLE `t_menu_mng` (
  `MENU_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '메뉴일련번호',
  `MENU_CL` varchar(30) NOT NULL COMMENT '메뉴 구분',
  `UPR_MENU_CD` varchar(30) DEFAULT NULL COMMENT '상위메뉴 코드',
  `MENU_CD` varchar(30) NOT NULL COMMENT '메뉴 코드',
  `MENU_LVL` int(11) DEFAULT NULL COMMENT '메뉴 레벨',
  `MENU_SEQO` int(11) DEFAULT NULL COMMENT '메뉴순서',
  `MENU_NM` varchar(50) DEFAULT NULL COMMENT '메뉴명',
  `MENU_URL_ADDR` varchar(200) DEFAULT NULL COMMENT '메뉴 URL 주소',
  `MENU_TP_CL` char(1) DEFAULT NULL COMMENT '메뉴 유형 구분',
  `BLTNB_CL` char(2) DEFAULT NULL COMMENT '게시판 구분',
  `MENU_EXPL` varchar(500) DEFAULT NULL COMMENT '메뉴 설명',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `EXPSR_YN` char(1) DEFAULT 'Y' COMMENT '노출 여부',
  `TGT_BLANK_YN` char(1) DEFAULT 'N' COMMENT '새창열기여부',
  `LWR_TAB_YN` char(1) DEFAULT 'N' COMMENT '하위탭여부',
  PRIMARY KEY (`MENU_CD`),
  KEY `MENU_SERNO` (`MENU_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='메뉴관리 테이블';


-- stan.t_mnl_itm_mng definition

CREATE TABLE `t_mnl_itm_mng` (
  `MNL_ITM_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '매뉴얼 항목 일련번호',
  `MNL_SERNO` int(11) DEFAULT NULL COMMENT '매뉴얼 일련번호',
  `MNL_ITM_NO` varchar(20) DEFAULT NULL COMMENT '매뉴얼 항목번호',
  `MNL_ITM_CL_CD` varchar(20) DEFAULT NULL COMMENT '매뉴얼 힝목구분코드',
  `MNL_ITM_SEQO` int(11) DEFAULT NULL COMMENT '매뉴얼 항목순서',
  `TITL_NM` varchar(100) DEFAULT NULL COMMENT '제목명',
  `SUB_TITL_NM` varchar(100) DEFAULT NULL COMMENT '부제목명',
  `DTLS_CTT` longtext DEFAULT NULL COMMENT '상세내용',
  `ATCH_FILE_ID` varchar(50) DEFAULT NULL COMMENT '첨부파일ID',
  `URL_ADDR` varchar(1000) DEFAULT NULL COMMENT 'URL주소',
  `HTML_SRCD_CTT` longtext DEFAULT NULL COMMENT 'HTML 소스코드',
  `CSS_SRCD_CTT` longtext DEFAULT NULL COMMENT 'CSS 소스코드',
  `JS_SRCD_CTT` longtext DEFAULT NULL COMMENT 'JS 소스코드',
  `JAVA_SRCD_CTT` longtext DEFAULT NULL COMMENT 'JAVA 소스코드',
  `XML_SRCD_CTT` longtext DEFAULT NULL COMMENT 'XML 소스코드',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`MNL_ITM_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='매뉴얼 항목관리';


-- stan.t_mnl_mng definition

CREATE TABLE `t_mnl_mng` (
  `MNL_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '매뉴얼 일련번호',
  `MENU_CL_NM` varchar(60) DEFAULT NULL COMMENT '메뉴구분명',
  `TCHGR_NM` varchar(60) DEFAULT NULL COMMENT '담당자명',
  `MENU_EXPL` varchar(300) DEFAULT NULL COMMENT '메뉴설명',
  `ATCH_FILE_ID` varchar(50) DEFAULT NULL COMMENT '첨부파일ID',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`MNL_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='메뉴얼관리';


-- stan.t_noti definition

CREATE TABLE `t_noti` (
  `SEQ` int(10) NOT NULL COMMENT '일련번호',
  `TITLE` varchar(100) DEFAULT NULL COMMENT '제목',
  `CONT` longtext DEFAULT NULL COMMENT '공지내용',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일',
  `RGST_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '작성 시간',
  `RVSE_DT` timestamp NULL DEFAULT NULL COMMENT '수정 시간',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `NOTI_YN` char(1) DEFAULT '1' COMMENT '공지여부',
  `NOTI_STA` varchar(20) DEFAULT NULL COMMENT '공지시작일',
  `NOTI_END` varchar(20) DEFAULT NULL COMMENT '공지종료일',
  `READ_COUNT` int(10) DEFAULT 0 COMMENT '조회수',
  PRIMARY KEY (`SEQ`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공지사항';


-- stan.t_noti_reply definition

CREATE TABLE `t_noti_reply` (
  `REPLY_SEQ` int(11) NOT NULL COMMENT '시퀀스',
  `NOTI_SEQ` int(11) DEFAULT NULL COMMENT '공지사항 시퀀스',
  `CONT` longtext DEFAULT NULL COMMENT '공지사항 댓글',
  `NAME` varchar(10) DEFAULT NULL COMMENT '댓글 작성자',
  `PASSWORD` varchar(100) DEFAULT NULL COMMENT '댓글 비밀번호',
  `RGST_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일',
  `RVSE_DT` timestamp NULL DEFAULT NULL COMMENT '수정일',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`REPLY_SEQ`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공지사항 댓글';


-- stan.t_phr_mng definition

CREATE TABLE `t_phr_mng` (
  `PHR_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '일렬번호',
  `PHR_NAME` varchar(100) DEFAULT NULL COMMENT '약국이름',
  `PHR_ADD` varchar(100) DEFAULT NULL COMMENT '주소',
  `PHR_ETC` varchar(300) DEFAULT NULL COMMENT '비고',
  `PHR_TEL` varchar(50) DEFAULT NULL COMMENT '대표전화',
  `PHR_MON_STR` int(4) DEFAULT NULL COMMENT '진료시간(월요일 오픈시간)',
  `PHR_MON_END` int(4) DEFAULT NULL COMMENT '진료시간(월요일 종료시간)',
  `PHR_TUE_STR` int(4) DEFAULT NULL COMMENT '진료시간(화요일 오픈시간)',
  `PHR_TUE_END` int(4) DEFAULT NULL COMMENT '진료시간(화요일 종료시간)',
  `PHR_WED_STR` int(4) DEFAULT NULL COMMENT '진료시간(수요일 오픈시간)',
  `PHR_WED_END` int(4) DEFAULT NULL COMMENT '진료시간(수요일 종료시간)',
  `PHR_THU_STR` int(4) DEFAULT NULL COMMENT '진료시간(목요일 오픈시간)',
  `PHR_THU_END` int(4) DEFAULT NULL COMMENT '진료시간(목요일 종료시간)',
  `PHR_FRI_STR` int(4) DEFAULT NULL COMMENT '진료시간(금요일 오픈시간)',
  `PHR_FRI_END` int(4) DEFAULT NULL COMMENT '진료시간(금묘일 종료시간)',
  `PHR_SAT_STR` int(4) DEFAULT NULL COMMENT '진료시간(토요일 오픈시간)',
  `PHR_SAT_END` int(4) DEFAULT NULL COMMENT '진료시간(토요일 종료시간)',
  `PHR_SUN_STR` int(4) DEFAULT NULL COMMENT '진료시간(일요일 오픈시간)',
  `PHR_SUN_END` int(4) DEFAULT NULL COMMENT '진료시간(일요일 종료시간)',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  PRIMARY KEY (`PHR_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=8275441 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci COMMENT='(정보)게시판관리';


-- stan.t_popup_mng definition

CREATE TABLE `t_popup_mng` (
  `POPUP_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '팝업일련번호',
  `POPUP_TITL_NM` varchar(100) DEFAULT NULL COMMENT '팝업제목명',
  `POPUP_PSTN_YN` char(1) DEFAULT 'Y' COMMENT '팝업게시여부',
  `POPUP_PSTN_PRD_YN` char(1) DEFAULT 'Y' COMMENT '팝업게시기간여부',
  `POPUP_PSTN_STRT_DT` timestamp NULL DEFAULT NULL COMMENT '팝업게시시작일시',
  `POPUP_PSTN_END_DT` timestamp NULL DEFAULT NULL COMMENT '팝업게시종료일시',
  `POPUP_WDTH_SIZE_VAL` int(11) DEFAULT NULL COMMENT '팝업가로크기값',
  `POPUP_HGHT_SIZE_VAL` int(11) DEFAULT NULL COMMENT '팝업세로크기값',
  `REP_IMG_ID` int(11) DEFAULT NULL COMMENT '대표이미지파일ID',
  `POPUP_TGT_CD` varchar(10) DEFAULT NULL COMMENT '팝업대상코드',
  `POPUP_UPND_MARGN_VAL` int(11) DEFAULT 0 COMMENT '팝업상단여백값',
  `POPUP_LSD_MARGN_VAL` int(11) DEFAULT 0 COMMENT '팝업좌측여백값',
  `POPUP_CTT` longtext DEFAULT NULL COMMENT '팝업내용',
  `POPUP_CL_CD` varchar(5) DEFAULT NULL COMMENT '팝업구분코드',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`POPUP_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='팝업관리';


-- stan.t_qna definition

CREATE TABLE `t_qna` (
  `SEQ` int(10) NOT NULL COMMENT '일련번호',
  `NAME` varchar(20) DEFAULT NULL COMMENT '문의자 이름 및 답변자 이름',
  `PWD` varchar(100) DEFAULT NULL COMMENT '문의글 비밀번호',
  `CONT` longtext DEFAULT NULL COMMENT '문의글 내용',
  `SUBCONT` longtext DEFAULT NULL COMMENT '답변 내용',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일',
  `TITLE` varchar(100) DEFAULT NULL COMMENT '제목',
  `RGST_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '작성 시간',
  `RVSE_DT` timestamp NULL DEFAULT NULL COMMENT '수정 시간',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `NOTI_YN` char(1) DEFAULT 'N' COMMENT '비밀글 여부',
  `ANS_YN` char(1) DEFAULT 'N' COMMENT '답변 여부',
  PRIMARY KEY (`SEQ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='문의글';


-- stan.t_reg_cd_mng definition

CREATE TABLE `t_reg_cd_mng` (
  `REG_CD` varchar(10) NOT NULL COMMENT '법정동코드',
  `SIDO_NM` varchar(100) DEFAULT NULL COMMENT '시도명',
  `CGG_NM` varchar(100) DEFAULT NULL COMMENT '시군구명',
  `UMD_NM` varchar(100) DEFAULT NULL COMMENT '읍면동명',
  `RI_NM` varchar(100) DEFAULT NULL COMMENT '리명',
  `LVL` int(10) DEFAULT NULL COMMENT '레벨',
  `RNKO` int(10) DEFAULT NULL COMMENT '서열',
  `CRE_YMD` char(8) DEFAULT NULL COMMENT '생성일',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `DEL_YN` char(1) DEFAULT 'N' COMMENT '삭제여부',
  `DEL_YMD` timestamp NULL DEFAULT NULL COMMENT '삭제일',
  PRIMARY KEY (`REG_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='법정동코드관리';


-- stan.t_reg_cd_mng_tmp definition

CREATE TABLE `t_reg_cd_mng_tmp` (
  `REG_CD` varchar(10) NOT NULL COMMENT '법정동코드',
  `SIDO_NM` varchar(100) DEFAULT NULL COMMENT '시도명',
  `CGG_NM` varchar(100) DEFAULT NULL COMMENT '시군구명',
  `UMD_NM` varchar(100) DEFAULT NULL COMMENT '읍면동명',
  `RI_NM` varchar(100) DEFAULT NULL COMMENT '리명',
  `LVL` int(10) DEFAULT NULL COMMENT '레벨',
  `RNKO` int(10) DEFAULT NULL COMMENT '서열',
  `CRE_YMD` char(8) DEFAULT NULL COMMENT '생성일',
  `LWPOS_AREA_NM` varchar(100) DEFAULT NULL COMMENT '최하위지역명',
  PRIMARY KEY (`REG_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='법정동코드관리임시';


-- stan.t_regeps_mng definition

CREATE TABLE `t_regeps_mng` (
  `REGEPS_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '정규표현식일련번호',
  `REGEPS_ID` varchar(30) NOT NULL COMMENT '정규표현식ID',
  `REGEPS_NM` varchar(60) DEFAULT NULL COMMENT '정규표현식명',
  `REGEPS_TXT` varchar(300) DEFAULT NULL COMMENT '정규표현식텍스트',
  `PLACEHOLDER_TXT` varchar(300) DEFAULT NULL COMMENT '플레이스홀더텍스트',
  `ERR_MSG` varchar(300) DEFAULT NULL COMMENT '오류메시지',
  `REGEPS_EXM` varchar(100) DEFAULT NULL COMMENT '정규표현식예시',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`REGEPS_SERNO`,`REGEPS_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='정규표현식관리';


-- stan.t_rel_site_mng definition

CREATE TABLE `t_rel_site_mng` (
  `REL_SITE_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '관련사이트 일련번호',
  `REL_SITE_URL_ADDR` varchar(1000) DEFAULT NULL COMMENT '관련사이트URL주소',
  `REL_SITE_NM` varchar(100) DEFAULT NULL COMMENT '관련사이트명',
  `ATFL_SERNO` int(11) DEFAULT NULL COMMENT '첨부파일 일련번호',
  `SEQO` int(4) DEFAULT NULL COMMENT '순서',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`REL_SITE_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='관련사이트 관리';


-- stan.t_schd_atndr_mng definition

CREATE TABLE `t_schd_atndr_mng` (
  `ATNDR_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '일정참석자 일련번호',
  `SCHD_SERNO` int(11) NOT NULL COMMENT '일정 일련번호',
  `USER_SERNO` int(11) NOT NULL COMMENT '사용자 일련번호',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`ATNDR_SERNO`),
  UNIQUE KEY `SCHD_SERNO_USER_SERNO` (`SCHD_SERNO`,`USER_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='일정 참석자 관리 ';


-- stan.t_schd_mng definition

CREATE TABLE `t_schd_mng` (
  `SCHD_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '일정일련번호',
  `SCHD_CL_CD` varchar(20) DEFAULT NULL COMMENT '일정구분코드',
  `SCHD_HH_CD` varchar(10) DEFAULT NULL COMMENT '일정시간코드',
  `SCHD_STRT_DT` timestamp NULL DEFAULT NULL COMMENT '일정시작일시',
  `SCHD_END_DT` timestamp NULL DEFAULT NULL COMMENT '일정종료일시',
  `SCHD_TITL_NM` varchar(100) DEFAULT NULL COMMENT '일정제목명',
  `SCHD_CTT` longtext DEFAULT NULL COMMENT '일정내용',
  `JOB_CON_YN` char(1) DEFAULT 'N' COMMENT '업무연계여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SCHD_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='일정관리';


-- stan.t_seo_mng definition

CREATE TABLE `t_seo_mng` (
  `SEO_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'seo 일련번호',
  `SEO_TYPE` char(1) DEFAULT NULL COMMENT 'seo 타입(네이버,구글)',
  `DOMAIN_URL` varchar(300) DEFAULT NULL COMMENT '가공된 도메인 주소',
  `META_TAGE_RESULT` varchar(9) DEFAULT NULL COMMENT 'meta tag 존재여부',
  `ROBOTS_RESULT` varchar(9) DEFAULT NULL COMMENT 'robots.txt 존재여부',
  `SITEMAP_RESULT` varchar(9) DEFAULT NULL COMMENT '사이트맵 존재여부',
  `SNSOPTI_RESULT` varchar(9) DEFAULT NULL COMMENT '소셜미디어 최적화 여부',
  `IMGOPTI_RESULT` varchar(9) DEFAULT NULL COMMENT '이미지 최적화 여부',
  `MOBILE_YN` varchar(9) DEFAULT NULL COMMENT '모바일 최적화 여부',
  `LOAD_TIME_RESULT` varchar(9) DEFAULT NULL COMMENT '로딩시간 최적화 여부',
  `HEADING_ONE_RESULT` varchar(9) DEFAULT NULL COMMENT 'h1표제 최적화 여부',
  `HEADING_OTHER_RESULT` varchar(9) DEFAULT NULL COMMENT 'headings 태그 최적화 여부',
  `TITLE_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta title 존재여부',
  `META_TITLE_EQUAL_YN` varchar(9) DEFAULT NULL COMMENT 'meta 타이틀 동일 여부',
  `META_TITLE_OPT_YN` varchar(9) DEFAULT NULL COMMENT 'meta 타이틀 글자수 최적화 여부',
  `META_DESCRP_OPT_YN` varchar(9) DEFAULT NULL COMMENT 'meta 설명 글자수 최적화 여부',
  `DESCRIPTION_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta description 존재여부',
  `CHARSET_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta charset 존재여부',
  `UACOMPATIBLE_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta uaCompatible 존재여부',
  `VIEWPORT_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta viewportMeta 존재여부',
  `OG_TYPE_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta ogType 존재여부',
  `OG_TITLE_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta ogTitle 존재여부',
  `OG_DESCRIPTION_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta ogDescription 존재여부',
  `OG_IMAGE_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta ogImage 존재여부',
  `OG_URL_META_YN` varchar(9) DEFAULT NULL COMMENT 'meta ogUrl 존재여부',
  `CON_YN` varchar(9) DEFAULT NULL COMMENT '연결여부',
  `IMG_UPRIGHTUSE_RESULT` varchar(9) DEFAULT NULL COMMENT '이미지 올바른 사용결과',
  `IMG_UPRIGHTUSE_MESSAGE` varchar(300) DEFAULT NULL COMMENT '올바른 사용결과 상세내용',
  `IMG_NMOPTI_RESULT` varchar(9) DEFAULT NULL COMMENT '이미지 이름 최적화 결과',
  `IMG_NMOPTI_MESSAGE` varchar(300) DEFAULT NULL COMMENT '이미지 이름 최적화 상세내용',
  `IMG_CAPTION_RESULT` varchar(9) DEFAULT NULL COMMENT '이미지 캡션 사용 결과',
  `IMG_CAPTION_MESSAGE` varchar(300) DEFAULT NULL COMMENT '이미지 캡션 사용 상세내용',
  `IMG_RESPONOPTI_RESULT` varchar(9) DEFAULT NULL COMMENT '이미지 반응형 이미지 최적화 결과',
  `IMG_RESPONOPTI_MESSAGE` varchar(300) DEFAULT NULL COMMENT '이미지 반응형 이미지 최적화 결과',
  `IMG_OVER_YN` varchar(9) DEFAULT NULL COMMENT '이미지 용량 줄이기 여부',
  `IMG_OVER_MESSAGE` varchar(300) DEFAULT NULL COMMENT '이미지 용량 줄이기 상세내용',
  `URL_STRUCT_RESULT` varchar(9) DEFAULT NULL COMMENT 'url 구조 결과',
  `URL_HYPHEN_YN` varchar(9) DEFAULT NULL COMMENT 'url 하이픈 존재 여부',
  `URL_ASCII_YN` varchar(9) DEFAULT NULL COMMENT 'url ASCII 사용 여부',
  `URL_LOGNID_YN` varchar(9) DEFAULT NULL COMMENT 'url 긴ID사용여부',
  `HREFLANG_YN` varchar(9) DEFAULT NULL COMMENT 'hreflang태그 존재여부',
  `HREFLANG_MESSAGE` varchar(300) DEFAULT NULL COMMENT 'hreflang태그 상세내용',
  `CANONICAL_YN` varchar(9) DEFAULT NULL COMMENT 'canonical 태그 존재여부',
  `LOADTIME` varchar(30) DEFAULT NULL COMMENT '페이지 로딩 시간',
  `HEADING_ONE_YN` varchar(9) DEFAULT NULL COMMENT 'h1표제 사용여부',
  `HEADING_ONE_CONT_YN` varchar(9) DEFAULT NULL COMMENT 'h1표제 컨텐츠 여부',
  `HEADING_ONE_MESSAGE` varchar(300) DEFAULT NULL COMMENT 'h1표제 상세내용',
  `HEADING_OTHER_YN` varchar(9) DEFAULT NULL COMMENT 'headings 태그 사용여부',
  `HEADING_OTHER_CONT_YN` varchar(9) DEFAULT NULL COMMENT 'headings 태그 컨텐츠 여부',
  `HEADING_OTHER_MESSAGE` varchar(300) DEFAULT NULL COMMENT 'headings 태그 상세내용',
  `FRAME_USE_RESULT` varchar(9) DEFAULT NULL COMMENT 'frame 태그 사용 여부',
  `LINK_OPT_FNC_YN` varchar(9) DEFAULT NULL COMMENT '함수 사용 여부',
  `LINK_OPT_ATAG_YN` varchar(9) DEFAULT NULL COMMENT 'href 적정 사용 여부',
  `LINK_OPT_ATAG_TXT_YN` varchar(9) DEFAULT NULL COMMENT 'a태그 빈 텍스트 여부',
  `FONT_SIZE_OPT_YN` char(3) DEFAULT NULL COMMENT 'font-size 최적화 여부',
  `REG_DT` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록일',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SEO_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=887 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- stan.t_srvy_mng definition

CREATE TABLE `t_srvy_mng` (
  `SRVY_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '설문조사 일련번호',
  `SRVY_NM` varchar(200) DEFAULT NULL COMMENT '설문 명',
  `SRVY_EXPL` varchar(1000) DEFAULT NULL COMMENT '설문 설명',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일 일련번호',
  `SRVY_STRT_DT` timestamp NULL DEFAULT NULL COMMENT '설문 시작일시',
  `SRVY_END_DT` timestamp NULL DEFAULT NULL COMMENT '설문 종료일시',
  `SRVY_MTHD` varchar(20) DEFAULT NULL COMMENT '설문 방법',
  `SRVY_OVLP_YN` char(1) DEFAULT NULL COMMENT '설문조사 중복 여부',
  `SRVY_OVLP_CNT` varchar(20) DEFAULT NULL COMMENT '설문 중복 수',
  `SRVY_RSLT_YN` char(1) DEFAULT NULL COMMENT '설문 결과 여부',
  `SRVY_STS` char(1) DEFAULT 'N' COMMENT '설문 상태',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SRVY_SERNO`) USING BTREE,
  KEY `SRVY_SERNO` (`SRVY_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='설문조사관리 테이블';


-- stan.t_srvy_qst_itm_mng definition

CREATE TABLE `t_srvy_qst_itm_mng` (
  `SRVY_QST_ITM_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '설문조사 질문 항목 일련번호',
  `SRVY_SERNO` int(11) NOT NULL COMMENT '설문조사 일련번호',
  `SRVY_SCTN_SERNO` int(11) NOT NULL COMMENT '설문조사 섹션 일련번호',
  `SRVY_QST_SERNO` int(11) NOT NULL COMMENT '설문조사 일련번호',
  `SRVY_QST_ITM_CTT` varchar(1000) DEFAULT NULL COMMENT '설문조사 질문 항목 내용',
  `SRVY_ITM_TP_VAL_1` varchar(100) DEFAULT NULL COMMENT '설문조사 항목유형값1',
  `SRVY_ITM_TP_VAL_2` varchar(100) DEFAULT NULL COMMENT '설문조사 항목유형값2',
  `SRVY_ITM_TP_VAL_3` varchar(100) DEFAULT NULL COMMENT '설문조사 항목유형값3',
  `SRVY_ITM_TP_VAL_4` varchar(100) DEFAULT NULL COMMENT '설문조사 항목유형값4',
  `SRVY_ITM_TP_VAL_5` varchar(100) DEFAULT NULL COMMENT '설문조사 항목유형값5',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일 일련번호',
  `SRVY_NEXT_SCTN_NO` varchar(10) DEFAULT NULL COMMENT '다음 섹션 구분 번호',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SRVY_QST_ITM_SERNO`) USING BTREE,
  KEY `SRVY_QST_ITM_SERNO` (`SRVY_QST_ITM_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1238 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='설문조사 질문 항목관리 테이블';


-- stan.t_srvy_qst_mng definition

CREATE TABLE `t_srvy_qst_mng` (
  `SRVY_QST_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '설문조사 질문 일련번호',
  `SRVY_SERNO` int(11) NOT NULL COMMENT '설문조사 일련번호',
  `SRVY_SCTN_SERNO` int(11) NOT NULL DEFAULT 0 COMMENT '설문조사 섹션 일련번호',
  `SRVY_QST_TITL` varchar(1000) DEFAULT NULL COMMENT '질문 명',
  `SRVY_QST_CTT` varchar(1000) DEFAULT NULL COMMENT '질문 내용',
  `SRVY_ANS_CG_VAL` varchar(20) DEFAULT NULL COMMENT '설문조사 답변 분류값',
  `ATCH_FILE_ID` varchar(20) DEFAULT NULL COMMENT '첨부파일 일련번호',
  `SRVY_NEXT_SCTN_YN` varchar(10) DEFAULT NULL COMMENT '다음 섹션 구분 번호',
  `SRVY_NCSR_YN` char(1) DEFAULT NULL COMMENT '필수 여부',
  `SRVY_CHC_CNT` varchar(10) DEFAULT NULL COMMENT '선택 가능 수',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SRVY_QST_SERNO`) USING BTREE,
  KEY `SRVY_QST_SERNO` (`SRVY_QST_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=615 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='설문조사 질문관리 테이블';


-- stan.t_srvy_rply_mng definition

CREATE TABLE `t_srvy_rply_mng` (
  `SRVY_ANS_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '설문조사 질문 항목 일련번호',
  `SRVY_SERNO` int(11) NOT NULL COMMENT '설문조사 일련번호',
  `SRVY_SCTN_SERNO` int(11) NOT NULL COMMENT '설문조사 섹션 일련번호',
  `SRVY_QST_SERNO` int(11) NOT NULL COMMENT '설문조사 일련번호',
  `SRVY_TRGT_SERNO` int(11) NOT NULL COMMENT '설문조사 일련번호',
  `SRVY_ANS_CTT` varchar(3000) DEFAULT NULL COMMENT '설문조사 질문 항목 내용',
  `SRVY_ANS_CTT_ETC` varchar(3000) DEFAULT NULL COMMENT '설문조사 질문 항목 내용',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SRVY_ANS_SERNO`) USING BTREE,
  KEY `SRVY_ANS_SERNO` (`SRVY_ANS_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='설문조사 답변 테이블';


-- stan.t_srvy_sctn_mng definition

CREATE TABLE `t_srvy_sctn_mng` (
  `SRVY_SCTN_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '설문조사 섹션 일련번호',
  `SRVY_SERNO` int(11) NOT NULL COMMENT '설문조사 일련번호',
  `SRVY_NEXT_SCTN_NO` varchar(10) DEFAULT NULL COMMENT '다음 섹션 구분 번호',
  `SRVY_SCTN_TITL` varchar(1000) DEFAULT NULL COMMENT '섹션 명',
  `SRVY_SCTN_CTT` varchar(1000) DEFAULT NULL COMMENT '섹션 내용',
  `SRVY_SCTN_NO` varchar(10) DEFAULT NULL COMMENT '섹션 번호',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `REG_DT` timestamp NULL DEFAULT NULL COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`SRVY_SCTN_SERNO`) USING BTREE,
  KEY `SRVY_SCTN_SERNO` (`SRVY_SCTN_SERNO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='설문조사 섹션관리 테이블';


-- stan.t_term_mng definition

CREATE TABLE `t_term_mng` (
  `TERM_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '용어일련번호',
  `TERM_NM` varchar(100) DEFAULT NULL COMMENT '용어명',
  `TERM_ENG_NM` varchar(60) DEFAULT NULL COMMENT '용어영문명',
  `DMN_NM` varchar(60) DEFAULT NULL COMMENT '도메인명',
  `STD_YN` varchar(10) DEFAULT NULL COMMENT '표준여부',
  `TERM_EXPL` varchar(4000) DEFAULT NULL COMMENT '용어설명',
  `PINF_YN` char(1) DEFAULT NULL COMMENT '개인정보여부',
  `ENC_YN` char(1) DEFAULT NULL COMMENT '암호화여부',
  `DMN_GRP` varchar(60) DEFAULT NULL COMMENT '도메인그룹',
  `DATA_TP` varchar(60) DEFAULT NULL COMMENT '데이터타입',
  `DATA_LEN` int(15) DEFAULT NULL COMMENT '길이',
  `DATA_LEN_DCPT` int(15) DEFAULT NULL COMMENT '길이(소수점)',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT current_timestamp() COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`TERM_SERNO`),
  UNIQUE KEY `UK_TERM_ENG_NM` (`TERM_ENG_NM`)
) ENGINE=InnoDB AUTO_INCREMENT=167810 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='용어관리';


-- stan.t_terms_mng definition

CREATE TABLE `t_terms_mng` (
  `TERMS_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '약관일련번호',
  `TERMS_CL_CD` varchar(10) NOT NULL COMMENT '약관구분코드',
  `SEQO` int(4) DEFAULT NULL COMMENT '순서',
  `TITL_NM` varchar(200) DEFAULT NULL COMMENT '제목명',
  `TERMS_CTT` longtext DEFAULT NULL COMMENT '약관내용',
  `SEL_TP_CD` varchar(10) DEFAULT NULL COMMENT '선택유형코드',
  `PRD_UNIT_CD` varchar(10) DEFAULT NULL COMMENT '기간단위코드',
  `OTPT_STRT_DT` timestamp NULL DEFAULT NULL COMMENT '출력시작일시',
  `OTPT_END_DT` timestamp NULL DEFAULT NULL COMMENT '출력종료일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `EXPSR_YN` char(1) DEFAULT 'Y' COMMENT '노출여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`TERMS_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='약관관리';


-- stan.t_user_id_rst_mng definition

CREATE TABLE `t_user_id_rst_mng` (
  `USER_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '사용자 일련번호',
  `USER_ID` varchar(100) NOT NULL COMMENT '사용자 ID',
  `BRK_YN` char(1) DEFAULT 'Y' COMMENT '차단 여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT NULL COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  PRIMARY KEY (`USER_SERNO`) COMMENT '사용 여부'
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='사용자 아이디 제한 관리';


-- stan.t_user_ip_mng definition

CREATE TABLE `t_user_ip_mng` (
  `IP_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'IP 일련번호',
  `USER_SERNO` int(11) NOT NULL COMMENT '사용자 일련번호',
  `STRT_IP` varchar(15) DEFAULT NULL COMMENT '시작 IP',
  `END_IP` varchar(15) DEFAULT NULL COMMENT '종료 IP',
  `BAWD_YN` char(1) DEFAULT NULL COMMENT '대역폭 여부',
  `SEQO` int(4) DEFAULT NULL COMMENT '순서',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT current_timestamp() COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`IP_SERNO`,`USER_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- stan.t_user_mng definition

CREATE TABLE `t_user_mng` (
  `USER_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '사용자 일련번호',
  `USER_ID` varchar(100) NOT NULL COMMENT '사용자 ID',
  `USER_PSWD` varchar(100) DEFAULT NULL COMMENT '사용자 비밀번호',
  `USER_NM` varchar(100) DEFAULT NULL COMMENT '사용자 명',
  `GRP_AUTH_ID` varchar(30) DEFAULT NULL COMMENT '그룹 권한 ID',
  `USER_TEL_NO` varchar(100) NOT NULL COMMENT '사용자 전화번호 값',
  `USER_EMAIL_ADDR` varchar(320) DEFAULT NULL COMMENT '이메일 주소',
  `PSWD_MSMT_NOCS` int(10) DEFAULT 0 COMMENT '비밀번호 불일치 건수',
  `BRK_YN` char(1) DEFAULT 'N' COMMENT '차단 여부',
  `LST_ACS_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '최종 접속 일시',
  `LST_PSWD_CHG_DT` date DEFAULT current_timestamp() COMMENT '최종 비밀번호 변경 일시',
  `AUTH_AREA_CD` varchar(10) DEFAULT 'FT' COMMENT '권한 영역 코드',
  `SNS_SE_CD` varchar(10) DEFAULT NULL COMMENT 'SNS 구분 코드',
  `SNS_USER_ID` varchar(100) DEFAULT NULL COMMENT 'SNS 사용자 ID',
  `INTG_YN` char(1) DEFAULT 'N' COMMENT '통합 여부',
  `POST_NO` char(5) DEFAULT NULL COMMENT '우편 번호',
  `HOME_ADDR` varchar(200) DEFAULT NULL COMMENT '자택 주소',
  `HOME_ADDR_DTLS` varchar(200) DEFAULT NULL COMMENT '자택 주소 상세',
  `BLON_NM` varchar(100) DEFAULT NULL COMMENT '소속 명',
  `FAX_NO` varchar(20) DEFAULT NULL COMMENT '팩스 번호',
  `INLN_NO` varchar(10) DEFAULT NULL COMMENT '내선 번호',
  `JRNK_CD` varchar(10) DEFAULT 'JR01' COMMENT '직급 코드',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT current_timestamp() COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`USER_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='사용자관리';


-- stan.t_user_scss_mng definition

CREATE TABLE `t_user_scss_mng` (
  `USER_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '사용자 일련번호',
  `USER_ID` varchar(100) DEFAULT NULL COMMENT '사용자 ID',
  `USER_PSWD` varchar(100) DEFAULT NULL COMMENT '사용자 비밀번호',
  `USER_NM` varchar(100) DEFAULT NULL COMMENT '사용자 명',
  `GRP_AUTH_ID` varchar(30) DEFAULT NULL COMMENT '그룹 권한 ID',
  `USER_TEL_NO` varchar(100) DEFAULT NULL COMMENT '사용자 전화번호',
  `USER_EMAIL_ADDR` varchar(320) DEFAULT NULL COMMENT '사용자 이메일 주소',
  `PSWD_MSMT_NOCS` int(10) DEFAULT 0 COMMENT '비밀번호 불일치 건수',
  `BRK_YN` char(1) DEFAULT NULL COMMENT '차단 여부',
  `LST_ACS_DT` date DEFAULT NULL COMMENT '최종 접속 일시',
  `LST_PSWD_CHG_DT` date DEFAULT NULL COMMENT '최종 비밀번호 변경 일시',
  `AUTH_AREA_CD` varchar(10) DEFAULT NULL COMMENT '권한 영역 코드',
  `SNS_SE_CD` varchar(10) DEFAULT NULL COMMENT 'SNS 구분 코드',
  `SNS_USER_ID` varchar(100) DEFAULT NULL COMMENT 'SNS 사용자 ID',
  `INTG_YN` char(1) DEFAULT NULL COMMENT '통합 여부',
  `POST_NO` char(5) DEFAULT NULL COMMENT '우편 번호',
  `HOME_ADDR` varchar(200) DEFAULT NULL COMMENT '자택 주소',
  `HOME_ADDR_DTLS` varchar(200) DEFAULT NULL COMMENT '자택 주소 상세',
  `BLON_NM` varchar(100) DEFAULT NULL COMMENT '소속 명',
  `FAX_NO` varchar(20) DEFAULT NULL COMMENT '팩스 번호',
  `INLN_NO` varchar(10) DEFAULT NULL COMMENT '내선 번호',
  `JRNK_CD` varchar(10) DEFAULT NULL COMMENT '직급 코드',
  `SCSS_DT` date DEFAULT current_timestamp() COMMENT '탈퇴 일시',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT NULL COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT NULL COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`USER_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='사용자탈퇴관리';


-- stan.t_user_terms_mng definition

CREATE TABLE `t_user_terms_mng` (
  `USER_SERNO` int(11) NOT NULL COMMENT '사용자일련번호',
  `TERMS_SERNO` int(11) NOT NULL COMMENT '약관일련번호',
  `PRD_UNIT_CD` varchar(10) DEFAULT NULL COMMENT '기간단위코드',
  `TERMS_AGRE_YN` char(1) DEFAULT NULL COMMENT '약관동의여부',
  `TERMS_AGRE_YMD` varchar(8) DEFAULT NULL COMMENT '약관동의일자',
  `TERMS_EXP_YMD` varchar(8) DEFAULT NULL COMMENT '약관만료일자',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용여부',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자일련번호',
  `REG_DT` timestamp NULL DEFAULT current_timestamp() COMMENT '등록일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자일련번호',
  `UPD_DT` timestamp NULL DEFAULT NULL COMMENT '수정일시',
  PRIMARY KEY (`USER_SERNO`,`TERMS_SERNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='사용자약관관리';


-- stan.t_wrd_mng definition

CREATE TABLE `t_wrd_mng` (
  `WRD_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '단어일련번호',
  `WRD_NM` varchar(60) DEFAULT NULL COMMENT '단어명',
  `ENG_NM` varchar(1000) DEFAULT NULL COMMENT '영문명',
  `ENG_ABRV_NM` varchar(60) DEFAULT NULL COMMENT '영문약어명',
  `WRD_EXPL` varchar(4000) DEFAULT NULL COMMENT '단어설명',
  `STD_WRD` varchar(60) DEFAULT NULL COMMENT '표준단어',
  `WRD_TP` varchar(60) DEFAULT NULL COMMENT '단어유형',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자 일련번호',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPDR_SERNO` int(11) DEFAULT NULL COMMENT '수정자 일련번호',
  `UPD_DT` date DEFAULT current_timestamp() COMMENT '수정 일시',
  `USE_YN` char(1) DEFAULT 'Y' COMMENT '사용 여부',
  PRIMARY KEY (`WRD_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=200777 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='단어관리';


-- stan.t_seo_mng_sub definition

CREATE TABLE `t_seo_mng_sub` (
  `SEO_SUB_SERNO` int(11) NOT NULL AUTO_INCREMENT COMMENT 'sub 테이블 기본키',
  `SEO_SERNO` int(11) DEFAULT NULL COMMENT 'seo 순번',
  `OPT_TYPE` varchar(30) DEFAULT NULL COMMENT '최적화 유형',
  `PROB_TAG` longtext DEFAULT NULL COMMENT '태그',
  `PROB_CONT` longtext DEFAULT NULL COMMENT '최적화 내용',
  `REG_DT` date DEFAULT current_timestamp() COMMENT '등록일',
  `REGR_SERNO` int(11) DEFAULT NULL COMMENT '등록자',
  `PROB_TIPS` varchar(900) DEFAULT NULL COMMENT '최적화 권장사항',
  `OPT_TYPE_DE_NO` int(3) DEFAULT 0 COMMENT '최적화 유형 상세번호',
  `PROB_EX` longtext DEFAULT NULL COMMENT '권장예시',
  PRIMARY KEY (`SEO_SUB_SERNO`),
  KEY `SEO_SERNO` (`SEO_SERNO`),
  CONSTRAINT `t_seo_mng_sub_ibfk_1` FOREIGN KEY (`SEO_SERNO`) REFERENCES `t_seo_mng` (`SEO_SERNO`)
) ENGINE=InnoDB AUTO_INCREMENT=17509 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;