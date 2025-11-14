package kr.or.standard.basic.common.domain;


import java.util.*;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;

@Slf4j
public class CommonMap  extends LinkedHashMap{
       public CommonMap(){
        super();
    }

    public CommonMap(HttpServletRequest req){

        log.info("===========================================================");
        Enumeration<String> paramNames = req.getParameterNames();
        while(paramNames.hasMoreElements()){
            String key = paramNames.nextElement();
            log.info("key ==>> "+key+" , value = "+req.getParameter(key));
            super.put(key, req.getParameter(key));
        }
        log.info("==========================================================="); 
    }
    
    public CommonMap(HashMap hMap){
            super(hMap);  
    }
    
    public CommonMap extendsMap (HashMap hMap){
       Iterator it = hMap.keySet().iterator();
       while(it.hasNext()){
                String key = (String)it.next();
                super.put(key, hMap.get(key));
       }  
       return this;
    }
    
    public void put(String key , Object val){
        super.put(key, val);
    }

    public Object get(String key){ 
         Object rsltVal =  super.get(key);
         if(rsltVal instanceof String){
            return getString(key , "");
         }
         if(rsltVal instanceof  Integer){
             return getInt(key , 0);
         }
         else if(rsltVal instanceof Double){
            return (double) rsltVal;
         }
         else {
            return super.get(key);  
         } 
    }

  
    public ArrayList<String> getKeys(){
        ArrayList keys = new ArrayList();
        super.keySet().forEach((k)->{
            keys.add(k);
        });  
        return keys;
    }

    public Integer getInt(String key) {
        return getInt(key, 0);
    }

    public Integer getInt(String key, Integer defaultVal) {
        Object rsltVal = super.get(key); 
        if(rsltVal instanceof  Integer){
            return Integer.parseInt(""+rsltVal);
        }
        else {
            return defaultVal;
        } 
    }
    
    
    public String getString(String key){
        return getString(key,"");
    }
    
    public String getString(String key, String nullStr) {
        Object val = super.get(key); 
        if(val instanceof String){
            if(val == null || "".equals(val)){ 
                return nullStr;
            }else {
                return (String) val;
            }
        }else {
            return nullStr;
        } 
    } 
}

