package com.kalvin.kvf.modules.hotels.api;

import com.kalvin.kvf.common.controller.BaseController;
import com.kalvin.kvf.common.dto.R;
import com.kalvin.kvf.common.utils.ShiroKit;
import com.kalvin.kvf.modules.hotels.entity.Complaints;
import com.kalvin.kvf.modules.hotels.entity.Hotels;
import com.kalvin.kvf.modules.hotels.service.ComplaintsService;
import com.kalvin.kvf.modules.hotels.service.HotelsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author: cym
 * @create: 2024-10-27 21:45
 * @description:
 * @version: 0.0.1
 **/

@RestController
@RequestMapping("/user/hotels")
public class HotelApiController extends BaseController {

    private final HotelsService hotelsService;

    private  final ComplaintsService complaintsService;

    public HotelApiController(HotelsService hotelsService, ComplaintsService complaintsService) {
        this.hotelsService = hotelsService;
        this.complaintsService = complaintsService;
    }

    @GetMapping("/findAdvantageList")
    public R findAdvantageList() {
        List<Hotels> advantageList = hotelsService.findAdvantageList();
        return R.ok(advantageList);

    }

    @PostMapping("/complaint")
    public  R complaint(Complaints complaint){
        Long userId = ShiroKit.getUserId();
        complaint.setUserId(userId);
        complaint.setStatus(1);
        complaintsService.save(complaint);
        return  R.ok();
    }


}
