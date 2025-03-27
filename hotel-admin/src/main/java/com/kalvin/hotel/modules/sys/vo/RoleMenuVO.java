package com.kalvin.hotel.modules.sys.vo;

import com.kalvin.hotel.modules.sys.entity.Role;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * 角色带菜单
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
public class RoleMenuVO extends Role {
    private Long[] menuIds;
}
