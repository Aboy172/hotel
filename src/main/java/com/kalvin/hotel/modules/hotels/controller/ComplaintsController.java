package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Complaints;
import com.kalvin.hotel.modules.hotels.service.ComplaintsService;

import java.util.List;


/**
 * <p>
 * 投诉表：存储用户的投诉信息 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("complaints/complaints")
public class ComplaintsController extends BaseController {

    @Autowired
    private ComplaintsService complaintsService;

    @RequiresPermissions("complaints:complaints:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("complaints/complaints");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long complaintId) {
        ModelAndView mv = new ModelAndView("complaints/complaints_edit");
        Complaints complaints;
        if (complaintId == null) {
            complaints = new Complaints();
        } else {
            complaints = complaintsService.getById(complaintId);
        }
        mv.addObject("editInfo", complaints);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Complaints complaints) {
        Page<Complaints> page = complaintsService.listComplaintsPage(complaints);
        return R.ok(page);
    }

    @RequiresPermissions("complaints:complaints:add")
    @PostMapping(value = "add")
    public R add(Complaints complaints) {
        complaintsService.save(complaints);
        return R.ok();
    }

    @RequiresPermissions("complaints:complaints:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("ids") List<Long> complaintIds) {
        complaintsService.removeByIds(complaintIds);
        return R.ok();
    }

    @RequiresPermissions("complaints:complaints:edit")
    @PostMapping(value = "edit")
    public R edit(Complaints complaints) {
        complaintsService.updateById(complaints);
        return R.ok();
    }

    @RequiresPermissions("complaints:complaints:del")
    @PostMapping(value = "del/{complaintId}")
    public R del(@PathVariable Long complaintId) {
        complaintsService.removeById(complaintId);
        return R.ok();
    }

    @GetMapping(value = "get/{complaintId}")
    public R get(@PathVariable Long complaintId) {
        return R.ok(complaintsService.getById(complaintId));
    }

}

