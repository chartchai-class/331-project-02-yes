package com.cqa.config;

import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.stp.StpUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @version 1.0.0
 * @ClassName SaTokenConfig.java
 * @Description Configure Sa-Token for login verification
 */
@Configuration
public class SaTokenConfig implements WebMvcConfigurer {

    // Register interceptors
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // Register Sa-Token interceptor to verify login status using StpUtil.checkLogin().
        registry.addInterceptor(new SaInterceptor(handle -> StpUtil.checkLogin()))
                .addPathPatterns("/comments/add");
    }
}
