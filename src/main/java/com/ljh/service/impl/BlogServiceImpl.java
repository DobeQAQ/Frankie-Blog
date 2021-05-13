package com.ljh.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ljh.entity.BlogAndTags;
import com.ljh.entity.Tag;
import com.ljh.mapper.BlogAndTagsMapper;
import com.ljh.mapper.BlogMapper;
import com.ljh.entity.Blog;
import com.ljh.mapper.TagMapper;
import com.ljh.service.BlogService;
import com.ljh.util.MarkdownUtils;
import com.ljh.util.TagsUtils;
import com.ljh.vo.BlogQuery;
import com.ljh.vo.BlogVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class BlogServiceImpl implements BlogService {

    @Autowired
    private BlogMapper blogMapper;

    @Autowired
    private BlogAndTagsMapper blogAndTagsMapper;

    @Autowired
    private TagMapper tagMapper;

    private List<Long> tagsId;

    private List<Tag> convertToTagList(String ids) {
        tagsId = TagsUtils.convertToList(ids);
        List<Tag> tagList = new ArrayList<>();
        Tag tag;
        for (Long tagId : tagsId) {
            tag = tagMapper.selectById(tagId);
            tagList.add(tag);
        }
        return tagList;
    }

    @Override
    public Blog getBlog(Long id) {
        return blogMapper.selectById(id);
    }

    @Override
    public BlogVO getBlogVO(Long id) {
        //浏览数+1
        blogMapper.addViews(id);
        //查找
        BlogVO blogVO = blogMapper.getBlogVO(id);
        blogVO.setContent(MarkdownUtils.markdownToHtmlExtensions(blogVO.getContent()));
        blogVO.setTags(convertToTagList(blogVO.getTagIds()));
        return blogVO;
    }

    @Override
    public IPage<BlogVO> listBlog(Page<BlogVO> page) {
        return blogMapper.listBlog(page);
    }

    @Override
    public IPage<BlogVO> listPublishedBlog(Page<BlogVO> page) {
        IPage<BlogVO> iPage = blogMapper.listPublishedBlog(page);
        List<BlogVO> blogVOList = iPage.getRecords();
        for (BlogVO blogVO : blogVOList) {
            blogVO.setTags(convertToTagList(blogVO.getTagIds()));
        }
        iPage.setRecords(blogVOList);
        return iPage;
    }

    @Override
    public IPage<BlogVO> listBlogSearch(Page<BlogVO> page, BlogQuery blogQuery) {
        return blogMapper.listBlogSearch(page, blogQuery);
    }

    @Transactional
    @Override
    public int saveBlog(Blog blog) {
        blog.setCreateTime(LocalDateTime.now());
        blog.setUpdateTime(LocalDateTime.now());
        blog.setViews(0);
        if ("".equals(blog.getFlag())) blog.setFlag("原创");
        int res = blogMapper.insert(blog);
        //为中间表插入数据
        tagsId = TagsUtils.convertToList(blog.getTagIds());
        for (Long tagId : tagsId) {
            BlogAndTags bat = new BlogAndTags();
            bat.setBlogId(blog.getId());
            bat.setTagId(tagId);
            blogAndTagsMapper.insert(bat);
        }
        return res;
    }

    @Transactional
    @Override
    public int updateBlog(Blog blog) {
        blog.setUpdateTime(LocalDateTime.now());
        blogAndTagsMapper.delete(new QueryWrapper<BlogAndTags>().eq("blog_id", blog.getId()));
        tagsId = TagsUtils.convertToList(blog.getTagIds());
        for (Long tagId : tagsId) {
            BlogAndTags bat = new BlogAndTags();
            bat.setBlogId(blog.getId());
            bat.setTagId(tagId);
            blogAndTagsMapper.insert(bat);
        }
        return blogMapper.updateById(blog);
    }

    @Transactional
    @Override
    public int deleteBlog(Long id) {
        //删除该博客时，将所有中间表关于该博客的信息都删除
        blogAndTagsMapper.delete(new QueryWrapper<BlogAndTags>().eq("blog_id", id));
        return blogMapper.deleteById(id);
    }

    @Override
    public IPage<BlogVO> listSearchBlog(Page<BlogVO> page, String query) {
        IPage<BlogVO> iPage = blogMapper.listSearchBlog(page, query);
        List<BlogVO> blogVOList = iPage.getRecords();
        for (BlogVO blogVO : blogVOList) {
            blogVO.setTags(convertToTagList(blogVO.getTagIds()));
        }
        iPage.setRecords(blogVOList);
        return iPage;
    }

    @Override
    public IPage<BlogVO> listBlogByType(Page<BlogVO> page, Long id) {
        IPage<BlogVO> iPage = blogMapper.listBlogByType(page, id);
        List<BlogVO> blogVOList = iPage.getRecords();
        for (BlogVO blogVO : blogVOList) {
            blogVO.setTags(convertToTagList(blogVO.getTagIds()));
        }
        iPage.setRecords(blogVOList);
        return iPage;
    }

    @Override
    public IPage<BlogVO> listBlogByTag(Page<BlogVO> page, Long id) {
        IPage<BlogVO> iPage = blogMapper.listBlogByTag(page, id);
        List<BlogVO> blogVOList = iPage.getRecords();
        for (BlogVO blogVO : blogVOList) {
            blogVO.setTags(convertToTagList(blogVO.getTagIds()));
        }
        iPage.setRecords(blogVOList);
        return iPage;
    }

    @Override
    public Integer countBlogByType(Long id) {
        return blogMapper.selectCount(new QueryWrapper<Blog>().eq("type_id", id));
    }

    @Override
    public Integer countBlogByTag(Long id) {
        return blogAndTagsMapper.selectCount(new QueryWrapper<BlogAndTags>().eq("tag_id", id));
    }

    @Override
    public List<Blog> listRecommendBlogTop(Integer size) {
        return blogMapper.selectList(new QueryWrapper<Blog>()
                .eq("published", 1)
                .eq("recommend", 1)
                .orderByDesc("update_time")
                .last("limit " + size));
    }

    @Override
    public Integer countBlog() {
        return blogMapper.selectCount(null);
    }

    @Override
    public Integer countSearchBlog(String query) {
        return blogMapper.selectCount(new QueryWrapper<Blog>().like("title", query).or().like("description", query));
    }

    @Override
    public Map<String, List<BlogVO>> archiveBlog() {
        List<String> years = blogMapper.getGroupYears();
        Map<String, List<BlogVO>> map = new LinkedHashMap<>();
        for (String year : years) {
            map.put(year, blogMapper.getBlogByYear(year));
            System.out.println(blogMapper.getBlogByYear(year));
        }
        return map;
    }

    @Override
    public List<Blog> getNewBlogs() {
        return blogMapper.selectNewBlogs();
    }
}
