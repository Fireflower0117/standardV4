const encryptionFns = {

    encrypt (encInfo){
        if( opnt.valid.isEmpty(encInfo.encVal) ) return null;

        let encAlType = opnt.str.nvl(encInfo.encAlgorithm , "sha512"); // 암호화 기본값 ( SHA 512 )
        if(encAlType === "sha512"){
            return opnt.enc.shaEncrypt512(encInfo.encVal)
        }
    }
    , shaEncrypt512 (orgStr) {
        // Html Head에 Sha512.js가 없으면 동적 생성
        if ($('script[src="/external/sha/sha512.js"]').length == 0) {
            $('<script>').attr('type', 'text/javascript').attr('src', '/external/sha/sha512.js').appendTo('head');
            setTimeout(function () {}, 500); // 가져오는 속도 감안 0.5초 대기(혹시나....)
        }

        var shaObj = new jsSHA("SHA-512", "TEXT"); // v3라면 옵션 추가 가능: , { encoding: "UTF8" }
        shaObj.update(opnt.str.trimAll(orgStr));
        return shaObj.getHash("HEX");
    }
}


export default encryptionFns;