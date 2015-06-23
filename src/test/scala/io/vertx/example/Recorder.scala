package io.vertx.example

import io.gatling.recorder.config.RecorderPropertiesBuilder
import io.gatling.recorder.controller.RecorderController

object Recorder extends App {

	val props = new RecorderPropertiesBuilder
	props.simulationOutputFolder(IDEPathHelper.recorderOutputDirectory.toString)
	props.simulationPackage("de.codepitbull.gatling")
	props.bodiesFolder(IDEPathHelper.requestBodiesDirectory.toString)

	RecorderController(props.build, scala.Option(IDEPathHelper.recorderConfigFile))
}