package com.suvin.nepia.domain.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author PARK SU BIN
 * @version 1.0
 */
@Controller
public class UserController {

    /**
     * 로그인 페이지를 호출한다.
     */
    @GetMapping("/")
    public String index() {
        return "pages/index";
    }

    /**
     * 회원가입 페이지를 호출한다.
     */
    @GetMapping("/sign-up")
    public String signUp() {
        return "pages/sign-up";
    }
}