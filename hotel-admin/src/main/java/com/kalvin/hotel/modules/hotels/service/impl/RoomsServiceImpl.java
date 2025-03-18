package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.modules.hotels.entity.Rooms;
import com.kalvin.hotel.modules.hotels.mapper.RoomsMapper;
import com.kalvin.hotel.modules.hotels.service.RoomsService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 客房表：存储各个房间的具体信息及其状态 服务实现类
 * </p>
 *
 * @since 2024-10-21 22:11:26
 */
@Service
public class RoomsServiceImpl extends ServiceImpl<RoomsMapper, Rooms> implements RoomsService {

    @Override
    public Page<Rooms> listRoomsPage(Rooms rooms) {
        Page<Rooms> page = new Page<>(rooms.getCurrent(), rooms.getSize());
        List<Rooms> roomss = baseMapper.selectRoomsList(rooms, page);
        return page.setRecords(roomss);
    }

    @Override
    public Rooms getRoomDetails(Integer roomId) {
        return baseMapper.getRoomDetails(roomId);


    }

    @Override
    public Page<Rooms> query(Rooms rooms) {
        Page<Rooms> page = new Page<>(rooms.getCurrent(), rooms.getSize());
        List<Rooms> roomList = baseMapper.selectRoomsList(rooms, page);
        return page.setRecords(roomList);
    }

}
