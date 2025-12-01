`timescale 1ns/1ps

module full_adder_tb;

reg a, b, cin;
wire sum, cout;

// Instantiate the full_adder module
full_adder uut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin
    // VCD dump for GTKWave
    $dumpfile("full_adder_tb.vcd");
    $dumpvars(0, full_adder_tb);

    // Initialize inputs and display header
    $display("a b cin | sum cout");
    $display("-------------------");

    // Test all possible input combinations (0 to 7)
    a = 0; b = 0; cin = 0; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    a = 0; b = 0; cin = 1; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    a = 0; b = 1; cin = 0; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    a = 0; b = 1; cin = 1; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    a = 1; b = 0; cin = 0; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    a = 1; b = 0; cin = 1; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    a = 1; b = 1; cin = 0; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    a = 1; b = 1; cin = 1; #10;
    $display("%b %b  %b  |  %b   %b", a, b, cin, sum, cout);

    $finish;
end

endmodule
