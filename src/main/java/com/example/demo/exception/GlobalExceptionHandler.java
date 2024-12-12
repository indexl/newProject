package com.example.demo.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.example.demo.dto.ApiResponse;
import com.example.demo.exception.CustomExceptions.ApiException;
import com.example.demo.exception.CustomExceptions.LocationNotFoundException;
import com.example.demo.exception.CustomExceptions.RouteNotFoundException;

@RestControllerAdvice
public class GlobalExceptionHandler {
    
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    
    @ExceptionHandler(ApiException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ApiResponse<Void> handleApiException(ApiException e) {
        logger.error("API 오류 발생: ", e);
        return ApiResponse.error("API 호출 중 오류가 발생했습니다: " + e.getMessage());
    }
    
    @ExceptionHandler(LocationNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiResponse<Void> handleLocationNotFoundException(LocationNotFoundException e) {
        logger.error("위치 검색 실패: ", e);
        return ApiResponse.error(e.getMessage());
    }
    
    @ExceptionHandler(RouteNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ApiResponse<Void> handleRouteNotFoundException(RouteNotFoundException e) {
        logger.error("경로 검색 실패: ", e);
        return ApiResponse.error(e.getMessage());
    }
    
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ApiResponse<Void> handleGlobalException(Exception e) {
        logger.error("예상치 못한 오류 발생: ", e);
        return ApiResponse.error("서버 내부 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
    }
}