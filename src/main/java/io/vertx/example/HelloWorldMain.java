package io.vertx.example;

import io.vertx.core.Vertx;

/**
 * Created by jmader on 03.05.15.
 */
public class HelloWorldMain {
    public static void main(String[] args) {
        Vertx.vertx().deployVerticle(HelloWorldVerticle.class.getName());
    }
}
