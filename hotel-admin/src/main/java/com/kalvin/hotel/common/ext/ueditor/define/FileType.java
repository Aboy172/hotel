package com.kalvin.hotel.common.ext.ueditor.define;

import java.util.HashMap;
import java.util.Map;

public class FileType {

    public static final String JPG = "JPG";

    private static final Map<String, String> types = new HashMap<String, String>();

    static {

        types.put(FileType.JPG, ".jpg");

    }

    public static String getSuffix ( String key ) {
        return FileType.types.get( key );
    }

    /**
     * 根据给定的文件名,获取其后缀信息
     * @param filename
     * @return
     */
    public static String getSuffixByFilename ( String filename ) {

        return filename.substring( filename.lastIndexOf( "." ) ).toLowerCase();

    }

}
