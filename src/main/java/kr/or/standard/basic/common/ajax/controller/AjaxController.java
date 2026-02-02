package kr.or.standard.basic.common.ajax.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import kr.or.standard.basic.common.ajax.service.BasicCrudService;
import kr.or.standard.basic.common.domain.CommonMap;
import kr.or.standard.basic.common.modules.JacksonParsing;
import kr.or.standard.basic.common.modules.RereadableRequestWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;


@Slf4j
@Controller
public class AjaxController {

    @Autowired
    private BasicCrudService baiscCrudService;

    @RequestMapping(value="/com/query/selectList.ajx")
    public void queryPostSelectList(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        ObjectMapper mapper = new ObjectMapper();
        List<CommonMap> jsonList = (List<CommonMap>)getJason(request, "selectList");

        response.setCharacterEncoding("utf-8");
        response.getWriter().print(mapper.writeValueAsString(jsonList));
    }

    @RequestMapping(value="/com/query/selectOne.ajx")
    public void queryPostSelectOne(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        ObjectMapper mapper = new ObjectMapper();
        CommonMap  jsonOne = (CommonMap)getJason(request, "selectOne");
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(mapper.writeValueAsString(jsonOne));
    }

    @RequestMapping(value="/com/query/multiSelect.ajx")
    public void queryMultiSelect(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        ObjectMapper mapper = new ObjectMapper();
        List<CommonMap> jsonList = (List<CommonMap>)getJason(request, "multiSelect");
        response.setCharacterEncoding("utf-8");
        response.getWriter().print(mapper.writeValueAsString(jsonList));
    }


    protected Object getJason(HttpServletRequest request, String cmd) throws IOException {

        String qid = request.getParameter("qid");
        List<CommonMap> listMap = null;
        String data = getBody(request);
        if(data != null && !data.isEmpty()) {
            listMap = JacksonParsing.toList(data);
        }
        CommonMap parmMap = listMap.get(0);

        if("selectList".equals(cmd)){
            return baiscCrudService.selectList(qid, parmMap);
        }
        else if("selectOne".equals(cmd)){
            return baiscCrudService.selectOne(qid, parmMap);
        }
        else if("multiSelect".equals(cmd)){
            return baiscCrudService.multiSelect(parmMap);
        }
        else {
            return new CommonMap();
        }
    }

    /**************************************************************************/
    @PostMapping(value="/com/query/insert.ajx", produces = "text/html; charset=utf-8")
    public @ResponseBody String
    executeInsert(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        return executeQuery(request, response, "insert");
    }

    @PostMapping(value="/com/query/insertlist.ajx", produces = "text/html; charset=utf-8")
    public @ResponseBody String
    executeInsertList(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        return executeQuery(request, response, "insertlist");
    }


    @PostMapping(value="/com/query/update.ajx", produces = "text/html; charset=utf-8")
    public @ResponseBody String
    executeUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        return executeQuery(request, response, "update");
    }

    @PostMapping(value="/com/query/updatelist.ajx", produces = "text/html; charset=utf-8")
    public @ResponseBody String
    executeUpdateList(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        return executeQuery(request, response, "updatelist");
    }




    @PostMapping(value="/com/query/delete.ajx", produces = "text/html; charset=utf-8")
    public @ResponseBody String
    executeDelete(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        return executeQuery(request, response,"delete");
    }

    @PostMapping(value="/com/query/deletelist.ajx", produces = "text/html; charset=utf-8")
    public @ResponseBody String
    executeDeleteList(HttpServletRequest request, HttpServletResponse response) throws IOException, UnsupportedEncodingException {
        return executeQuery(request, response,"deletelist");
    }

    private String executeQuery(HttpServletRequest request,HttpServletResponse response, String method) throws IOException {
        return  baiscCrudService.doMultiActionExecute(request, response, method );
    }

    public String getBody(HttpServletRequest request) throws IOException {
        RereadableRequestWrapper rereadableRequestWrapper = new RereadableRequestWrapper((HttpServletRequest)request);
        return JacksonParsing.getBody(rereadableRequestWrapper).toString();
    }

}



