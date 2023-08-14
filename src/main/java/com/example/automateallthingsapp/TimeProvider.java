package com.example.automateallthingsapp;

import java.time.LocalDateTime;
import java.time.ZoneId;
import org.springframework.stereotype.Component;

@Component
public class TimeProvider {
    public Long getCurrentDateTimeAsLong() {
        return LocalDateTime.now().atZone(ZoneId.of("UTC")).toEpochSecond();
    }
}
