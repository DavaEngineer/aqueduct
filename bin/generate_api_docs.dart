import 'package:wildfire/wildfire.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future main(List<String> args) async {
  var configuration = new WildfireConfiguration("config.yaml.src");
  var app = new Application<WildfirePipeline>()
    ..configuration.port = configuration.port
    ..configuration.pipelineOptions = {
      WildfirePipeline.ConfigurationKey : configuration
    };

  var resolver = new PackagePathResolver(".packages");
  var document = app.document(resolver);

  var json = JSON.encode(document.asMap());
  var file = new File("swagger.json");
  var sink = file.openWrite();
  sink.write(json);
  await sink.close();
}
