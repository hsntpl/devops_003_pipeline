package com.example.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;

@RestController
public class DevopsController {

    @GetMapping
    public String devopsHello(){
        return "Hello Jenkins! Hello pipeline! ";
    }

    @GetMapping("info")
    public String info(){
        return "Hello INFO HSN versiyon 1.0.4 kopyalandı jenkins için"  + LocalDateTime.now();
    }
}
