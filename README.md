# Appetizer-Flutter

An application for digitalzing IIT Roorkee Mess

## Read for contributing

Use of files

    models -> All data models 
    screens -> All app screens
    services -> Any services or API classes
    utils -> Utility classes 

Structure code in this way:

    // Inside widget class
    -- variables (private if possible)
    -- build method (Inside build(), use sub methods like _buildAppBar()
    -- sub-build methods
    -- other methods
    -- utility methods
 
## For commit messages

Please start your commits with these prefixes for better understanding among collaborators, based on the type of commit:

    feat: (addition of a new feature)
    rfac: (refactoring the code: optimization/ different logic of existing code - output doesn't change, just the way of execution changes)
    docs: (documenting the code, be it readme, or extra comments)
    bfix: (bug fixing)
    chor: (chore - beautifying code, indents, spaces, camelcasing, changing variable names to have an appropriate meaning)
    ptch: (patches - small changes in code, mainly UI, for example color of a button, incrasing size of tet, etc etc)
    conf: (configurational settings - changing directory structure, updating gitignore, add libraries, changing manifest etc)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
