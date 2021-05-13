package com.ljh.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.Blog;
import com.ljh.vo.BlogQuery;
import com.ljh.vo.BlogVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BlogMapper extends BaseMapper<Blog> {

    //根据BlogVO进行条件查询
    IPage<BlogVO> listBlogSearch(Page<BlogVO> page, BlogQuery blogQuery);

    //分页查询所有简单信息
    IPage<BlogVO> listBlog(Page<BlogVO> page);

    //分页查询已发布博客列表
    IPage<BlogVO> listPublishedBlog(Page<BlogVO> page);

    //分页查询搜索的blog,模糊查询 title 和 description
    IPage<BlogVO> listSearchBlog(Page<BlogVO> page, String query);

    //分页查询搜索的blog,模糊查询 title 和 description,在已发布的博客中
    IPage<BlogVO> listSearchPublishedBlog(Page<BlogVO> page, String query);

    //查询关于blog的一切
    BlogVO getBlogVO(Long id);

    //增加浏览量
    int addViews(Long id);

    //根据分类id查询blog
    IPage<BlogVO> listBlogByType(Page<BlogVO> page, Long id);

    //根据标签id查询blog
    IPage<BlogVO> listBlogByTag(Page<BlogVO> page, Long id);

    //获取所有年份
    List<String> getGroupYears();

    //根据年份获得博客
    List<BlogVO> getBlogByYear(String year);

    //获取最新博客
    List<Blog> selectNewBlogs();


}
