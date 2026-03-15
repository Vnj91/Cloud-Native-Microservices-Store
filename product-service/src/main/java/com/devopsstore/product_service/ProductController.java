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

    @GetMapping // This handles GET /api/products
    public List<Product> getAllProducts() {
        return repository.findAll();
    }

    @PostMapping // This handles POST /api/products (adding a new product)
    public Product createProduct(@RequestBody Product product) {
        return repository.save(product);
    }
}