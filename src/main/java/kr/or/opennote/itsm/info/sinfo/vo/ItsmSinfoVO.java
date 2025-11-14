package kr.or.opennote.itsm.info.sinfo.vo;
 
import kr.or.opennote.itsm.common.vo.ItsmCommonDefaultVO;
import org.apache.ibatis.type.Alias;

import javax.validation.constraints.NotBlank;

@Alias("itsmSinfoVO")
public class ItsmSinfoVO extends ItsmCommonDefaultVO {
    public interface insertCheck {}
    public interface updateCheck {}
    public interface deleteCheck {}
    
    // 담당자 정보, 서버 정보 등 항목 업데이트 시 유효성 검사
    public interface itsmCheck {}

    @NotBlank(message = "도메인 URL : 필수 입력입니다.", groups = {ItsmSinfoVO.updateCheck.class, ItsmSinfoVO.insertCheck.class})
    private String svcUrl; /** 도메인 url*/
    
    @NotBlank(message = " 서비스명 : 필수 입력입니다.", groups = {ItsmSinfoVO.updateCheck.class, ItsmSinfoVO.insertCheck.class})
    private String svcNm; /** 서비스 명*/


    private String svcMngr; /** 서비스 담당자*/
    private String devMngr; /** 개발 담당자*/

    private String userSerno; /** 사용자 일련번호*/
    private String userSnList; /** 담당자 지정시 사용하는 담당자 일련번호 배열*/


    /** 서비스 서버 항목 변수 */
    private String svcServerSn; /** 서버 항목 일련번호 */
    private String serverGbn; /** 서버 구분*/
    private String serverIp; /** 서버 ip*/
    private String serverPort;
    private String serverPath;
    private String serverLogPath;
    private String serverOs;
    private String serverRamVol;
    private String serverStrgVol;
    private String serverType;
    private String serverVersion;
    private String serverSid;
    private String serverIde;

    /** 서비스 네트워크 항목 변수 */
    private String startIp; // 출발지 ip
    private String startPort; // 출발지 port
    private String endIp; // 목적지 ip
    private String endPort; // 목적지 포트
    private String subnetMask; // 서브넷 마스크
    private String broadCast; // 브로드캐스트 주소
    private String atchFileId; // 첨부파일

    public String getAtchFileId() {
        return atchFileId;
    }

    public void setAtchFileId(String atchFileId) {
        this.atchFileId = atchFileId;
    }

    public String getStartIp() {
        return startIp;
    }

    public void setStartIp(String startIp) {
        this.startIp = startIp;
    }

    public String getStartPort() {
        return startPort;
    }

    public void setStartPort(String startPort) {
        this.startPort = startPort;
    }

    public String getEndIp() {
        return endIp;
    }

    public void setEndIp(String endIp) {
        this.endIp = endIp;
    }

    public String getEndPort() {
        return endPort;
    }

    public void setEndPort(String endPort) {
        this.endPort = endPort;
    }

    public String getSubnetMask() {
        return subnetMask;
    }

    public void setSubnetMask(String subnetMask) {
        this.subnetMask = subnetMask;
    }

    public String getBroadCast() {
        return broadCast;
    }

    public void setBroadCast(String broadCast) {
        this.broadCast = broadCast;
    }

    public String getServerIde() {
        return serverIde;
    }

    public void setServerIde(String serverIde) {
        this.serverIde = serverIde;
    }

    public String getServerOs() {
        return serverOs;
    }

    public void setServerOs(String serverOs) {
        this.serverOs = serverOs;
    }

    public String getUserSerno() {
        return userSerno;
    }

    public void setUserSerno(String userSerno) {
        this.userSerno = userSerno;
    }

    public String getUserSnList() {
        return userSnList;
    }

    public void setUserSnList(String userSnList) {
        this.userSnList = userSnList;
    }

    public String getSvcServerSn() {
        return svcServerSn;
    }

    public void setSvcServerSn(String svcServerSn) {
        this.svcServerSn = svcServerSn;
    }

    public String getServerGbn() {
        return serverGbn;
    }

    public void setServerGbn(String serverGbn) {
        this.serverGbn = serverGbn;
    }

    public String getServerIp() {
        return serverIp;
    }

    public void setServerIp(String serverIp) {
        this.serverIp = serverIp;
    }

    public String getServerPort() {
        return serverPort;
    }

    public void setServerPort(String serverPort) {
        this.serverPort = serverPort;
    }

    public String getServerPath() {
        return serverPath;
    }

    public void setServerPath(String serverPath) {
        this.serverPath = serverPath;
    }

    public String getServerRamVol() {
        return serverRamVol;
    }

    public void setServerRamVol(String serverRamVol) {
        this.serverRamVol = serverRamVol;
    }

    public String getServerStrgVol() {
        return serverStrgVol;
    }

    public void setServerStrgVol(String serverStrgVol) {
        this.serverStrgVol = serverStrgVol;
    }

    public String getServerType() {
        return serverType;
    }

    public void setServerType(String serverType) {
        this.serverType = serverType;
    }

    public String getServerVersion() {
        return serverVersion;
    }

    public void setServerVersion(String serverVersion) {
        this.serverVersion = serverVersion;
    }

    public String getServerSid() {
        return serverSid;
    }

    public void setServerSid(String serverSid) {
        this.serverSid = serverSid;
    }


    public String getSvcUrl() {
        return svcUrl;
    }

    public void setSvcUrl(String svcUrl) {
        this.svcUrl = svcUrl;
    }

    public String getSvcMngr() {
        return svcMngr;
    }

    public void setSvcMngr(String svcMngr) {
        this.svcMngr = svcMngr;
    }

    public String getDevMngr() {
        return devMngr;
    }

    public void setDevMngr(String devMngr) {
        this.devMngr = devMngr;
    }

    public String getServerLogPath() {
        return serverLogPath;
    }

    public void setServerLogPath(String serverLogPath) {
        this.serverLogPath = serverLogPath;
    }

    public String getSvcNm() {
        return svcNm;
    }

    public void setSvcNm(String svcNm) {
        this.svcNm = svcNm;
    }
}
