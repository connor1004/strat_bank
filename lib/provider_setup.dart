import 'package:flutter_base/core/apis/implementations/survey_impl.dart';
import 'package:flutter_base/core/apis/interfaces/survey_api.dart';
import 'package:provider/provider.dart';

List<SingleChildCloneableWidget> providers = [
  ...apis,
];

List<SingleChildCloneableWidget> apis = [
  Provider<SurveyApi>.value(value: SurveyImpl(),),
];
