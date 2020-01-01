package com.itheima.travel.web.servlet;

import com.itheima.travel.entity.PageBean;
import com.itheima.travel.entity.Route;
import com.itheima.travel.service.RouteService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 线路的控制器
 */
@WebServlet("/route")
public class RouteServlet extends BaseServlet {
    private RouteService routeService = new RouteService();

    /**
     * 查询1页的线路数据
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    private void listByPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.得到current的值
        //1.5 对参数进行判断
        String current = request.getParameter("current");
        if (current == null) {
            current = "1";  //默认为1
        }
        //1.6 从客户端获取参数
        String rname = request.getParameter("rname");
        if (rname == null) {
            rname = "";    //默认为空串
        }
        //将查询的数据回显
        request.setAttribute("rname",rname);
        //2.调用业务层得到PageBean
        PageBean<Route> pageBean = routeService.getPageBean(Integer.parseInt(current), rname);
        //3.放在请求域中
        request.setAttribute("pageBean",pageBean);
        //4.转发到route_list.jsp页面
        request.getRequestDispatcher("/pages/route/route_list.jsp").forward(request,response);
    }

    /**
     * 通过rid删除一条线路
     */
    private void delRoute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.得到rid
        int rid = Integer.parseInt(request.getParameter("rid"));
        //2.调用业务层删除
        routeService.deleteByRid(rid);
        //2.2 得到从哪个页面过来的
        String backurl = request.getHeader("referer");
        //3.跳转到显示线路列表页面，跳回到原来的页面
        response.sendRedirect(backurl);
    }


}
