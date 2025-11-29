package com.example.sca_be.global.config

import org.springframework.context.annotation.Configuration
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.http.converter.StringHttpMessageConverter
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer

import java.nio.charset.StandardCharsets

@Configuration
class WebConfig implements WebMvcConfigurer {
    
    @Override
    void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        // StringHttpMessageConverter에 UTF-8 인코딩 명시
        converters.add(new StringHttpMessageConverter(StandardCharsets.UTF_8))
    }
}

