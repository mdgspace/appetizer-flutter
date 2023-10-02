# appetizer

A new Flutter project for mess management.

## Screenshots
![appetizer1](https://github.com/mdgspace/appetizer-flutter/assets/125895535/9871a663-d349-4f44-b6b0-fc5ed49c96a3 = 360x732.5)
![appetizer2](https://github.com/mdgspace/appetizer-flutter/assets/125895535/46c96910-2107-4634-b672-68df2060b5c8 = 360x732.5)
![appetizer 3 ](https://github.com/mdgspace/appetizer-flutter/assets/125895535/3f3ff461-94e1-4d14-bbe0-034408657ae6 = 360x732.5)


## Getting Started

Project Structure:-
```
|- assets { contains icons, images, fonts }
|- lib
|    |- data
|    |    |- core { contains intrinsic routers, registery and theme }
|    |    |- constants { contains app wide constants, environment configuration and api end points  }
|    |    |- services { contains local and remote ApiService and StorageService }
|    |- domain
|    |    |- amenity { contains Firebase AnalticsService }
|    |    |- core { contains core router and theme }
|    |    |- models { contains object models like coupons, mutlimessing, menu, leaves, etc. }
|    |    |- repositories { contains leave and user repositories according to BLoC architecture pattern }
|    |- enums { contains the enums used throughout the app }
|    |- presentation { contains UI and BLoC code arranged in folders according to app flow }
|    |    |- components { contains component widgets used throughout the app }
|    |- utils { contains utility methods and classes }

```

## Setup for development 

### 0. Clone this repo
```
$ git clone https://github.com/mdgspace/appetizer-flutter.git
$ cd appetizer-flutter
```

### 1. Get dependencies
```
$ flutter pub get
```

In case of build error, try:

``` $ flutter clean ```


### 2. Run the app

``` dart run build_runner build -d ```

## How to Contribute

We'd love to accept your patches and contributions to this project. There are just a few small guidelines you need to follow.

+ When contributing to this repository, please first discuss the change you wish to make via the issues section before starting any major work.
+ Once you have started work on any issue open a WIP pull request addressing that issue so that we know that someone is working on it.
+ While writing any code for this project ensure that it is well formatted and consistent with the architecture of the rest of the project.
+ Please make sure that you use the standard dart nomenclature.
+ Before committing any change make sure their is no compilation warning or error.

## Commit messages

Please start your commits with these prefixes for better understanding among collaborators, based on the type of commit:

```
+ feat: (addition of a new feature)
+ rfac: (refactoring the code: optimization/ different logic of existing code - output doesn't change, just the way of execution changes)
+ docs: (documenting the code, be it readme, or extra comments)
+ bfix: (bug fixing)
+ chor: (chore - beautifying code, indents, spaces, camelcasing, changing variable names to have an appropriate meaning)
+ ptch: (patches - small changes in code, mainly UI, for example color of a button, incrasing size of tet, etc etc)
+ conf: (configurational settings - changing directory structure, updating gitignore, add libraries, changing manifest etc)
+ test: (adding or editting tests)
```







