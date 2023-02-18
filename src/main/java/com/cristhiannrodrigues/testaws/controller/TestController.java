package com.cristhiannrodrigues.testaws.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/test")
public class TestController {

    @GetMapping
    public String test() {
        return "ESTOU UP NO DOCKER NA AWS.";
    }

}
