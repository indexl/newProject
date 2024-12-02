package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MapController {

    @GetMapping("/usr/home/index")
    public String index() {
        return "usr/home/index"; // `index.jsp`를 반환
    }
}
