package com.kalvin.hotel.modules.hotels.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.kalvin.hotel.modules.hotels.service.ReviewsService;
import org.springframework.stereotype.Service;
import com.kalvin.hotel.modules.hotels.entity.Reviews;
import com.kalvin.hotel.modules.hotels.mapper.ReviewsMapper;

import java.util.List;

/**
 * <p>
 * 评价表：存储用户对酒店的评价 服务实现类
 * </p>
 * @since 2024-10-21 22:11:26
 */
@Service
public class ReviewsServiceImpl extends ServiceImpl<ReviewsMapper, Reviews> implements ReviewsService {

    @Override
    public Page<Reviews> listReviewsPage(Reviews reviews) {
        Page<Reviews> page = new Page<>(reviews.getCurrent(), reviews.getSize());
        List<Reviews> reviewss = baseMapper.selectReviewsList(reviews, page);
        return page.setRecords(reviewss);
    }

}
