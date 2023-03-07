# sample

A template Flutter project.

## Getting Started

1. Download project at here: http://vtskit.atviettelsolutions.com/mobile

2. (Optional) Copy icon resource to /res/icons/. Read more about 2.0x, 3.0x
   directory [Loading images](https://docs.flutter.dev/development/ui/assets-and-images#loading-images).<br>
   Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate resource
   variables. <br>
   Or remove /res, /lib/res.dart, /lib/res.g.dart, /lib/res.res.g.part, /build.yaml, module
   resource_generator va dependency build_runner in /pubspec.yaml.

3. (Optional) Define messages in /lib/l10n/app_en.arb & /lib/l10n/app_vi.arb.
   Run `flutter gen-l10n` to generate localizations.
   
4. Implement Call API <br>
    Implement `fromResponse` function in [AppResponseJson](lib/network/response_json.dart)<br>
    Implement `onRequestHandle` & `onErrorHandle` functions in [interceptors.dart](lib/network/interceptors.dart)<br>
    Create new Data object in /lib/model/data. Add `export '<new file.dart>'` into [data.dart](lib/model/data/data.dart)<br>
    Fill host (do not add `/` at end of string) & create call API function in [ApiServices](lib/model/api_services.dart)<br>
    Create get data function in [Repository](lib/model/repository.dart)<br>
    Use Repository's get data function in GetxController or Bloc<br>
   
5. See more examples in [sample module](lib/sample) if you haven't deleted it yet :v
