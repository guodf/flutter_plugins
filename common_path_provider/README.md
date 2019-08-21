# common_path_provider

获取Android/IOS常用目录路径

## Android

```dart
import 'package:common_path_provider/path_provider.dart';

print(await PathProvider.getPublicPath(DirectoryType.alarms));
print(await PathProvider.getPublicPath(DirectoryType.cache));
print(await PathProvider.getPublicPath(DirectoryType.dcim));
print(await PathProvider.getPublicPath(DirectoryType.documents));
print(await PathProvider.getPublicPath(DirectoryType.download));
print(await PathProvider.getPublicPath(DirectoryType.home));
print(await PathProvider.getPublicPath(DirectoryType.movies));
print(await PathProvider.getPublicPath(DirectoryType.music));
print(await PathProvider.getPublicPath(DirectoryType.pictures));

print(await PathProvider.appPathProvider.appExternalPath);
print(await PathProvider.appPathProvider.appExternalFilesPath);
print(await PathProvider.appPathProvider.appExternalCachePath);
print(await PathProvider.appPathProvider.appExternalPublicPath(DirectoryType.movies));
## 下面方法使用path_proivder实现
print(await PathProvider.appPathProvider.appPath);
print(await PathProvider.appPathProvider.appCachePath);
print(await PathProvider.appPathProvider.appDataPath);
print(await PathProvider.appPathProvider.appFilesPath);
```

### 获取多个scard路径（未实现）


## IOS(未实现)


