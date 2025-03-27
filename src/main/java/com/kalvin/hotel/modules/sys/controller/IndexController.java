package com.kalvin.hotel.modules.sys.controller;

import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.common.utils.ShiroKit;
import com.kalvin.hotel.modules.sys.entity.User;
import com.kalvin.hotel.modules.sys.service.IMenuService;
import com.kalvin.hotel.modules.sys.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class IndexController extends BaseController {

    @Autowired
    private IMenuService menuService;

    @Autowired
    private UserService userService;

    @GetMapping(value = "/")
    public ModelAndView index() {
        User user = userService.getById(ShiroKit.getUserId());
        return new ModelAndView("index").addObject("authUserInfo", user);
    }

    @GetMapping(value = "home")
    public ModelAndView home() {
        return new ModelAndView("home");
    }

    @GetMapping(value = "test")
    public ModelAndView test() {
        return new ModelAndView("test");
    }


    @GetMapping(value = "index/menus")
    public R menus() {
        return R.ok(menuService.listUserPermissionMenuWithSubByUserId(ShiroKit.getUserId()));
    }

    @GetMapping(value = "index/navMenus")
    public R navMenus() {
        return R.ok(menuService.listUserPermissionNavMenuByUserId(ShiroKit.getUserId()));
    }

}
