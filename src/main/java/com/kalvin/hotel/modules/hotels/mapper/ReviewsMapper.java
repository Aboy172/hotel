package com.kalvin.hotel.modules.hotels.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import com.kalvin.hotel.modules.hotels.entity.Reviews;

import java.util.List;

/**
 * <p>
 * 评价表：存储用户对酒店的评价 Mapper 接口
 * </p>
 * @since 2024-10-21 22:11:26
 */
public interface ReviewsMapper extends BaseMapper<Reviews> {

    /**
     * 查询列表(分页)
     * @param reviews 查询参数
     * @param page 分页参数
     * @return list
     */
    List<Reviews> selectReviewsList(@Param("reviews") Reviews reviews, IPage page);

}
