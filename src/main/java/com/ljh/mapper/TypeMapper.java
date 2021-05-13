package com.ljh.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ljh.entity.Type;
import com.ljh.entity.User;
import com.ljh.vo.TypeVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TypeMapper extends BaseMapper<Type> {

    //查询所有数量的type
    List<TypeVO> listTypeVO();

}
