const std = @import("std");
const c = @cImport({
    @cInclude("raylib.h");
});

const Circle = struct {
    position: c.Vector2,
    speed: f32,
    active: bool,
};

const Player = struct {
    name: []const u8,
    position: f32,
    triangleHeight: f32,
    trianglePointWidth: f32,
    shootColor: c.Color,
    health: f32,
    circles: [10]Circle,
};

pub fn main() void {
    const screenWidth: i32 = 800;
    const screenHeight: i32 = 450;

    c.InitWindow(screenWidth, screenHeight, "Language Performance Visualization");
    c.SetTargetFPS(60);

    var zigPlayer = Player{
        .name = "Zig",
        .position = 0.1,
        .triangleHeight = 25,
        .trianglePointWidth = 45,
        .shootColor = c.RED,
        .health = 100,
        .circles = undefined,
    };

    var rustPlayer = Player{
        .name = "Rust",
        .position = 0.9,
        .triangleHeight = 25,
        .trianglePointWidth = 45,
        .shootColor = c.BROWN,
        .health = 100,
        .circles = undefined,
    };

    const circleRadius: f32 = 5;
    const circleSpeed: f32 = 5;

    initializeCircles(&zigPlayer.circles, circleSpeed);
    initializeCircles(&rustPlayer.circles, -circleSpeed);

    while (!c.WindowShouldClose()) {
        // Update
        if (c.IsKeyPressed(c.KEY_SPACE)) {
            shootCircle(&zigPlayer, screenWidth, screenHeight);
            shootCircle(&rustPlayer, screenWidth, screenHeight);
        }

        updateCircles(&zigPlayer.circles, screenWidth);
        updateCircles(&rustPlayer.circles, screenWidth);

        // Draw
        c.BeginDrawing();
        c.ClearBackground(c.BLACK);

        drawPlayer(zigPlayer, screenWidth, screenHeight);
        drawPlayer(rustPlayer, screenWidth, screenHeight);

        drawCircles(&zigPlayer.circles, circleRadius, zigPlayer.shootColor);
        drawCircles(&rustPlayer.circles, circleRadius, rustPlayer.shootColor);

        c.EndDrawing();
    }

    c.CloseWindow();
}

fn initializeCircles(circles: []Circle, speed: f32) void {
    for (circles) |*circle| {
        circle.* = Circle{ .position = c.Vector2{ .x = 0, .y = 0 }, .speed = speed, .active = false };
    }
}

fn shootCircle(player: *Player, screenWidth: i32, screenHeight: i32) void {
    for (&player.circles) |*circle| {
        if (!circle.active) {
            circle.active = true;
            circle.position = c.Vector2{
                .x = @as(f32, @floatFromInt(screenWidth)) * player.position + if (player.position < 0.5) player.trianglePointWidth else -player.trianglePointWidth,
                .y = @as(f32, @floatFromInt(screenHeight)) / 2,
            };
            break;
        }
    }
}

fn updateCircles(circles: []Circle, screenWidth: i32) void {
    for (circles) |*circle| {
        if (circle.active) {
            circle.position.x += circle.speed;
            if (circle.position.x > @as(f32, @floatFromInt(screenWidth)) or circle.position.x < 0) {
                circle.active = false;
            }
        }
    }
}

fn drawPlayer(player: Player, screenWidth: i32, screenHeight: i32) void {
    const x = @as(f32, @floatFromInt(screenWidth)) * player.position;
    const y = @as(f32, @floatFromInt(screenHeight)) / 2;

    c.DrawTriangleLines(c.Vector2{ .x = x, .y = y - player.triangleHeight / 2 }, c.Vector2{ .x = x, .y = y + player.triangleHeight / 2 }, c.Vector2{ .x = if (player.position < 0.5) x + player.trianglePointWidth else x - player.trianglePointWidth, .y = y }, c.WHITE);
}

fn drawCircles(circles: []const Circle, radius: f32, color: c.Color) void {
    for (circles) |circle| {
        if (circle.active) {
            c.DrawCircleV(circle.position, radius, color);
        }
    }
}
