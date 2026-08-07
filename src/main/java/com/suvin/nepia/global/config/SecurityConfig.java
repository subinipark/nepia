package com.suvin.nepia.global.config;

import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * @author PARK SU BIN
 * @version 1.0
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private static final String[] PERMIT_ALL_URLS = {
            "/",
            "/sign-up",
            "/find-password",
            "/api/v1/auth/**",
            "/api/v1/users/**",
            "/h2-console/**"
    };

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public WebSecurityCustomizer customizer() {
        return (web) -> web.ignoring()
                .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                .requestMatchers("/fonts/**");
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // HTTP 기본 인증 비활성화
        http.httpBasic(AbstractHttpConfigurer::disable);
        // 폼 로그인 비활성화
        http.formLogin(AbstractHttpConfigurer::disable);
        // CSRF 공격 방어 임시 비활성화
        http.csrf(AbstractHttpConfigurer::disable);

        /* H2 콘솔 화면 깨짐 방지를 위한 x-frame-options 헤더 설정 : 동일 도메인 접근 허용  */
        http.headers(header -> header
                .frameOptions(HeadersConfigurer.FrameOptionsConfig::sameOrigin));
        /* 세션 관리 정책 */
        http.sessionManagement(session -> session
                .maximumSessions(1) // 최대 허용 가능 세션 수
                .maxSessionsPreventsLogin(false)    // 동시 로그인 차단 - 기존 세션 만료
                .expiredUrl("/"));  // 세션 만료시 이동할 페이지
        /* HTTP 요청 인가 정책 */
        http.authorizeHttpRequests(auth -> auth
                .requestMatchers(PERMIT_ALL_URLS).permitAll()
                .anyRequest().authenticated());

        return http.build();
    }
}