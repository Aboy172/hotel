package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Reservations;


/**
 * <p>
 * 预定表：存储用户的房间预定信息 服务类
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface ReservationsService extends IService<Reservations> {

    /**
     * 获取列表。分页
     * @param reservations 查询参数
     * @return page
     */
    Page<Reservations> listReservationsPage(Reservations reservations);

    Page<Reservations> getList(Reservations reservations);

}
