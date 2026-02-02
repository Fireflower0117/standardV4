<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<tr id="ip_tr_${cnt}">
    <td class="ip_td"></td>
    <td colspan="2" class="l">
        <input type="text" id="ip_strtIpVal_${cnt}_1" class="text w100px ipChg" maxlength="3">
        <span>.</span>
        <input type="text" id="ip_strtIpVal_${cnt}_2" class="text w100px ipChg" maxlength="3">
        <span>.</span>
        <input type="text" id="ip_strtIpVal_${cnt}_3" class="text w100px ipChg" maxlength="3">
        <span>.</span>
        <input type="text" id="ip_strtIpVal_${cnt}_4" class="text w100px ipChg" maxlength="3">
        <div style="display: none;" id="div_${cnt}">
            <span class="mar_l5 mar_r5">~</span>
            <input type="text" id="ip_endIpVal_${cnt}_1" class="text w100px ipChg" maxlength="3">
            <span>.</span>
            <input type="text" id="ip_endIpVal_${cnt}_2" class="text w100px ipChg" maxlength="3">
            <span>.</span>
            <input type="text" id="ip_endIpVal_${cnt}_3" class="text w100px ipChg" maxlength="3">
            <span>.</span>
            <input type="text" id="ip_endIpVal_${cnt}_4" class="text w100px ipChg" maxlength="3">
        </div>
        <div>
            <input type="hidden" id="ip_strtIp_${cnt}" value="" title="IP" required="true">
            <input type="hidden" id="ip_endIp_${cnt}" value="" title="종료IP" >
        </div>

    </td>
    <td>
        <select id="ip_bawdYn_${cnt}">
            <option value="N" label="단일" selected="selected">
            <option value="Y" label="대역폭">
        </select>
    </td>
    <td>
        <input type="hidden" id="ip_ipSerno_${cnt}" value="">
        <input type="hidden" id="ip_seqo_${cnt}" value="">
        <a href="javascript:void(0)" class="btn sml red" id="ip_del_${cnt}"><span>삭제</span></a>
    </td>
</tr>