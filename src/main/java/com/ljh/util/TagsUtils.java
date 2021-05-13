package com.ljh.util;



import com.ljh.entity.Tag;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author manster
 * @Date 2021/4/25
 **/
public class TagsUtils {

    //将 [tag1{1,"a"},tag2{2,"b"},tag3{3,"c"}] 转换为 1,2,3
    public static String TagsListToString(List<Tag> tags){
        if(!tags.isEmpty()){
            StringBuffer ids = new StringBuffer();
            boolean flag = false;
            for(Tag tag: tags){
                if(flag){
                    ids.append(",");
                }else {
                    flag = true;
                }
                ids.append(tag.getId());
            }
            return ids.toString();
        }else {
            return "";
        }
    }

    //将 1,2,3 转换为 [1,2,3]
    public static List<Long> convertToList(String ids){
        List<Long> list = new ArrayList<>();
        if(!"".equals(ids) && ids != null){
            String[] idArr = ids.split(",");
            for (String s : idArr) {
                list.add(Long.valueOf(s));
            }
        }
        return list;
    }

}
