package com.cqa.util;

import cn.dev33.satoken.stp.StpUtil;

public class TokenUtils {
    public static final String ADMIN_NAME = "管理员";
    public static final String TEACHER_NAME = "教师";
    public static final String STUDENT_NAME = "学生";
    public static boolean isLogin() {
        return StpUtil.isLogin();
    }
    public static boolean isAdmin() {
        String userType = StpUtil.getSession().get("userType").toString();
        return ADMIN_NAME.equals(userType);
    }

    public static Integer getCurrentUserId () {
        return Integer.valueOf(StpUtil.getSession().get("loginUserId").toString());
    }

    public static String getCurrentUserType () {
        return StpUtil.getSession().get("userType").toString();
    }
    public static boolean isTeacher() {
        String userType = StpUtil.getSession().get("userType").toString();
        return TEACHER_NAME.equals(userType);
    }
    public static boolean isStudent() {
        String userType = StpUtil.getSession().get("userType").toString();
        return STUDENT_NAME.equals(userType);
    }
}
