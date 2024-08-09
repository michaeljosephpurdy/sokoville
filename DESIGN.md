# Sokoville

## Background

In Februrary of 2024, I participated in a game jam with the theme of 'Your Life is Currency'.
I made a sokoban-like game called 'Sacrifice and Atone'.
To progress past eash puzzle you need to make a sacrifice at each altar, which means you often also have to sacrifice yourself to proceed to the next level.

I really enjoyed the development process, and am proud of the resulting game.
It can be played here: https://purdy.itch.io/2024-winter-game-jam

The idea of 'Sokoville' came into my mind shortly the game jam was over.
I first started documenting ideas for 'Sokoville' on March 6th, 2024.

Begin game can start and player can push letter blocks into their name to input their name

Sleep to reset world

## Technical Thoughts

I started using [tiny-ecs](https://github.com/bakpakin/tiny-ecs/), an Entity Component System library in for Lua.
I'm still getting used to the paradigm, and am likely making a lot of mistakes, but overall I'm enjoying it.
So, this project will also be using `tiny-ecs`.

I've also been using annotations provided by [lua-ls](https://luals.github.io/wiki/annotations/) to enforce typechecking.
`lua-ls` is a language server, implementing the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/).

I love Lua and how flexible it is, and how I don't _need_ to define everything I'm doing with a strict interface.
However, I'm at the point now where I've made a lot (12+) games, most of them written in Lua.
The amount of time I've had bugs due to small typos, or defining a variable in one place but trying to reference it in another with the incorrect name, is crazy.

I plan on strictly typing the interface 'Component' and will _likely_ have variables for each component hidden in a top-level container.

```
---@class (exact) Position
---@field position _PositionComponent

---@class (exact) _PositionComponent
---@field x number
---@field y number
```

```
---@type Position | Drawable
player = {
  position = { // Position component
    x = 10,
    y = 10
  },
  drawable = {
...
```

## Meta-Puzzles

Dog to kid
Lost kid to parent
Clean up kids room (garbage to trash can)
Artifact to priest
Boxes to truck
Shy couple together
Fix a bridge
Delivery letter lost at mail office


## Equipment

You can get equipment in the game:

A glove that lets you pull blocks instead of only pushing them.

Boots that let you jump over blocks, but only once sort of like checkers.

And users can equip them differently maybe using the crank or something this will help them speed through old puzzles, similar to how metro you get all these skills or upgrades that let you really beast through levels.


## Research Opportunities

Baba is you - 

Cosmic Express - 

A Good Snowman is Hard to Build - 

Steven Sausage Roll - 

Snake Bird - 

