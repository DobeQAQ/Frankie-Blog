package com.ljh.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.Blog;
import com.ljh.vo.BlogQuery;
import com.ljh.vo.BlogVO;
import java.util.List;
import java.util.Map;

public interface BlogService {

    //根据id查询一篇博客
    Blog getBlog(Long id);

    //根据blog的id查出博客详情
    BlogVO getBlogVO(Long id);

    IPage<BlogVO> listBlog(Page<BlogVO> page);//查询所有blog

    IPage<BlogVO> listPublishedBlog(Page<BlogVO> page);//查询所有pubilshed的blog

    IPage<BlogVO> listBlogSearch(Page<BlogVO> page, BlogQuery blogQuery);//根据条件查询一组blog

    int saveBlog(Blog blog); //新增一篇博客

    int updateBlog(Blog blog);  //修改Blog

    int deleteBlog(Long id);//删除Blog

    IPage<BlogVO> listSearchBlog(Page<BlogVO> page, String query); //根据简介或标题列出所有博客

    IPage<BlogVO> listBlogByType(Page<BlogVO> page, Long id);//根据分类id列出所有博客

    IPage<BlogVO> listBlogByTag(Page<BlogVO> page, Long id);//根据分类id列出所有博客

    Integer countBlogByType(Long id); //根据分类id统计该分类下有多少blog

    Integer countBlogByTag(Long id); //根据标签id统计该分类下有多少blog

    List<Blog> listRecommendBlogTop(Integer size); //列出size篇推荐博客

    Integer countBlog();//统计博客总数

    Integer countSearchBlog(String query);//统计查询总数

    Map<String, List<BlogVO>> archiveBlog();//归档

    List<Blog> getNewBlogs();//最新博客

}
