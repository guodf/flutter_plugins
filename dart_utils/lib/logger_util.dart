
import 'package:ansicolor/ansicolor.dart';

abstract class LoggerProvider {
  info(String msg);
  debug(String msg);
  log(String msg);
  error(String msg);
}

class PrintLoggerProvider implements LoggerProvider {

  var _pen=AnsiPen();
  
	_info(text) => (_pen..green())("info:${DateTime.now()}:$text");
	_error(text) => (_pen..red())("error:${DateTime.now()}:$text");
	_log(text) => (_pen..white())("log:${DateTime.now()}:$text");
	_debug(text) => (_pen..yellow())("debug:${DateTime.now()}:$text");

  @override
  debug(String msg) {
    print(_debug(msg));
  }

  @override
  error(String msg) {
    print(_error(msg));  }

  @override
  info(String msg) {
    print(_info(msg));  }

  @override
  log(String msg) {
    print(_log(msg));
  }
}

class Logger {
  static List<LoggerProvider> _providers = [PrintLoggerProvider()];

  static void regProvider(LoggerProvider provider) {
    assert(provider != null);
    _providers.add(provider);
  }

  static void debug(String msg) {
    _providers.forEach((provider) => provider.debug(msg));
  }

  static void error(String msg) {
    _providers.forEach((provider) => provider.error(msg));
  }

  static void info(String msg) {
    _providers.forEach((provider) => provider.info(msg));
  }

  static void log(String msg) {
    _providers.forEach((provider) => provider.log(msg));
  }
}
