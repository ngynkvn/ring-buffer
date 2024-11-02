const std = @import("std");

pub fn main() !void {
    var rb = try @import("ringbuffer").RingBuffer(f32).init(std.heap.page_allocator, 4);
    try rb.write(1);
    try rb.write(1);
    try rb.write(2);
    try rb.write(3);
    rb.write(3) catch rb.writeAssumeCapacity(4);
    std.debug.print("{d}\n", .{rb.data});
}
