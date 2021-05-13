package com.ljh.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.mapper.TypeMapper;
import com.ljh.entity.Type;
import com.ljh.service.TypeService;
import com.ljh.vo.TypeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class TypeServiceImpl implements TypeService {

    @Autowired
    private TypeMapper typeMapper;

    @Transactional
    @Override
    public int saveType(Type type) {
        return typeMapper.insert(type);
    }

    @Override
    public Type getType(Long id) {
        return typeMapper.selectById(id);
    }

    @Override
    public Type getTypeByName(String name) {
        return typeMapper.selectOne(new QueryWrapper<Type>().eq("name", name));
    }

    @Override
    public IPage<Type> listType(Page<Type> page) {
        return typeMapper.selectPage(page, null);
    }

    @Override
    public List<Type> listType() {
        return typeMapper.selectList(null);
    }

    @Override
    public List<TypeVO> listTypeVO() {
        return typeMapper.listTypeVO();
    }

    @Override
    public List<Type> listBlogType() {
        return null;
    }

    @Transactional
    @Override
    public int updateType(Type type) {
        return typeMapper.updateById(type);
    }

    @Transactional
    @Override
    public int deleteType(Long id) {
        return typeMapper.deleteById(id);
    }
}
