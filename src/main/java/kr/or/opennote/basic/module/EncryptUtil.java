package kr.or.opennote.basic.module;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;

@Component
public class EncryptUtil extends EgovAbstractServiceImpl {
    
    
	public static String alg = "AES/CBC/PKCS5Padding";
    private static final String key = "32933069519662633673293306951323";
    private static final String iv = key.substring(0, 16); // 16byte

    public HashMap<String, String> getRSAKey() throws Exception {
        HashMap<String, String> returnMap = new HashMap<>();

        KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
        generator.initialize(1024);

        KeyPair keyPair = generator.genKeyPair();
        PublicKey publicKey = keyPair.getPublic();
        PrivateKey privateKey = keyPair.getPrivate();

        Base64.Encoder encoder = Base64.getEncoder();

        returnMap.put("publicKey", encoder.encodeToString(publicKey.getEncoded()));
        returnMap.put("privateKey", encoder.encodeToString(privateKey.getEncoded()));

        return returnMap;
    }

    public String getEncryptRSA(String text, String base64PublicKey) throws Exception {
        // base64 encode string > PublicKey.
        byte[] decodePublicKey = Base64.getDecoder().decode(base64PublicKey);
        PublicKey publicKey= KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(decodePublicKey));

        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);

        byte[] bytes = cipher.doFinal(text.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(bytes);
    }

    public String getDecryptRSA(String encText, String base64PrivateKey) throws Exception {
        Base64.Decoder decoder = Base64.getDecoder();

        // base64 encode string > PrivateKey.
        byte[] decodePrivateKey = decoder.decode(base64PrivateKey);
        PrivateKey privateKey = KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(decodePrivateKey));

        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, privateKey);

        return new String(cipher.doFinal(decoder.decode(encText)), StandardCharsets.UTF_8);
    }
    
    public String getEncryptAES256(String text) throws Exception {
        Cipher cipher = Cipher.getInstance(alg);
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");
        IvParameterSpec ivParamSpec = new IvParameterSpec(iv.getBytes());
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivParamSpec);

        byte[] encrypted = cipher.doFinal(text.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encrypted);
    }

    public static String getDecryptAES256(String cipherText) throws Exception {
        Cipher cipher = Cipher.getInstance(alg);
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");
        IvParameterSpec ivParamSpec = new IvParameterSpec(iv.getBytes());
        cipher.init(Cipher.DECRYPT_MODE, keySpec, ivParamSpec);

        byte[] decodedBytes = Base64.getDecoder().decode(cipherText);
        byte[] decrypted = cipher.doFinal(decodedBytes);
        return new String(decrypted, StandardCharsets.UTF_8);
    }

    public String getEncryptSHA256(String text) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(text.getBytes(StandardCharsets.UTF_8));

        StringBuilder builder = new StringBuilder();

        for (byte b : md.digest()) {
            builder.append(String.format("%02x", b));
        }

        return builder.toString();
    }

    public String getEncryptBCrypt(String text) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(text);
    }

    public boolean matchBCrypt(String rawPassword, String encodedPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    public static String getDecryptAES256HyPhen(String cipherText) throws Exception {
    	return getDecryptAES256(cipherText).replaceFirst("(^02|[0-9]{3})([0-9]{3,4})([0-9]{4})$", "$1-$2-$3");
    }
}
