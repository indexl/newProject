package com.example.demo.client;



import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.example.demo.dto.RouteDTO;

@Component
public class DaejeonBusApiClient {
    
	@Value("${api.daejeon.service-key}")
    private String serviceKey;
    
    @Value("${api.daejeon.bus.base-url}")
    private String baseUrl;
    
    private final RestTemplate restTemplate = new RestTemplate();

    @Cacheable("nearbyStops")
    public List<RouteDTO.BusStop> findNearbyStops(double latitude, double longitude, int radius) {
        String url = UriComponentsBuilder
            .fromHttpUrl(baseUrl)
            .path("/busStationService/getBusStationList")
            .queryParam("serviceKey", serviceKey)
            .queryParam("latitude", latitude)
            .queryParam("longitude", longitude)
            .queryParam("radius", radius)
            .build()
            .toUriString();

        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        List<RouteDTO.BusStop> stops = new ArrayList<>();
        
        if (response.getBody() != null && response.getBody().get("items") != null) {
            List<Map<String, Object>> items = (List<Map<String, Object>>) response.getBody().get("items");
            
            for (Map<String, Object> item : items) {
                RouteDTO.BusStop stop = new RouteDTO.BusStop();
                stop.setStopId(item.get("stationId").toString());
                stop.setStopName(item.get("stationName").toString());
                stop.setLatitude(Double.parseDouble(item.get("latitude").toString()));
                stop.setLongitude(Double.parseDouble(item.get("longitude").toString()));
                stops.add(stop);
            }
        }
        
        return stops;
    }

    @Cacheable("busRoutes")
    public List<String> findBusRoutes(String startStopId, String endStopId) {
        String url = UriComponentsBuilder
            .fromHttpUrl(baseUrl)
            .path("/busRouteService/getBusRouteList")
            .queryParam("serviceKey", serviceKey)
            .queryParam("startStationId", startStopId)
            .queryParam("endStationId", endStopId)
            .build()
            .toUriString();

        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        List<String> routes = new ArrayList<>();
        
        if (response.getBody() != null && response.getBody().get("items") != null) {
            List<Map<String, Object>> items = (List<Map<String, Object>>) response.getBody().get("items");
            
            for (Map<String, Object> item : items) {
                routes.add(item.get("routeNo").toString());
            }
        }
        
        return routes;
    }

    @Cacheable("busArrival")
    public String getBusArrivalTime(String stopId, String routeId) {
        String url = UriComponentsBuilder
            .fromHttpUrl(baseUrl)
            .path("/busArrivalService/getBusArrivalList")
            .queryParam("serviceKey", serviceKey)
            .queryParam("stationId", stopId)
            .queryParam("routeId", routeId)
            .build()
            .toUriString();

        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        
        if (response.getBody() != null && response.getBody().get("items") != null) {
            List<Map<String, Object>> items = (List<Map<String, Object>>) response.getBody().get("items");
            if (!items.isEmpty()) {
                return items.get(0).get("predictTime").toString();
            }
        }
        
        return "정보 없음";
    }
}