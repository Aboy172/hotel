package com.kalvin.hotel.modules.sys.service;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.common.constant.SysConstant;
import com.kalvin.hotel.common.exception.HotelException;
import com.kalvin.hotel.common.utils.CryptionKit;
import com.kalvin.hotel.modules.sys.entity.User;
import com.kalvin.hotel.modules.sys.mapper.UserMapper;
import com.kalvin.hotel.modules.sys.vo.UserQueryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author Kalvin
 * @since 2019-04-29
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private IUserRoleService userRoleService;

    @Override
    public Page<User> listUserPage(UserQueryVO queryVO) {
        Page<User> page = new Page<>(queryVO.getCurrent(), queryVO.getSize());
        List<User> users = baseMapper.selectUserList(queryVO, page);
        return page.setRecords(users);
    }

    @Override
    public User getByUsername(String username) {
        return super.getOne(new LambdaQueryWrapper<User>().eq(User::getUsername, username));
    }

    @Override
    public void updateUserPassword(Long id, String password) {
        super.update(new LambdaUpdateWrapper<User>()
                .set(User::getPassword, password)
                .eq(User::getId, id));
    }

    @Override
    public List<User> search(String query) {
        /*if (StrUtil.isBlank(query)) {
            return new ArrayList<>();
        }*/
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.like(StrUtil.isNotBlank(query), User::getUsername, query)
                .or().like(StrUtil.isNotBlank(query), User::getRealname, query);
        return super.list(queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void addUser(User user, List<Long> roleIds) {
        if (this.checkUsernameRepeat(user.getUsername())) {
            throw new HotelException("用户名【" + user.getUsername() + "】已被使用！");
        }
        user.setDeptId(user.getDeptId() == null ? 0 : user.getDeptId());
        // 生成用户初始密码并加密
        user.setPassword(CryptionKit.genUserPwd());
        super.saveOrUpdate(user);
        userRoleService.saveOrUpdateBatchUserRole(roleIds, user.getId());
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateUser(User user, List<Long> roleIds) {
        User oldUser = super.getById(user.getId());
        if (!oldUser.getUsername().equals(user.getUsername())) {
            if (this.checkUsernameRepeat(user.getUsername())) {
                throw new HotelException("用户名【" + user.getUsername() + "】已被使用！");
            }
        }
        user.setDeptId(user.getDeptId() == null ? 0 : user.getDeptId());
        super.updateById(user);
        userRoleService.saveOrUpdateBatchUserRole(roleIds, user.getId());
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        User adminUser = super.getOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, SysConstant.ADMIN));
        if (ids.contains(adminUser.getId())) {
            throw new HotelException("不允许删除超级管理员【" + SysConstant.ADMIN + "】用户");
        }
        super.removeByIds(ids);
    }

    @Override
    public void reset(User user, String username) {


    }

    private boolean checkUsernameRepeat(String username) {
        User one = super.getOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, username).last("limit 1"));
        return one != null;
    }
}
