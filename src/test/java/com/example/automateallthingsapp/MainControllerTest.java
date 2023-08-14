package com.example.automateallthingsapp;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

@WebMvcTest
class MainControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    TimeProvider timeProvider;

    @Test
    void shouldContainProperMessage() throws Exception {
        Long mockTime = 123L;
        when(timeProvider.getCurrentDateTimeAsLong())
            .thenReturn(mockTime);
        this.mockMvc.perform(get("/"))
            .andExpect(status().isOk())
            .andExpect(content().json("""
                {
                    "message": "Automate all the things!",
                    "timestamp": %d
                }
                """.formatted(mockTime)));
    }
}