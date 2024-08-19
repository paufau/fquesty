# FQuesty

### FQuesty is the game engine for visual quests and novels.

Platforms support:

- Windows - Full Support
- Mac OS - Partial Support
- Web - Partial Support
- Android - Partial Support
- Linux - No support at the time
- iOS - No support at the time

## Table of contents

1. [Setup and launch](#setup-and-launch)
2. [Introduction](#introduction)
3. [Supported commands](#supported-functions)

## Setup and launch

1. Install flutter on your machine according the official Flutter documentation.
2. Run `dart ./lib/cmp.dart` in the project root folder to prepare game assets.
3. Run `flutter run` in the same directory to launch the game.

## Introduction

### First game scene

Open directory `assets/scenario` and then file `start.scn`.
Here you can see the entry point of your visual novel. Every time you make a change in .scn file,
you need run `dart ./lib/cmp.dart` to apply the changes in the game;

Try to write you first scene. Just add `me "I'm amazing"` inside the scene block like this:

```
character me (name: "Me")
scene start {
    me "I'm amazing" <-- Put it here
}
```

## Supported commands

Documentation is in progress. For full list of supported nodes and commands see: `lib/cmp/ast/nodes`

- `anchor {LABEL}` - Creates the target which could be used inside "jump" command
- `animate {ASSET} {ANIMATION}` - Executes the passed animation on the asset
- `animation {ANIMATION_TYPE} [: (ARGS)]` - Defines the animation.
  - Types: fadeIn, fadeOut, scale, slide.
  - Args: duration
- variable definition - Example: `sceneEntryAnimation = animation fadeIn : (duration: 1000)`
  - Assignable values: every game object + strings, numerics, booleans, characters could be saved in a variable
- `character {NAME} : (ARGS)` - Creates a character which could be displayed on the screen
  - Args: name (used in the game), sprite

## Project structure

- lib - Root folder
  - cmp - Compile which is capable of building an Abstract Syntax Tree from .scn files
  - engine - Realtime AST interpreter which manages game workflow
