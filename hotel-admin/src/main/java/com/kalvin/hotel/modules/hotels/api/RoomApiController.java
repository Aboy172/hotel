package com.kalvin.hotel.modules.hotels.api;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Rooms;
import com.kalvin.hotel.modules.hotels.service.RoomsService;
import com.kalvin.hotel.modules.hotels.vo.RoomsVo;
import org.springframework.web.bind.annotation.*;

/**
 * @author: cym
 * @create: 2024-10-27 22:48
 * @description:
 * @version: 0.0.1
 **/
@RestController
@RequestMapping("/user/room")
public class RoomApiController extends BaseController {

    private final RoomsService roomsService;

    public RoomApiController(RoomsService roomsService) {
        this.roomsService = roomsService;
    }

    @GetMapping("/getRoomDetails/{roomId}")
    public R getRoomDetails(@PathVariable("roomId") Integer roomId) {
        RoomsVo rooms = roomsService.getRoomDetails(roomId);
        return R.ok(rooms);
    }

    @GetMapping("/query")
    public R query(Rooms rooms) {

        Page<Rooms> roomsPage = roomsService.query(rooms);
        return R.ok(roomsPage);
    }

}






