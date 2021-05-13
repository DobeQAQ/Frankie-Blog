package com.ljh.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.NotFoundException;
import com.ljh.entity.BlogAndTags;
import com.ljh.mapper.BlogAndTagsMapper;
import com.ljh.mapper.TagMapper;
import com.ljh.entity.Tag;

import com.ljh.service.TagService;
import com.ljh.vo.TagVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class TagServiceImpl implements TagService {

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private BlogAndTagsMapper blogAndTagsMapper;

    @Transactional
    @Override
    public int saveTag(Tag tag) {
        return tagMapper.insert(tag);
    }

    @Override
    public Tag getTag(Long id) {
        return tagMapper.selectById(id);
    }

    @Override
    public Tag getTagByName(String name) {
        return tagMapper.selectOne(new QueryWrapper<Tag>().eq("name", name));
    }

    @Override
    public IPage<Tag> listTag(Page<Tag> page) {
        return tagMapper.selectPage(page, null);
    }

    @Override
    public List<Tag> listTag() {
        return tagMapper.selectList(null);
    }

    @Override
    public List<TagVO> listTagVO() {
        return tagMapper.listTagVO();
    }


    @Transactional
    @Override
    public int updateTag(Tag tag) {
        return tagMapper.updateById(tag);
    }

    @Transactional
    @Override
    public int deleteTag(Long id) {
        //删除标签时，将中间表关于该id的所有信息删除
        blogAndTagsMapper.delete(new QueryWrapper<BlogAndTags>().eq("tag_id",id));
        return tagMapper.deleteById(id);
    }


}
