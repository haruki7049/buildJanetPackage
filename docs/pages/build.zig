const std = @import("std");
const zine = @import("zine");

pub fn build(b: *std.Build) void {
    zine.website(b, .{
        .title = "Homepage and documents for buildJanetPackage",
        .host_url = "https://projects.haruki7094.dev/buildJanetPackage",
        .layouts_dir_path = "layouts",
        .content_dir_path = "content",
        .assets_dir_path = "assets",
    });
}
