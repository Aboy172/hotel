package com.kalvin.hotel.modules.hotels.enums;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.Getter;

public enum SettlementEnum {

    NOT(0,"已预定,未支付"),
    ADD(1,"已入住"),
    UPDATE(2,"已退房，完成订单"),
    END(3,"已评价");


    ;



    @Getter
    @EnumValue
    private final int code;
    @Getter
    @JsonValue
    private final String msg;

    SettlementEnum(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
