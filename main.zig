const std = @import("std");
const c = @cImport({
    @cInclude("raylib.h");
});

const Circle = struct {
    position: c.Vector2,
    speed: f32,
    active: bool,
};

pub fn main() void {
    const screenWidth: i32 = 800;
    const screenHeight: i32 = 450;

    c.InitWindow(screenWidth, screenHeight, "Shooting Triangles");

    c.SetTargetFPS(60);

    const triangleHeight: f32 = 25;
    const trianglePointWidth: f32 = 45;
    const maxCircles = 10;
    const circleRadius: f32 = 5;
    const circleSpeed: f32 = 5;

    var leftCircles: [maxCircles]Circle = undefined;
    var rightCircles: [maxCircles]Circle = undefined;

    for (&leftCircles) |*circle| {
        circle.* = Circle{ .position = c.Vector2{ .x = 0, .y = 0 }, .speed = circleSpeed, .active = false };
    }
    for (&rightCircles) |*circle| {
        circle.* = Circle{ .position = c.Vector2{ .x = 0, .y = 0 }, .speed = -circleSpeed, .active = false };
    }

    while (!c.WindowShouldClose()) {
        // Update
        if (c.IsKeyPressed(c.KEY_SPACE)) {
            // Shoot circles
            for (&leftCircles) |*circle| {
                if (!circle.active) {
                    circle.active = true;
                    circle.position = c.Vector2{
                        .x = @as(f32, @floatFromInt(screenWidth)) * 0.1 + trianglePointWidth,
                        .y = @as(f32, @floatFromInt(screenHeight)) / 2,
                    };
                    break;
                }
            }
            for (&rightCircles) |*circle| {
                if (!circle.active) {
                    circle.active = true;
                    circle.position = c.Vector2{
                        .x = @as(f32, @floatFromInt(screenWidth)) * 0.9 - trianglePointWidth,
                        .y = @as(f32, @floatFromInt(screenHeight)) / 2,
                    };
                    break;
                }
            }
        }

        // Move active circles
        for (&leftCircles) |*circle| {
            if (circle.active) {
                circle.position.x += circle.speed;
                if (circle.position.x > @as(f32, @floatFromInt(screenWidth))) {
                    circle.active = false;
                }
            }
        }
        for (&rightCircles) |*circle| {
            if (circle.active) {
                circle.position.x += circle.speed;
                if (circle.position.x < 0) {
                    circle.active = false;
                }
            }
        }

        // Draw
        c.BeginDrawing();

        c.ClearBackground(c.BLACK);

        // Left triangle
        c.DrawTriangleLines(c.Vector2{ .x = @as(f32, @floatFromInt(screenWidth)) * 0.1, .y = @as(f32, @floatFromInt(screenHeight)) / 2 - triangleHeight / 2 }, c.Vector2{ .x = @as(f32, @floatFromInt(screenWidth)) * 0.1, .y = @as(f32, @floatFromInt(screenHeight)) / 2 + triangleHeight / 2 }, c.Vector2{ .x = @as(f32, @floatFromInt(screenWidth)) * 0.1 + trianglePointWidth, .y = @as(f32, @floatFromInt(screenHeight)) / 2 }, c.WHITE);

        // Right triangle
        c.DrawTriangleLines(c.Vector2{ .x = @as(f32, @floatFromInt(screenWidth)) * 0.9, .y = @as(f32, @floatFromInt(screenHeight)) / 2 - triangleHeight / 2 }, c.Vector2{ .x = @as(f32, @floatFromInt(screenWidth)) * 0.9, .y = @as(f32, @floatFromInt(screenHeight)) / 2 + triangleHeight / 2 }, c.Vector2{ .x = @as(f32, @floatFromInt(screenWidth)) * 0.9 - trianglePointWidth, .y = @as(f32, @floatFromInt(screenHeight)) / 2 }, c.WHITE);

        // Draw circles
        for (leftCircles) |circle| {
            if (circle.active) {
                c.DrawCircleV(circle.position, circleRadius, c.WHITE);
            }
        }
        for (rightCircles) |circle| {
            if (circle.active) {
                c.DrawCircleV(circle.position, circleRadius, c.WHITE);
            }
        }

        c.EndDrawing();
    }

    c.CloseWindow();
}
