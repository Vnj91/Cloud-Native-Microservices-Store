package com.devopsstore.order_service;

import com.devopsstore.order_service.client.ProductClient;
import com.devopsstore.order_service.client.UserClient;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import java.util.List;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderRepository orderRepository;
    private final ProductClient productClient;
    private final UserClient userClient;

    public OrderController(OrderRepository orderRepository, ProductClient productClient, UserClient userClient) {
        this.orderRepository = orderRepository;
        this.productClient = productClient;
        this.userClient = userClient;
    }

    @GetMapping
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Order createOrder(@Valid @RequestBody Order order) {
        try {
            // Inter-service communication via Feign!
            productClient.getProductById(order.getProductId());
            userClient.getUserById(order.getUserId());
            
            return orderRepository.save(order);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ResponseStatusException(
                HttpStatus.BAD_REQUEST, "Invalid Product ID or User ID provided", e);
        }
    }
}