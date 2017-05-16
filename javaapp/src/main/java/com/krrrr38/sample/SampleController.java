package com.krrrr38.sample;

import java.util.concurrent.atomic.AtomicBoolean;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SampleController {
    private final AtomicBoolean atomicBoolean = new AtomicBoolean(true);

    @GetMapping("/")
    public String home() {
        return "OK";
    }

    @GetMapping("/status/check")
    public String checkStatus(HttpServletResponse httpServletResponse) {
        if (atomicBoolean.get()) {
            return "OK";
        } else {
            httpServletResponse.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
            return "NG";
        }
    }

    @PostMapping("/status/on")
    public String turnOn() {
        atomicBoolean.set(true);
        return "STATUS CHANGED => ON";
    }

    @PostMapping("/status/off")
    public String turnOff() {
        atomicBoolean.set(false);
        return "STATUS CHANGED => OFF";
    }
}
