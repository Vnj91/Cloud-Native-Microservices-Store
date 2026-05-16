package com.devopsstore.product_service;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    // Cleaned up constructor - no more repository injection
    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping 
    public List<Product> getAllProducts() {
        return productService.getAllProducts();
    }

    @PostMapping 
    @ResponseStatus(HttpStatus.CREATED)
    public Product createProduct(@Valid @RequestBody Product product) {
        return productService.createProduct(product);
    }

    @GetMapping("/{id}")
    public Product getProductById(@PathVariable Long id) {
        // Delegating lookup to the service layer
        return productService.getProductById(id);
    }
}