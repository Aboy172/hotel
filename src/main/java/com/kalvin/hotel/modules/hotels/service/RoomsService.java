package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Reservations;
import com.kalvin.hotel.modules.hotels.entity.Rooms;
import com.kalvin.hotel.modules.hotels.vo.RoomsVo;

/**
 * <p>
 * 客房表：存储各个房间的具体信息及其状态 服务类
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface RoomsService extends IService<Rooms> {

    /**
     * 获取列表。分页
     * @param rooms 查询参数
     * @return page
     */
    Page<Rooms> listRoomsPage(Rooms rooms);


    RoomsVo getRoomDetails(Integer roomId);

    Page<Rooms> query(Rooms rooms);

    void reservation (Reservations reservations);
}
