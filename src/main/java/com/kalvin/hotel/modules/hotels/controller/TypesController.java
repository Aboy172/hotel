package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Types;
import com.kalvin.hotel.modules.hotels.service.TypesService;

import java.util.List;


/**
 * <p>
 * 房间类型表：定义每个酒店的不同房间类型 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("room_types/types")
public class TypesController extends BaseController {

    @Autowired
    private TypesService typesService;

    @RequiresPermissions("room_types:types:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("room_types/types");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long roomTypeId) {
        ModelAndView mv = new ModelAndView("room_types/types_edit");
        Types types;
        if (roomTypeId == null) {
            types = new Types();
        } else {
            types = typesService.getById(roomTypeId);
        }
        mv.addObject("editInfo", types);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Types types) {
        Page<Types> page = typesService.listTypesPage(types);
        return R.ok(page);
    }

    @RequiresPermissions("room_types:types:add")
    @PostMapping(value = "add")
    public R add(Types types) {
        typesService.save(types);
        return R.ok();
    }

    @RequiresPermissions("room_types:types:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("roomTypeIds") List<Long> roomTypeIds) {
        typesService.removeByIds(roomTypeIds);
        return R.ok();
    }

    @RequiresPermissions("room_types:types:edit")
    @PostMapping(value = "edit")
    public R edit(Types types) {
        typesService.updateById(types);
        return R.ok();
    }

    @RequiresPermissions("room_types:types:del")
    @PostMapping(value = "del/{roomTypeId}")
    public R del(@PathVariable Long roomTypeId) {
        typesService.removeById(roomTypeId);
        return R.ok();
    }

    @GetMapping(value = "get/{roomTypeId}")
    public R get(@PathVariable Long roomTypeId) {
        return R.ok(typesService.getById(roomTypeId));
    }

}

