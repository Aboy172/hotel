package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Hotels;

import java.util.List;

/**
 * <p>
 * 酒店表：存储酒店的基本信息 服务类
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface HotelsService extends IService<Hotels> {

    /**
     * 获取列表。分页
     * @param hotels 查询参数
     * @return page
     */
    Page<Hotels> listHotelsPage(Hotels hotels);

    List<Hotels> findAdvantageList();
}
