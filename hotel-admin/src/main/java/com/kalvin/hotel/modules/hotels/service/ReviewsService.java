package com.kalvin.hotel.modules.hotels.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.kalvin.hotel.modules.hotels.entity.Reviews;

/**
 * <p>
 * 评价表：存储用户对酒店的评价 服务类
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface ReviewsService extends IService<Reviews> {

    /**
     * 获取列表。分页
     * @param reviews 查询参数
     * @return page
     */
    Page<Reviews> listReviewsPage(Reviews reviews);

}
