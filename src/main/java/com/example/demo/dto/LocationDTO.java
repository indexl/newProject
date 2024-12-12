package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationDTO {
    private double startLat;    // 출발지 위도
    private double startLng;    // 출발지 경도
    private String destination; // 목적지 주소
}
