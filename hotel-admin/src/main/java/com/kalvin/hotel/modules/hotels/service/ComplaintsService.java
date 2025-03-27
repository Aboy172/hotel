package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Complaints;

/**
 * <p>
 * 投诉表：存储用户的投诉信息 服务类
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface ComplaintsService extends IService<Complaints> {

    /**
     * 获取列表。分页
     * @param complaints 查询参数
     * @return page
     */
    Page<Complaints> listComplaintsPage(Complaints complaints);

}
