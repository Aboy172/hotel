package com.kalvin.hotel.modules.hotels.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.hotels.entity.Notifications;
import com.kalvin.hotel.modules.hotels.service.NotificationsService;

import java.util.List;


/**
 * <p>
 * 酒店通知表：存储酒店发布的通知信息 前端控制器
 * </p>
 * @since 2024-10-21 22:11:26
 */
@RestController
@RequestMapping("hotel_notifications/notifications")
public class NotificationsController extends BaseController {

    @Autowired
    private NotificationsService notificationsService;

    @RequiresPermissions("hotel_notifications:notifications:index")
    @GetMapping("index")
    public ModelAndView index() {
        return new ModelAndView("hotel_notifications/notifications");
    }

    @GetMapping(value = "edit")
    public ModelAndView edit(Long notificationId) {
        ModelAndView mv = new ModelAndView("hotel_notifications/notifications_edit");
        Notifications notifications;
        if (notificationId == null) {
            notifications = new Notifications();
        } else {
            notifications = notificationsService.getById(notificationId);
        }
        mv.addObject("editInfo", notifications);
        return mv;
    }

    @GetMapping(value = "list/data")
    public R listData(Notifications notifications) {
        Page<Notifications> page = notificationsService.listNotificationsPage(notifications);
        return R.ok(page);
    }

    @RequiresPermissions("hotel_notifications:notifications:add")
    @PostMapping(value = "add")
    public R add(Notifications notifications) {
        notificationsService.save(notifications);
        return R.ok();
    }

    @RequiresPermissions("hotel_notifications:notifications:del")
    @PostMapping(value = "batchdel")
    public R batchdel(@RequestParam("notificationIds") List<Long> notificationIds) {
        notificationsService.removeByIds(notificationIds);
        return R.ok();
    }

    @RequiresPermissions("hotel_notifications:notifications:edit")
    @PostMapping(value = "edit")
    public R edit(Notifications notifications) {
        notificationsService.updateById(notifications);
        return R.ok();
    }

    @RequiresPermissions("hotel_notifications:notifications:del")
    @PostMapping(value = "del/{notificationId}")
    public R del(@PathVariable Long notificationId) {
        notificationsService.removeById(notificationId);
        return R.ok();
    }

    @GetMapping(value = "get/{notificationId}")
    public R get(@PathVariable Long notificationId) {
        return R.ok(notificationsService.getById(notificationId));
    }

}

