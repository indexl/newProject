package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UsrMapController {
	
	 @GetMapping("/usr/api/map")
	    public String showMap() {
	        return "usr/api/map";
	 }
	 
	 @GetMapping("/usr/api/map2")
	    public String showMap2() {
	        return "usr/api/map2";
	 }
	 @GetMapping("/usr/api/map3")
	    public String showMap3() {
	        return "usr/api/map3";
	 }
	 
	 @GetMapping("/usr/api/map4")
	    public String showMap4() {
	        return "usr/api/map4";
	 }
	 
	 @GetMapping("/usr/api/map5")
	    public String showMap5() {
	        return "usr/api/map5";
	 } 
}
