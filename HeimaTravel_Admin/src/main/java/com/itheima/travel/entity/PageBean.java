package com.itheima.travel.entity;

import java.util.List;

/**
 * 封装页面对象
 */
public class PageBean<T> {
    /*
    根据属性值的获取方式，将8个属性分成3类：
    1. 值从数据库得到 data, count
    2. 由用户提交 current, size
    3. 由其它的属性计算出来的：total, first, previous,next。写在get方法中
     */
    private List<T> data; //这一页的数据
    private int count; //总条数

    private int total; //总页数
    private int first; //首页
    private int previous; //上一页
    private int next; //下一页

    private int current; //当前页
    private int size; //页面大小

    private int begin;  //下面页码的开始
    private int end;    //下面页码的结束

    public PageBean() {
    }

    public PageBean(List<T> data, int count, int current, int size) {
        this.data = data;
        this.count = count;
        this.current = current;
        this.size = size;
    }

    @Override
    public String toString() {
        return "PageBean{" +
                "data=" + getData() +
                ", count=" + getCount() +
                ", total=" + getTotal() +
                ", first=" + getFirst() +
                ", previous=" + getPrevious() +
                ", next=" + getNext() +
                ", current=" + getCurrent() +
                ", size=" + getSize() +
                '}';
    }

    /**
     * 计算开始和结束的页码
     * @return
     */
    public int getBegin() {
        //1. 如果总页数<=10,得出begin=1，end=总页数
        if (getTotal() <= 10) {
            setBegin(1);
            setEnd(getTotal());
        } else {
            //2. 如果总页数>10,得出begin=当前页-5，end=当前页+4。
            setBegin(getCurrent() - 5);
            setEnd(getCurrent() + 4);
            //3. 对begin和end进行修正
            //3.1. 如果begin<1,此时begin就无效了，起始页应从1开始，所以begin=1,end=10
            if (begin < 1) {  //注：不能调用getBegin，否则进入递归调用
                setBegin(1);
                setEnd(10);
            }
            //3.2. 如果end>总页数，此时end就无效了，结束页最大应为总页数，所以end=总页数，begin=end-9
            if (getEnd() > getTotal()) {
                setEnd(getTotal());
                setBegin(getEnd() - 9);
            }
        }
        return begin;
    }

    public void setBegin(int begin) {
        this.begin = begin;
    }

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    /*
    总页数 = 总行数 / 每页大小
    1. 如果能够整除就正好是这么多页
    2. 如果不能整除就加1
     */
    public int getTotal() {
        if (getCount() % getSize() == 0) {
            return getCount() / getSize();
        } else {
            return getCount() / getSize() + 1;
        }
    }

    public void setTotal(int total) {
        this.total = total;
    }

    //永远是第1页
    public int getFirst() {
        return 1;
    }

    public void setFirst(int first) {
        this.first = first;
    }

    /*
    1. 如果当前页是第1页，上一页也是第1页
    2. 否则：上一页 = 当前页 - 1
     */
    public int getPrevious() {
        if (getCurrent() > 1) {
            return getCurrent() - 1;
        } else {
            return 1;
        }
    }

    public void setPrevious(int previous) {
        this.previous = previous;
    }

    /*
    1. 如果当前页小于最后一页：下一页 = 当前页 + 1
    2. 否则下一页等于最后一页
     */
    public int getNext() {
        if (getCurrent() < getTotal()) {
            return getCurrent() + 1;
        } else {
            return getTotal();
        }
    }

    public void setNext(int next) {
        this.next = next;
    }

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
