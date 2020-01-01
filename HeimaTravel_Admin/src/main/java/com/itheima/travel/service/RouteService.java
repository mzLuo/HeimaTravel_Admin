package com.itheima.travel.service;

import com.itheima.travel.dao.RouteDao;
import com.itheima.travel.entity.PageBean;
import com.itheima.travel.entity.Route;
import com.itheima.travel.utils.DaoInstanceFactory;

import java.util.List;

/**
 * 线路业务层
 */
public class RouteService {
    //依赖于数据访问层
    private RouteDao routeDao = DaoInstanceFactory.getBean(RouteDao.class);

    /**
     * 查询1页的数据
     * @param current 当前第几页
     * @return
     */
    public PageBean<Route> getPageBean(int current,String rname) {
        //1.得到current和size
        int size = 5;

        //2.得到data和count
        int begin = (current - 1) * size;
        List<Route> data = routeDao.findListByPage(begin, size,rname);

        int count = routeDao.getCount(rname);

        //3.封装成pageBean
        PageBean<Route> pageBean = new PageBean<>(data,count,current,size);

        //4.返回PageBean对象
        return pageBean;
    }

    /**
     * 通过rid删除一条线路
     */
    public void deleteByRid(int rid) {
        routeDao.deleteByRid(rid);
    }
}
