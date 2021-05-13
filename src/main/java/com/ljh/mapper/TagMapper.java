package com.ljh.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ljh.entity.Tag;
import com.ljh.vo.TagVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TagMapper extends BaseMapper<Tag> {

    //查询所有数量的type
    List<TagVO> listTagVO();

}
