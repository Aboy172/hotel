package com.kalvin.hotel.modules.hotels.api;

import com.kalvin.hotel.common.dto.R;
import com.kalvin.hotel.modules.file.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author: cym
 * @create: 2025-03-18 22:28
 * @description:
 * @version: 0.0.1
 **/
@RestController
@RequestMapping("/file")
public class FileController {

    @Autowired
    private FileService fileService;
    /**
     * 文件上传接口
     * @param file
     * @return
     */
    @PostMapping("/upload")
    public R upload(@RequestPart("file") MultipartFile file){
        String imgFileStr = fileService.upload(file);
        return R.ok(imgFileStr);

    }
}
