package com.devopsstore.product_service;

import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {


    private final ProductRepository repository;

    public ProductController(ProductRepository repository) {
        this.repository = repository;
    }

    @GetMapping 
    public List<Product> getAllProducts() {
        return repository.findAll();
    }

    @PostMapping 
    public Product createProduct(@RequestBody Product product) {
        return repository.save(product);
    }
}