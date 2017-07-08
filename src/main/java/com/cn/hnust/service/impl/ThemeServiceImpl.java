package com.cn.hnust.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cn.hnust.dao.ThemeMapper;
import com.cn.hnust.pojo.Theme;
import com.cn.hnust.pojo.ThemeCondition;
import com.cn.hnust.service.IThemeService;

@Service("themeService")
public class ThemeServiceImpl implements IThemeService {

	@Resource
	private ThemeMapper themeMapper;
	
	@Override
	public List<Theme> selectThemeByCondition(Map<String, Object> map) {
		return themeMapper.selectThemeByCondition(map);
	}

	@Override
	public int getTotal(ThemeCondition themeCondition) {
		return themeMapper.getTotal(themeCondition);
	}

	@Override
	public int insertTheme(Theme theme) {
		return themeMapper.insertTheme(theme);
	}

	@Override
	public int deleteTheme(Theme theme) {
		return themeMapper.deleteTheme(theme);
	}

	@Override
	public int updateTheme(Theme theme) {
		return themeMapper.updateTheme(theme);
	}

	@Override
	public Theme selectThemeByProperty(Theme theme) {
		return themeMapper.selectThemeByProperty(theme);
	}

}
