package com.kalvin.hotel.modules.sys.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.sys.entity.User;
import com.kalvin.hotel.modules.sys.vo.UserQueryVO;

import java.util.List;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author Kalvin
 * @since 2019-04-29
 */
public interface UserService extends IService<User> {

    /**
     * 获取用户列表。分页
     * @param queryVO 查询参数
     * @return
     */
    Page<User> listUserPage(UserQueryVO queryVO);

    User getByUsername(String username);

    void updateUserPassword(Long id, String password);

    /**
     * 根据查询参数模糊搜索username和realname值可能为query的所有用户
     * @param query 查询参数
     * @return list
     */
    List<User> search(String query);

    void addUser(User user, List<Long> roleIds);

    void updateUser(User user, List<Long> roleIds);

    void deleteByIds(List<Long> ids);


    void reset(User user, String s);

}
