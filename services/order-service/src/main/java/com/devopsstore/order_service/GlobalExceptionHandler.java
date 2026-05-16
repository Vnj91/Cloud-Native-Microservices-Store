package com.devopsstore.order_service;

import feign.FeignException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // Handles cases where User or Product service returns 404
    @ExceptionHandler(FeignException.NotFound.class)
    public ResponseEntity<Object> handleNotFound(FeignException e) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(Map.of("error", "Validation failed: One or more requested resources do not exist."));
    }

    // Handles cases where a service is down (503)
    @ExceptionHandler(feign.RetryableException.class)
    public ResponseEntity<Object> handleServiceDown(Exception e) {
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                .body(Map.of("error", "An internal service is currently unreachable. Please try again later."));
    }
}