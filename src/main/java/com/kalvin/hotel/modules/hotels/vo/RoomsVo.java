package com.kalvin.hotel.modules.hotels.vo;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @author: cym
 * @create: 2025-03-23 01:21
 * @description:
 * @version: 0.0.1
 **/
@Data
public class RoomsVo {
    /**
     * 客房ID
     */
    private Long roomId;

    /**
     * 房间号码
     */
    private String roomNumber;

    /**
     * 酒店ID
     */
    private Long hotelId;
    /**
     * 客房照片
     */
    private String cover;
    //客房类型名称
    private String typeName;

    //价格
    private BigDecimal price = BigDecimal.ZERO;

    //描述
    private String description;



    /**
     * 房间状态 0 未入住：1已入住
     */
    private Integer status;


    /**
     * 酒店名称
     */
    private String hotelName;

    //平均评分
    private BigDecimal rating = BigDecimal.ZERO;

    //位置
    private String location;





}
