package com.cn.hnust.service;

import java.util.List;
import java.util.Map;

import com.cn.hnust.pojo.Theme;
import com.cn.hnust.pojo.ThemeCondition;

public interface IThemeService {

	/**
	 * 根据不同条件查询主题信息同时分页
	 * @param map
	 * @return
	 */
	public abstract List<Theme> selectThemeByCondition(Map<String, Object> map);
	
	/**
     * 获取主题总记录数
     * @param map
     * @return获取的total数
     */
    public abstract int getTotal(ThemeCondition themeCondition);
    
    /**
     * 后台管理添加新主题
     * @param admin
     * @return
     */
    public abstract int insertTheme(Theme theme);
    
    /**
     * 后台管理删除主题
     * @param admin
     * @return
     */
    public abstract int deleteTheme(Theme theme);
    
    /**
     * 后台管理更新主题信息
     * @param theme
     * @return
     */
    public abstract int updateTheme(Theme theme);
    
    /**
     * 后台检查传入的Theme是否已经存在
     * @param theme
     * @return
     */
    public abstract Theme selectThemeByProperty(Theme theme);
}
