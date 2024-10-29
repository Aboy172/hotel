package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Rooms;
import com.kalvin.hotel.modules.hotels.service.RoomsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


/**
 * <p>
 * 客房表：存储各个房间的具体信息及其状态 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("rooms/rooms")
public class RoomsController extends BaseController {

    @Autowired
    private RoomsService roomsService;

    @RequiresPermissions("rooms:rooms:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("rooms/rooms");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long roomId) {
        ModelAndView mv = new ModelAndView("rooms/rooms_edit");
        Rooms rooms;
        if (roomId == null) {
            rooms = new Rooms();
        } else {
            rooms = roomsService.getById(roomId);
        }
        mv.addObject("editInfo", rooms);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Rooms rooms) {
        Page<Rooms> page = roomsService.listRoomsPage(rooms);
        return R.ok(page);
    }

    @RequiresPermissions("rooms:rooms:add")
    @PostMapping(value = "add")
    public R add(Rooms rooms) {
        roomsService.save(rooms);
        return R.ok();
    }

    @RequiresPermissions("rooms:rooms:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("roomIds") List<Long> roomIds) {
        roomsService.removeByIds(roomIds);
        return R.ok();
    }

    @RequiresPermissions("rooms:rooms:edit")
    @PostMapping(value = "edit")
    public R edit(Rooms rooms) {
        roomsService.updateById(rooms);
        return R.ok();
    }

    @RequiresPermissions("rooms:rooms:del")
    @PostMapping(value = "del/{roomId}")
    public R del(@PathVariable Long roomId) {
        roomsService.removeById(roomId);
        return R.ok();
    }

    @GetMapping(value = "get/{roomId}")
    public R get(@PathVariable Long roomId) {
        return R.ok(roomsService.getById(roomId));
    }

}

