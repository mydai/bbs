package com.cn.hnust.dao;

import com.cn.hnust.pojo.Postings_Theme;

public interface Postings_ThemeMapper {
    int deleteByPrimaryKey(Long ptid);

    int insert(Postings_Theme record);

    int insertSelective(Postings_Theme record);

    Postings_Theme selectByPrimaryKey(Long ptid);

    int updateByPrimaryKeySelective(Postings_Theme record);

    int updateByPrimaryKey(Postings_Theme record);
}