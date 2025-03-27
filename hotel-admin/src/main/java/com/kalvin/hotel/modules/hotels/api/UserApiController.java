package com.kalvin.hotel.modules.hotels.api;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kalvin.hotel.common.controller.BaseController;
import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.common.utils.CryptionKit;
import com.kalvin.hotel.common.utils.ShiroKit;
import com.kalvin.hotel.modules.sys.entity.User;
import com.kalvin.hotel.modules.sys.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author: cym
 * @create: 2024-10-27 01:43
 * @description:
 * @version: 0.0.1
 **/
@RestController
@RequestMapping("/user/info")
public class UserApiController extends BaseController {

    private final UserService userService;

    public UserApiController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping()
    public R info() {
        User user = userService.getById(ShiroKit.getUserId());
        return R.ok(user);

    }

    @GetMapping("/logout")
    public R logout() {
        String username = ShiroKit.getUser().getUsername();
        ShiroKit.logout();
        LOGGER.info("{}退出登录", username);
        return R.ok();
    }

    @PostMapping("rest")
    public R rest(User user) {
        if (StrUtil.isBlank(user.getPassword()) && StrUtil.isBlank(user.getPassword())) {
            return R.fail("修改失败，非法的参数");
        }
        String oldPassword = CryptionKit.genUserPwd(user.getPassword());
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();

        wrapper.eq(User::getUsername, user.getUsername())
                .eq(User::getPassword, oldPassword);
        User userIs = userService.getOne(wrapper);

        if (ObjectUtil.isNull(userIs)) {
            return R.fail("旧密码不正确");
        }

        // 用户修改密码
        String password = CryptionKit.genUserPwd(user.getConfirmPassword());
        if (userIs.getPassword().equals(password)) {
            return R.fail("新密码不能与旧密码相同");
        }
        userService.updateUserPassword(userIs.getId(), password);

        return R.ok();

    }


}
