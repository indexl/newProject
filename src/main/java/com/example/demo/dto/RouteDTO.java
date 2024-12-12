package com.example.demo.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RouteDTO {
    private List<Route> routes;
    private String message;
    private String status;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Route {
        private String busNumber;        // 버스 번호
        private String startStop;        // 승차 정류장
        private String startStopId;      // 승차 정류장 ID
        private String endStop;          // 하차 정류장
        private String endStopId;        // 하차 정류장 ID
        private int duration;            // 예상 소요 시간(분)
        private int distance;            // 총 거리(미터)
        private String firstBusTime;     // 첫차 시간
        private String lastBusTime;      // 막차 시간
        private int fare;                // 요금
        private List<BusStop> stops;     // 경유 정류장 목록
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class BusStop {
        private String stopId;           // 정류장 ID
        private String stopName;         // 정류장 이름
        private double latitude;         // 위도
        private double longitude;        // 경도
        private String arrivalTime;      // 도착 예정 시간
        private List<String> busNumbers; // 정차 버스 번호 목록
    }
}