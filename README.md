# Performance Comparison Visualization: Zig vs Rust

This project provides a visual representation of performance comparisons between Zig and Rust for specific computational tasks. It uses a game-like interface to illustrate the speed differences, where faster completion of challenges results in the opponent's triangle losing life.

## Project Overview

The visualization consists of two triangles facing each other, representing Zig and Rust. As computational tasks are performed, the triangles shoot projectiles at each other. The speed and frequency of these projectiles are determined by the performance of each language for the given task.

### Key Features:

1. Visual representation of Zig and Rust as triangles
2. Performance-based projectile shooting
3. Life reduction for slower performance
4. Final "explosion" effect for the losing language

## Getting Started

### Prerequisites

- Zig compiler (latest version recommended)
- Rust compiler (for comparison tasks)
- Raylib library

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/zig-rust-performance-vis.git
   cd zig-rust-performance-vis
   ```

2. Ensure you have Zig and Rust installed on your system.

3. Install Raylib for Zig (instructions may vary based on your system).

### Running the Visualization

To run the Zig visualization:

```
zig build run
```

## Usage

1. Start the program to see the initial visualization with two triangles.
2. Press the spacebar to initiate a performance comparison task.
3. Observe the projectiles being fired based on the speed of computation.
4. Watch as the slower-performing language's triangle loses life.
5. Continue until one triangle "explodes," indicating a clear performance winner.

## Customizing Comparisons

To add or modify comparison tasks:

1. Create a new Zig file in the `src/tasks/` directory.
2. Implement the task in both Zig and Rust.
3. Add a function in `main.zig` to execute and time the task.
4. Update the visualization logic to reflect the new task's performance.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Raylib library for graphics
- Zig and Rust communities for their excellent languages and tools

## Future Improvements

- Add more varied computational tasks
- Implement a user interface for selecting tasks
- Enhance visual effects for better representation of performance differences
- Add support for comparing more programming languages