package com.kalvin.hotel.modules.hotels.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * @author: cym
 * @create: 2024-10-27 18:49
 * @description:
 * @version: 0.0.1
 **/
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class CheckOutVo  implements Serializable {

    private Long reservationId;

    private Long roomId;
    private String hotelName;

    private String typeName;

    private BigDecimal totalPrice;

    @DateTimeFormat(pattern = "yyyy-MM-dd") // 指定日期格式
    private LocalDate  checkInDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd") // 指定日期格式
    private LocalDate checkOutDate;


}
