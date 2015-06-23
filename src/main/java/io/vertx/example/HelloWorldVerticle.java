package io.vertx.example;

import io.netty.handler.codec.http.HttpResponseStatus;
import io.vertx.core.AbstractVerticle;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpServer;
import io.vertx.core.http.HttpServerResponse;
import io.vertx.ext.web.Router;

/**
 * @author <a href="http://tfox.org">Tim Fox</a>
 */
public class HelloWorldVerticle extends AbstractVerticle {

  @Override
  public void start() throws Exception {
    HttpServer httpServer = vertx.createHttpServer();

    Router router = Router.router(vertx);

    router.get("/").handler(routingContext -> {
      HttpServerResponse response = routingContext.response();
      response.putHeader("content-type", "text/plain");
      response.end("Hello World!");
    });

    router.get("/hello2").handler(routingContext -> {
      HttpServerResponse response = routingContext.response();
      response.putHeader("content-type", "text/plain");
      response.end("Hello World from Vert.x-Web!");
    });

    router.post("/postme").handler(routingContext -> {
      HttpServerResponse response = routingContext.response();
      if(routingContext.request().formAttributes().contains("saveme")) {
        response.end(routingContext.request().formAttributes().get("saveme"));
        return;
      }
      response.setStatusCode(HttpResponseStatus.BAD_REQUEST.code()).end("FAIIILLLL!!");
    });

    httpServer.requestHandler(router::accept).listen(8087);
  }
}
