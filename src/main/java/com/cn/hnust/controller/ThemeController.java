package com.cn.hnust.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cn.hnust.aop.SystemControllerLog;
import com.cn.hnust.pojo.Theme;
import com.cn.hnust.pojo.ThemeCondition;
import com.cn.hnust.service.IThemeService;
import com.cn.hnust.util.PageBean;

@Controller
@RequestMapping("/theme")
public class ThemeController {

	@Resource
	private IThemeService themeService;
	
	/**
	 * 后台管理获取主题列表信息,
	 * 还可以根据不同条件来查询相对应的主题信息
	 * 分页
	 * @param page
	 * @param rows
	 * @param themeCondition
	 * @return
	 */
	@RequestMapping("/admin_selectThemeList")
	@ResponseBody
	public Map<String, Object> admin_selectThemeList(String page,String rows,ThemeCondition themeCondition) {
		String tips = "";
		Map<String, Object> map = new HashMap<String, Object>();
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		map.put("pageBean", pageBean);
        map.put("themeCondition", themeCondition);
		List<Theme> themeList = this.themeService.selectThemeByCondition(map);
		int total = this.themeService.getTotal(themeCondition);
		Map<String, Object> modelMap = new HashMap<String, Object>();
		if(themeList!=null){
			modelMap.put("rows",themeList);
			modelMap.put("total", total);
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	/**
	 * 后台添加新主题
	 * @param theme
	 * @return
	 */
	@RequestMapping(value="/admin_insertTheme",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理插入新主题")
	public Map<String, Object> admin_insertTheme(Theme theme) {
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		Theme themes=this.themeService.selectThemeByProperty(theme);
		if(themes==null){
			int count=this.themeService.insertTheme(theme);
			if(count>0){
				tips="成功";
			}else{
				tips="失败";
			}
		}else{
			tips="该主题已存在";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台更新主题信息	
     * @param theme
     * @return
     */
	@RequestMapping(value="/admin_updateTheme",method = RequestMethod.POST)
	@ResponseBody
	@SystemControllerLog(description = "后台管理更新主题信息")
	public Map<String, Object> admin_updateTheme(Theme theme){
		String tips = "";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = this.themeService.updateTheme(theme);
		if(count>0){
			tips="成功";
		}else{
			tips="失败";
		}
		modelMap.put("tips", tips);
		return modelMap;
	}
	
    /**
     * 后台管理删除主题
     * @param userb
     * @return
     */
	@RequestMapping(value="/admin_deleteTheme",method = RequestMethod.GET)
	@ResponseBody
	@SystemControllerLog(description = "后台管理删除主题")
	public Map<String,Object> admin_deleteTheme(Theme theme,String tids){
		String tips = "删除成功";
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int count = 0;
		String[] tidStr = tids.split(",");
        for (String tid : tidStr) {
        	theme.setTid(Integer.parseInt(tid));
            count = this.themeService.deleteTheme(theme);
            if(count<=0){
            	tips="删除失败";
            	break;
            }else{
            	tips="删除成功";
            }
        }
		modelMap.put("tips", tips);
		return modelMap;
	}
	
	
}
