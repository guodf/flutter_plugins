abstract class LoggerProvider {
  info(String msg);
  debug(String msg);
  log(String msg);
  error(String msg);
}

class PrintLoggerProvider implements LoggerProvider {

  @override
  debug(String msg) {
    print("debug:[${DateTime.now()}]:$msg");
  }

  @override
  error(String msg) {
    print("error:[${DateTime.now()}]:$msg");
  }

  @override
  info(String msg) {
    print("info:[${DateTime.now()}]:$msg");
  }

  @override
  log(String msg) {
    print("log:[${DateTime.now()}]:$msg");
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
