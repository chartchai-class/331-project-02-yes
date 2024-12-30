package com.cqa.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间格式转换工具类
 *
 */
public class DateUtils {

    public static final String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

    /**
     * 将当前时间格式化为字符串格式
     *
     * @return
     */
    public static String nowDateString() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATE_FORMAT);
        Date now = new Date();
        return simpleDateFormat.format(now);
    }

    /**
     * 将当前时间格式化为字符串格式
     *
     * @return
     */
    public static String nowDateString(String pattern) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        Date now = new Date();
        return simpleDateFormat.format(now);
    }

    /**
     * 传入date类型进行格式化输出（返回类型：String）
     *
     * @param date
     * @return
     */
    public static String dateFormat(Date date) {
        SimpleDateFormat formatter = new SimpleDateFormat(DATE_FORMAT);
        return formatter.format(date);
    }

    /**
     * 将指定格式字符串转化为Date
     *
     * @param str
     * @return
     * @throws ParseException
     */
    public static Date stringToDate(String str, String pattern) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
        return (Date) formatter.parse(str);
    }

    /**
     * 将字符串转化为Date
     *
     * @param str
     * @return
     * @throws ParseException
     */
    public static Date stringToDate(String str) throws ParseException {
        SimpleDateFormat formatter = new SimpleDateFormat(DATE_FORMAT);
        return (Date) formatter.parse(str);
    }
}