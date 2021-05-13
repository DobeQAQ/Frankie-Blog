package com.ljh.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.Tag;
import com.ljh.entity.Type;
import com.ljh.vo.TagVO;


import java.util.List;

public interface TagService {


    int saveTag(Tag tag);//保存一个标签

    Tag getTag(Long id);//获得一个标签

    Tag getTagByName(String name);//通过名字得到tag

    IPage<Tag> listTag(Page<Tag> page);//分页得到所有标签

    List<Tag> listTag();// 得到所有标签

    List<TagVO> listTagVO();//列出所有标签及其所拥有的博客数

    int updateTag(Tag tag);//修改标签

    int deleteTag(Long id);//删除标签

}

