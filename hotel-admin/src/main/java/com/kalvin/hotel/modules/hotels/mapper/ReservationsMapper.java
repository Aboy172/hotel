package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.modules.hotels.entity.Reservations;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 预定表：存储用户的房间预定信息 Mapper 接口
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface ReservationsMapper extends BaseMapper<Reservations> {

    /**
     * 查询列表(分页)
     * @param reservations 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Reservations> selectReservationsList(@Param("reservations") Reservations reservations, IPage page);

    List<Reservations> selectOrderList(@Param("userId") Long userId, Page<Reservations> page);
}
