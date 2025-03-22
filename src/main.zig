var i: usize = 0;
fn readNum(expr: []const u8) i32 {
    var sum: i32 = 0;
    var sign: i32 = 1;
    while (i < expr.len) {
        var num: i32 = 0;
        while (i < expr.len and expr[i] >= '0' and expr[i] <= '9') {
            num = num * 10 + (expr[i] - '0');
            i += 1;
        }

        sum += sign * num;
        sign = 1;

        if (i < expr.len) {
            if (expr[i] == '-') {
                sign = -1;
            } else if (expr[i] == ' ') {
                break;
            }
            i += 1;
        }
    }

    return sum;
}

fn readSpace(expr: []const u8) void {
    while (i < expr.len and expr[i] == ' ') {
        i += 1;
    }
}

fn eval(expr: []const u8) i32 {
    var sum: i32 = 0;
    if (std.mem.startsWith(u8, expr, "if ")) {
        i += 3;
        readSpace(expr);

        const condition = readNum(expr);
        readSpace(expr);

        if (condition != 0) {
            sum = readNum(expr);
        } else {
            _ = readNum(expr);
            readSpace(expr);
            sum = readNum(expr);
        }
    } else {
        sum = readNum(expr);
    }

    return sum;
}

pub fn main() void {
    //const result = eval("1+10-31+2+3"); //
    //const result = eval("if 0 10 11"); // 11
    const result = eval("if 0 10 11+2"); // 13
    std.debug.print("{}\n", .{result});
}

const std = @import("std");
