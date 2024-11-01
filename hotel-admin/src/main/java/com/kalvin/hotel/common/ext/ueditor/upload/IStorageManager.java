package com.kalvin.hotel.common.ext.ueditor.upload;

import com.kalvin.hotel.common.ext.ueditor.define.State;

import java.io.InputStream;


public interface IStorageManager {

    State saveBinaryFile(byte[] data, String rootPath, String savePath);

    State saveFileByInputStream(InputStream is, String rootPath, String savePath);

    State saveFileByInputStream(InputStream is, String rootPath, String savePath, long maxSize);
}
