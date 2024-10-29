package com.kalvin.hotel.modules.hotels.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.kalvin.hotel.common.entity.BaseEntity;
import java.math.BigDecimal;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

/**
 * <p>
 * 结算表：记录退房时的结算信息
 * </p>
 * @since 2024-10-21 22:06:57
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("check_out_settlements")
public class OutSettlements extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 结算ID
     */
    @TableId(value = "settlement_id", type = IdType.AUTO)
    private Long settlementId;

    /**
     * 预定ID
     */
    private Long reservationId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 总金额
     */
    private BigDecimal totalAmount;

    /**
     * 是否支付完成
     */
    private Integer paid;

    /**
     * 结算时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

}
