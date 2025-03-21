package com.kalvin.hotel.modules.sys.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kalvin.hotel.modules.sys.entity.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 角色表 Mapper 接口
 * </p>
 *
 * @author Kalvin
 * @since 2019-04-29
 */
public interface RoleMapper extends BaseMapper<Role> {

    List<Role> selectRoleList(@Param("role") Role role, Page page);

}
