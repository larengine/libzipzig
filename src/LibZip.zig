const std = @import("std");

const z = @cImport({
    @cInclude("zip.h");
});

pub const LibZip = struct {
    pub fn addFileToZip(this: @This(), zipname: [*c]const u8, filename: [*c]const u8, filedir: [*c]const u8) !void {
        _ = this;

        const file_zip = z.zip_open(zipname, z.ZIP_CREATE | z.ZIP_TRUNCATE, null);
        if (file_zip == null) {
            std.debug.print("{s}\n", .{z.zip_strerror(file_zip)});
            return;
        }

        const source = z.zip_source_file(file_zip, filedir, 0, -1);
        if (source == null) {
            std.debug.print("{s}\n", .{z.zip_strerror(file_zip)});
            return;
        }

        const index = z.zip_file_add(file_zip, filename, source, z.ZIP_FL_OVERWRITE);
        if (index < 0) {
            std.debug.print("{s}\n", .{z.zip_strerror(file_zip)});
            _ = z.zip_source_free(source);
            _ = z.zip_close(file_zip);
        }

        if (z.zip_close(file_zip) < 0) {
            std.debug.print("{s}\n", .{z.zip_strerror(file_zip)});
            return;
        }

        std.debug.print("File Zip was created successfully\n", .{});
    }
};
