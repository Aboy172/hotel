package com.kalvin.hotel.modules.sys.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.modules.sys.dto.UserRoleGroupDTO;
import com.kalvin.hotel.modules.sys.entity.UserRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 用户与角色对应关系 Mapper 接口
 * </p>
 *
 * @author Kalvin
 * @since 2019-04-29
 */
public interface UserRoleMapper extends BaseMapper<UserRole> {

    List<UserRole> selectUserRoleList(@Param("userRole") UserRole userRole, Page page);

    UserRoleGroupDTO selectUserRoleGroupByUserId(@Param("userId") Long userId);

}
