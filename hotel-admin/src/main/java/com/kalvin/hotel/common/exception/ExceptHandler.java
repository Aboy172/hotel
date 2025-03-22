package com.kalvin.hotel.common.exception;

import com.kalvin.hotel.common.constant.Constants;
import com.kalvin.hotel.common.dto.R;
import org.apache.shiro.authz.UnauthorizedException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 统一异常处理类
 */
@RestControllerAdvice
public class ExceptHandler {

    private final static Logger LOGGER = LoggerFactory.getLogger(ExceptHandler.class);

    @ExceptionHandler(HotelException.class)
    public R handlehotelException(HotelException e) {
        LOGGER.error("hotel-admin error:", e);
        if (e.getErrorCode() == null) {
            return R.fail(e.getMsg());
        }
        return R.fail(e.getErrorCode(), e.getMsg());
    }

    @ExceptionHandler(UnauthorizedException.class)
    public R handleUnauthorizedExceptionException(UnauthorizedException e) {
        LOGGER.error("hotel-admin error:{}", e.getMessage());
        return R.fail(Constants.OTHER_FAIL_CODE, "权限不足，请联系管理员。");
    }

    //@ExceptionHandler(Exception.class)
    //public R handleException(Exception e) {
    //    LOGGER.error("hotel-admin error:", e);
    //    return R.fail(Constants.OTHER_FAIL_CODE, e.getMessage());
    //}
    
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public R handleHttpMessageNotReadableException(HttpMessageNotReadableException e) {
                
        LOGGER.error("hotel-admin error:{}", e);
        return R.fail(Constants.OTHER_FAIL_CODE, "请求参数解析失败，请检查参数是否正确。");
    }
}
