package com.example.automateallthingsapp;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class MainController {

    private final TimeProvider timeProvider;

    @GetMapping("/")
    public ResponseDto root() {
        return new ResponseDto(
            "Break the test",
            timeProvider.getCurrentDateTimeAsLong()
        );
    }
}
