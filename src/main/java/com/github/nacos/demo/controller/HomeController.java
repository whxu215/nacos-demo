package com.github.nacos.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/")
@RefreshScope
public class HomeController {
  @Value("${useLocalCache:false}")
  private boolean useLocalCache;

  @RequestMapping(value = "/", method = RequestMethod.GET)
  public String home() {
    return "Springboot!";
  }

  @RequestMapping(value = "/cache", method = RequestMethod.GET)
  public boolean cacheConfig() {
    return useLocalCache;
  }
}
