package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.dto.LocationDTO;
import com.example.demo.dto.RouteDTO;
import com.example.demo.service.RouteService;

@Controller
public class RouteController {
    
    @Autowired
    private RouteService routeService;
    
    @GetMapping("/usr/api/map4")
    public String home() {
        return "usr/api/map4";
    }
    
    @PostMapping("/api/route/search")
    @ResponseBody
    public ResponseEntity<?> searchRoute(@RequestBody LocationDTO location) {
        try {
            RouteDTO route = routeService.findOptimalRoute(
                location.getStartLat(), 
                location.getStartLng(), 
                location.getDestination()
            );
            return ResponseEntity.ok(route);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("경로 검색 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
}