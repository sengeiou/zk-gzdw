package com.zzqx.mvc.controller;

import cn.hutool.core.util.URLUtil;
import cn.hutool.http.HttpUtil;
import com.zzqx.mvc.annotation.OpenAccess;
import com.zzqx.mvc.commons.CountInfo;
import com.zzqx.mvc.dto.CmdListDto;
import com.zzqx.mvc.entity.CmdList;
import com.zzqx.mvc.javabean.R;
import com.zzqx.mvc.javabean.ReturnData;
import com.zzqx.mvc.service.CmdListService;
import com.zzqx.mvc.vo.CmdListVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("cmdList")
public class CmdListController {
    @Autowired
    CmdListService cmdListService;


    /**
     *ipad 处理send方法请求接口(暂时不启用)
     */
    @OpenAccess
    @RequestMapping("send")
    @ResponseBody
    public R send(String directListName){
        List<CmdList> lists = cmdListService.allList(directListName);
        CmdList cmdList = lists.get(0);
        String directList = cmdList.getDirectList();
        try {
            String  urlString  = URLUtil.decode(directList);
            HttpUtil.get(CountInfo.LOCALHOST+urlString);
            return R.ok();
        }catch (Exception e){
            return R.error("网络不通");
        }
    }

    /**
     *ipad使用接口
     */
    @OpenAccess
    @RequestMapping("all")
    @ResponseBody
    public R allData(){
        String s = "";
        List<CmdList> cmdLists = cmdListService.allList(s);
//        List<CmdListOneVo> cmdLists = cmdListService.getListExcludeDirectList();
        return R.ok().put("data",cmdLists);
    }

    /**
     * 分页数据
     * @param cmdListDto
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public String selectWithCmdList(CmdListDto cmdListDto){
        //分页数据
        List<CmdList> list = cmdListService.getList(cmdListDto);
        //数据总数
        long total = cmdListService.getListCount(cmdListDto).size();
        ReturnData data = new ReturnData(total,list);
        cn.hutool.json.JSONArray array = new cn.hutool.json.JSONArray();
        array.add(data);
        String s = array.toString();
        String result  = s.substring(1,s.length()-1);
        return  result;
    }
    /**
     * 根据id查询数据
     */
    @RequestMapping("one")
    @ResponseBody
    public R getListById(String id){
        CmdListVo cmdListVo = cmdListService.getById(id);
//        CmdList cmdListVo = cmdListService.getByIdOne(id);
        return R.ok().put("data",cmdListVo);
    }
    /**
     *根据主键删除
     */
    @RequestMapping("delete")
    @ResponseBody
    public R deleteById(String id){
        cmdListService.deleteByPrimaryKey(id);
        return R.ok();
    }
    /**
     * 批量删除
     */
    //todo cmdList批量删除
    @RequestMapping("deleteByIds")
    @ResponseBody
    public R deleteByIds(String ids){
        System.out.print(ids);
        return R.ok();
    }
    /**
     * 保存
     */
    @RequestMapping("save")
    @ResponseBody
    public R save(CmdList cmdList){
        cmdListService.insertSelect(cmdList);
        return R.ok();
    }
    /**
     * 更新
     */
    @RequestMapping("edit")
    @ResponseBody
    public R updateById(CmdList cmdList){
        int s = cmdListService.updateSelect(cmdList);
        System.out.print(s);
        return R.ok();
    }


}
