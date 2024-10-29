package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Types;

/**
 * <p>
 * 房间类型表：定义每个酒店的不同房间类型 服务类
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface TypesService extends IService<Types> {

    /**
     * 获取列表。分页
     * @param types 查询参数
     * @return page
     */
    Page<Types> listTypesPage(Types types);

}
