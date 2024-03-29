const std = @import("std");

const z = @import("./LibZip.zig");

pub fn main() !void {
    const zip = z.LibZip{};

    try zip.addFileToZip("container.zip", "file.txt", "./file.txt");
}
