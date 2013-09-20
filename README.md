# Kablammo Strategy Guide

If you haven't already, visit [http://kablammo.io](http://kablammo.io) and take a look around at the existing bots and the arena, as well as the rules and basic instructions.

## Basics

### 1. Create a repo
It's gotta be on github.

### 2. Add this to your Gemfile
`gem 'kablammo', github: 'carbonfive/kablammo-strategy'`

### 3. Write your strategy.rb
(see below)

## Writing a Strategy
All your strategy has to do is call the on_turn handler method and return a string containing one of four commands - identifying what your robot should do next.

From within this handler you have access to the current battle including the game board with all robots and walls.

The commands that you can return are:

* Rotate your turret: `r180`
* Fire your laser with optional compensation factor: `f10`
* Move in a cardinal direction: `n`
* Rest to regain ammo: `.`

### Hello, Robot
So you want to come out guns a-blaizin' like Newman and Redford at the end of Butch Cassify and the Sundance Kid?  Good for you.  This could be your strategy.

file: strategy.rb

```
on_turn do
  'f'
end
```

It's that easy!  Unless, of course, you want to win some battles.

## Details

Each robot begins with 5 ammo and 10 armor. If your robot's armor reaches 0, you are eliminated from the arena and lose 1 point. If your robot is the last remaining robot in the arena, you are victorious and gain 3 points.

All battles last (at most) 100 turns. If more than one robot remains after 100 turns (or if the remaining robots are eliminated simultaneously), each remaining robot earns 1 point for a tie.

All robot turns are resolved in phases, simultaneously.  You can do **one** of these thing each turn.

* First all movement is resolved
* Then all turret rotation is resolved
* Then all firing (and damage) is resolved
* Finally all resting is resolved

Robots that die remain on the game board and are obstacles.

### Moving your robot
You can move your robot one square in any cardinal direction - ie: not diagonally.

Command: `n`, `s`, `e` or `w`.

### Rotating your turret
You can rotate your robot's turret to any position you want in one turn.  Your turret has to be pointing in the general direction of your enemy before you can fire and hit it.

Command: `r<deg>`, deg = turret angle in degrees (0 - 360)

Example: `r145`

**NOTE**: With the rotate command you specify the *absolute* angle of your turret.  The angle you specify is where your turrent will end up.

### Firing your laser
Once you have your turrent poiting in the general direction of your enemy, you can fire your laser.  Within a single turn you are allowed to rotate your turrent slightly before firing - 10 degrees in either direction.

Command: `f<deg>`, deg = turret rotation in degrees (-10 - 10)

Example: `f-8`

**NOTE**: With the fire command you specify the *relative* angle of your turrent. The angle you specify is how far your turrent will go relative to its current angle.

### Resting
You can take a turn to rest.  You will not move or rotate or fire, but you will gain back one laser bullet.

Obviously your robot has some motion-hindered solar laser batteries.  Duh.

## Tips

To help you get started, there are example strategies provided for agressive, defensive, and hybrid robots in the gem's code base.

In addition, `base.rb` contains a DSL that implements some of the more complicated logic for locating enemies, avoiding walls, and calculating firing solutions. The sample strategies utilize this DSL, but you are free to roll your own, so long as it emits one of the approved returns for the `on_turn` handler.

## The Tournament

We'll be running a tournament pitting robots against each other throughout GoGaRuCo. To check your robot's standing, [visit the leaderboard](http://kablammo.io/strategies). 

Once the conference is over, we'll be selecting the "best" robot and award its creator a Printrbot Simple. This will probably be the robot with the best overall record, unless you cheat, in which case we will make your robot sadder than C3PO on Bespin.  Unless unless you cheat in some super awesome way, in which case we will try to hire you.

Please [check out the rules](http://kablammo.io/rules) for details.

## Questions

If you have any questions, please email [kablammo@carbonfive.com](mailto:kablammo@carbonfive.com), come by the Carbon Five table at GoGaRuCo, or Tweet #kablammo and we'll try and give you a hand.
