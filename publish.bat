
set https_proxy=http://127.0.0.1:1080
set FLUTTER_STORAGE_BASE_URL=
set PUB_HOSTED_URL=

flutter packages pub publish --dry-run
flutter packages pub publish
