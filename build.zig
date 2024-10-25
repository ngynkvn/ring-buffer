const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "ring-buffer",

        .root_source_file = b.path("src/RingBuffer.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/RingBuffer.zig"),
        .target = target,
        .optimize = optimize,
    });
    const M = b.addModule("ring-buffer", .{
        .root_source_file = b.path("src/RingBuffer.zig"),
        .target = target,
        .optimize = optimize,
    });
    _ = M;

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);

    const check_step = b.step("check", "Run unit checks");
    check_step.dependOn(&lib.step);
    check_step.dependOn(&run_lib_unit_tests.step);
}
