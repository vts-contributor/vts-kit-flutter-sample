# sample

A template Flutter project.

## Getting Started

1. Clone project

```shell
git clone http://10.60.156.11/gpmn/framework/flutter-sample.git
```

2. Run app <br>

Or setting project

2. Remove .git directory & init new git & remote

3. Remove /lib/sample directory or run sample_main.dart then remove

4. Rename `flutter-sample` module

5. Rename `com.example.sample` application id

6. (Optional) Copy icon resource to /res/icons/. Read more about 2.0x, 3.0x
   directory [Loading images](https://docs.flutter.dev/development/ui/assets-and-images#loading-images).<br>
   Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate resource
   variables. <br>
   Or remove /res, /lib/res.dart, /lib/res.g.dart, /lib/res.res.g.part, /build.yaml, module
   resource_generator va dependency build_runner in /pubspec.yaml.

7. (Optional) Define messages in /lib/l10n/app_en.arb & /lib/l10n/app_vi.arb.
   Run `flutter gen-l10n` to generate localizations.
   
8. Implement Call API <br>
    Implement `fromResponse` function in [AppResponseJson](lib/network/response_json.dart)<br>
    Implement `onRequestHandle` & `onErrorHandle` functions in [interceptors.dart](lib/network/interceptors.dart)<br>
    Create new Data object in /lib/model/data. Add `export '<new file.dart>'` into [data.dart](lib/model/data/data.dart)<br>
    Fill host (do not add `/` at end of string) & create call API function in [ApiServices](lib/model/api_services.dart)<br>
    Create get data function in [Repository](lib/model/repository.dart)<br>
    Use Repository's get data function in GetxController or Bloc<br>
   
9. See more examples in [sample module](lib/sample) if you haven't deleted it yet :v