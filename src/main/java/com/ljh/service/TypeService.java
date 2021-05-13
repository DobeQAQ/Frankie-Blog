package com.ljh.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.Type;
import com.ljh.vo.TypeVO;
import java.util.List;

public interface TypeService {

    int saveType(Type type);//保存一个分类

    Type getType(Long id);//获得一个分类

    Type getTypeByName(String name);//通过名字得到type

    IPage<Type> listType(Page<Type> page);//分页得到所有分类

    List<Type> listType();//获取所有的分类

    List<TypeVO> listTypeVO(); //列出所有分类及其所拥有的博客数

    List<Type> listBlogType();//获取该分类下的所有blog

    int updateType(Type type);//修改分类

    int deleteType(Long id);//删除分类

}
