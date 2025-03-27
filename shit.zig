const std = @import("std");

pub fn foo(x: usize) type {
    const y: usize = x * 2;
    return struct {
        pub fn cb() usize {
            return y;
        }
        pub fn cb2(_: *const @This()) usize {
            return x;
        }
    };
}

test "me" {
    const x: usize = 3;
    const S = foo(x);
    try std.testing.expectEqual(6, S.cb());

    const s: S = .{};
    try std.testing.expectEqual(3, s.cb2());
}

// const Greeter = struct {
//     name: []const u8,
//     pub fn sayHello(self: *const Greeter) void {
//         std.debug.print("Hello from {s}!\n", .{self.name});
//     }
// };
// fn registerCallback(callback_fn: *const fn () void) void {
//     std.debug.print("Registering callback...\n", .{});
//     callback_fn();
// }
//
// fn setupAndRegisterCallback(instance: *const Greeter) void {
//     _ = instance;
//     // Define a struct with a method locally
//     const LocalGreeterWrapper = struct {
//         // This method is defined within a struct local to setupAndRegisterCallback
//         fn cb() void {
//             // instance.sayHello();
//             std.debug.print("Hello from here!\n", .{});
//         }
//     };
//
//     registerCallback(&LocalGreeterWrapper.cb);
// }
//
// test "Closure" {
//     const greeter_instance = Greeter{ .name = "Alice" };
//     setupAndRegisterCallback(&greeter_instance);
// }
