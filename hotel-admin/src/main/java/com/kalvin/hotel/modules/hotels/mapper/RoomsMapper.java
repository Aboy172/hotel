package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.kalvin.hotel.modules.hotels.entity.Rooms;
import com.kalvin.hotel.modules.hotels.vo.RoomsVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 客房表：存储各个房间的具体信息及其状态 Mapper 接口
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface RoomsMapper extends BaseMapper<Rooms> {

    /**
     * 查询列表(分页)
     * @param rooms 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Rooms> selectRoomsList(@Param("rooms") Rooms rooms, IPage page);

    RoomsVo getRoomDetails(@Param("roomId") Integer roomId);
}
