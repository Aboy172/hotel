package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Ins;

/**
 * <p>
 * 入住管理表：记录用户的实际入住和退房信息 服务类
 * </p>
 * @since 2024-10-21 22:06:56
 */
public interface InsService extends IService<Ins> {

    /**
     * 获取列表。分页
     * @param ins 查询参数
     * @return page
     */
    Page<Ins> listInsPage(Ins ins);

}
