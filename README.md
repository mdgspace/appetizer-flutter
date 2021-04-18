# Appetizer

[![Flutter CI](https://github.com/mdg-iitr/Appetizer-flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/mdg-iitr/Appetizer-flutter/actions/workflows/ci.yml)

[![Flutter CI](https://github.com/mdg-iitr/Appetizer-flutter/actions/workflows/cd.yml/badge.svg)](https://github.com/mdg-iitr/Appetizer-flutter/actions/workflows/cd.yml)

Appetizer is a cross platform appication built in [flutter](https://flutter.dev/) to digitalize IIT Roorkee Mess.

## Getting Started

Follow these instructions to build and run the project

### Setup Flutter

A detailed guide for multiple platforms setup could be find [here](https://flutter.dev/docs/get-started/install/)

### Next Steps

- Clone this repository.
- `cd` into `Appetizer-flutter`.
- `flutter pub get` to get all the dependencies.
- `flutter run`

This project uses flutter version 2.0.4 and hence the support for compile time variables. To use compile time variables pass them in `--dart-defines` as `flutter run --dart-define=VAR_NAME=VAR_VALUE`. Supported `dart-defines` include :

#### Google Services Configuration

1. Create a firebase project.
2. Add Android & iOS app with the appropriate `package_name` & `bundle_identifier`.
3. Download `google-services.json` from firebase and place in `android/app/`.

Note: The Google Services Configuration section is mandatory to get started. To get hold of the above secrets/files drop a message on slack with clear requirements and we'll take care of that.

## Project Structure

```bash
Appetizer-flutter/lib/
├── config/                         # configuration files like environment_config
├── enums/                          # enum files
|   └── view_state.dart             # defines view states i.e Idle, Busy, Error
├── models/                         # model classes
|   └── dialog_models.dart          # dialog request and response models
        ...
├── services/                       # services
|   ├── API/                        # API implementations
|   └── dialog_service.dart         # handles dialog
|   └── local_storage_service.dart  # handles local storage (shared prefs)
├── ui/                             # UI layer
|  ├── views/                       # views
|  |  └── base_view.dart
|  |  └── home_view.dart
|  |  └── startup_view.dart
|  └── components/                  # shared components
├── utils/                          # utilities such as api_utils, app_exceptions.
├── viewmodels/                     # Viewmodels layer
├── app_theme.dart                  # Shared App Colors/Styles etc.
├── constants.dart                  # App constants
├── locator.dart                    # dependency injection using get_it
├── main.dart                       # <3 of the app
```

## Screenshots

<p>
<img src="https://user-images.githubusercontent.com/45434030/115134354-04d56b00-a02d-11eb-8464-10cb00cdb6d8.png" alt="Menu View" width="200">
<img src="https://user-images.githubusercontent.com/45434030/115134355-069f2e80-a02d-11eb-99ca-fd26778b3887.png" alt="Settings View" width="200">
<img src="https://user-images.githubusercontent.com/45434030/115134356-0737c500-a02d-11eb-98ec-3552315a164b.png" alt="Feedback View" width="200">
<img src="https://user-images.githubusercontent.com/45434030/115134359-07d05b80-a02d-11eb-9014-c36de8395178.png" alt="Leaves View" width="200">
<img src="https://user-images.githubusercontent.com/45434030/115134361-09018880-a02d-11eb-8300-2261279664f6.png" alt="Leaves History View" width="200">
</p>

## Community

We would love to hear from you! We communicate on the following platforms:

[![Slack](https://img.shields.io/badge/chat-on_slack-purple.svg?style=for-the-badge&logo=slack)](https://join.slack.com/t/mdg-open/shared_invite/zt-epxyukj9-reVHrkSahH3rmWl9llTh5g)

## Contributing

Whether you have some feauture requests/ideas, code improvements, refactoring, performance improvements, help is always Welcome. The more is done, better it gets.

If you found any bugs, consider opening an [issue](https://github.com/mdg-iitr/Appetizer-flutter/issues/new).

## For commit messages

Please start your commits with these prefixes for better understanding among collaborators, based on the type of commit:

    feat: (addition of a new feature)
    rfac: (refactoring the code: optimization/ different logic of existing code - output doesn't change, just the way of execution changes)
    docs: (documenting the code, be it readme, or extra comments)
    bfix: (bug fixing)
    chor: (chore - beautifying code, indents, spaces, camelcasing, changing variable names to have an appropriate meaning)
    ptch: (patches - small changes in code, mainly UI, for example color of a button, incrasing size of tet, etc etc)
    conf: (configurational settings - changing directory structure, updating gitignore, add libraries, changing manifest etc)
