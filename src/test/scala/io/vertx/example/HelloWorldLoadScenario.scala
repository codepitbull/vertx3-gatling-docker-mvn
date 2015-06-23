package io.vertx.example

import io.gatling.core.scenario.Simulation
import io.gatling.core.Predef._
import io.gatling.http.Predef._

/**
 * Created by jmader on 29.04.15.
 */
class HelloWorldLoadScenario extends Simulation {

  val target = if (System.getenv("TEST_TARGET") != null) System.getenv("TEST_TARGET") else "127.0.0.1"

  val httpConf = http
    .baseURL("http://"+target+":8087")
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0")

  val scn = scenario("BasicSimulation")
    .exec(http("request_1")
    .get("/"))
    .pause(5)

  setUp(
    scn.inject(atOnceUsers(1))
  )
    .protocols(httpConf)
    .assertions(
      global.responseTime.max.lessThan(50),
      global.successfulRequests.percent.greaterThan(95)
    )
}
