# ChronoClimb

A time-bending 2D platformer where players navigate challenging levels using their ability to manipulate time.

![ChronoClimb Game](https://via.placeholder.com/800x400?text=ChronoClimb+Screenshot)

## Game Overview

ChronoClimb is a precision platformer built with Godot Engine that combines classic platforming mechanics with innovative time manipulation abilities. Players must navigate through increasingly difficult levels, collecting time crystals, avoiding hazards, and using their rewind ability strategically to overcome obstacles.

## Features

- **Time Rewind Mechanic**: Rewind time up to 5 seconds to correct mistakes or solve puzzles
- **Dynamic Platforming**: Master wall jumps, coyote time jumps, and jump buffering for precise movement
- **Varied Obstacles**: Encounter moving platforms, collapsing surfaces, enemies, and hazardous spike traps
- **Time Crystal Collection**: Gather crystals to unlock doors and progress through the game
- **Challenging Level Design**: Test your reflexes and strategic thinking with carefully crafted levels

## Controls

- **A/Left Arrow**: Move left
- **D/Right Arrow**: Move right
- **W/Up Arrow**: Jump
- **Space**: Rewind time (when time crystals are collected)
- Wall sliding happens automatically when against a wall
- Wall jumping is performed by pressing jump while sliding

## Getting Started

### Prerequisites

- [Godot Engine 4.4+](https://godotengine.org/download)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/chronoclimb.git
   ```
2. Open the project in Godot Engine:
   - Launch Godot
   - Select "Import"
   - Navigate to the cloned repository
   - Open the "project.godot" file

3. Run the game by pressing F5 or clicking the Play button

## Development

ChronoClimb is developed using Godot Engine 4.4 with GDScript. The game architecture includes:

- Character controller with advanced platforming physics
- State-based animation system
- Time manipulation system using state buffers
- Modular level design with reusable components

## Contributing

We welcome contributions to ChronoClimb! If you'd like to contribute, please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with [Godot Engine](https://godotengine.org/)
- Inspired by time-bending games like Braid and classic platformers 