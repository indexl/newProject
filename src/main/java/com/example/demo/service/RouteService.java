package com.example.demo.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.example.demo.client.DaejeonBusApiClient;
import com.example.demo.dto.RouteDTO;
import com.example.demo.exception.CustomExceptions.RouteNotFoundException;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RouteService {
    
    private final DaejeonBusApiClient busApiClient;
    private static final int SEARCH_RADIUS = 500; // 반경 500m 내 정류장 검색
    
    public RouteDTO findOptimalRoute(double startLat, double startLng, String destination) {
        // 1. 출발지 주변 정류장 찾기
        List<RouteDTO.BusStop> startStops = busApiClient.findNearbyStops(startLat, startLng, SEARCH_RADIUS);
        if (startStops.isEmpty()) {
            throw new RouteNotFoundException("출발지 주변에서 버스 정류장을 찾을 수 없습니다.");
        }
        
        // 2. 목적지 주변 정류장 찾기
        List<RouteDTO.BusStop> endStops = busApiClient.findNearbyStops(
            Double.parseDouble(destination.split(",")[0]),
            Double.parseDouble(destination.split(",")[1]),
            SEARCH_RADIUS
        );
        if (endStops.isEmpty()) {
            throw new RouteNotFoundException("목적지 주변에서 버스 정류장을 찾을 수 없습니다.");
        }
        
        // 3. 가능한 모든 경로 찾기
        List<RouteDTO.Route> possibleRoutes = new ArrayList<>();
        
        for (RouteDTO.BusStop startStop : startStops) {
            for (RouteDTO.BusStop endStop : endStops) {
                List<String> busRoutes = busApiClient.findBusRoutes(startStop.getStopId(), endStop.getStopId());
                
                for (String busNumber : busRoutes) {
                    RouteDTO.Route route = new RouteDTO.Route();
                    route.setBusNumber(busNumber);
                    route.setStartStop(startStop.getStopName());
                    route.setStartStopId(startStop.getStopId());
                    route.setEndStop(endStop.getStopName());
                    route.setEndStopId(endStop.getStopId());
                    
                    // 버스 도착 시간 조회
                    String arrivalTime = busApiClient.getBusArrivalTime(startStop.getStopId(), busNumber);
                    if (!arrivalTime.equals("정보 없음")) {
                        route.setDuration(Integer.parseInt(arrivalTime));
                    }
                    
                    possibleRoutes.add(route);
                }
            }
        }
        
        if (possibleRoutes.isEmpty()) {
            throw new RouteNotFoundException("가능한 버스 경로를 찾을 수 없습니다.");
        }
        
        // 4. 경로 정렬 (소요 시간 기준)
        possibleRoutes.sort(Comparator.comparing(RouteDTO.Route::getDuration));
        
        // 5. 상위 3개 경로만 반환
        List<RouteDTO.Route> optimalRoutes = possibleRoutes.stream()
            .limit(3)
            .collect(Collectors.toList());
            
        return new RouteDTO(optimalRoutes, "경로 검색 성공", "success");
    }
}