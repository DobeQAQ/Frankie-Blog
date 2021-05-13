package com.ljh.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.BlogAndTags;

import com.ljh.vo.BlogVO;
import org.springframework.stereotype.Repository;


@Repository
public interface BlogAndTagsMapper extends BaseMapper<BlogAndTags> {
}
