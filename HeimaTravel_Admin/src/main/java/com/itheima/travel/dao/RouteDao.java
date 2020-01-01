package com.itheima.travel.dao;

import com.itheima.travel.entity.Route;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 线路的DAO
 */

public interface RouteDao {
    /**
     * 查询所有线路的记录数
     */
    @Select("select count(1) from tab_route where rname like \"%\"#{rname}\"%\"")
    int getCount(String rname);

    /**
     * 查询一页的线路数据，按id的降序排序
     */
    @Select("select * from tab_route where rname like \"%\"#{rname}\"%\" order by rid desc limit #{begin}, #{size}")
    List<Route> findListByPage(@Param("begin")int begin, @Param("size")int size,@Param("rname")String rname);

    /**
     * 通过rid删除一条线路
     */
    @Delete("delete from tab_route where rid = #{rid}")
    int deleteByRid(int rid);
}
