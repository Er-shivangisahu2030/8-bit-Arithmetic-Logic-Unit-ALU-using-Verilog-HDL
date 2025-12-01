`timescale 1ns / 1ps

module alu_tb;

    // Testbench variables
    reg [7:0] A, B;
    reg [3:0] ALU_Sel;
    wire [15:0] ALU_Result;
    wire [7:0] Quotient, Remainder;
    wire CarryOut;
    wire DivideByZero;

    // Instantiate the ALU
    alu uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Result(ALU_Result),
        .Quotient(Quotient),
        .Remainder(Remainder),
        .CarryOut(CarryOut),
        .DivideByZero(DivideByZero)
    );

    // Task to display results nicely
    task display_output;
    begin
        $display("ALU_Sel=%b | A=%d, B=%d => Result=%d, Quotient=%d, Remainder=%d, CarryOut=%b, DivideByZero=%b", 
                 ALU_Sel, A, B, ALU_Result, Quotient, Remainder, CarryOut, DivideByZero);
    end
    endtask

    initial begin
        // Dump waves for GTKWave
        $dumpfile("alu_tb.vcd");       // VCD file name
        $dumpvars(0, alu_tb);          // Dump all variables in this module and below

        // Test Addition
        A = 8'd20; B = 8'd15; ALU_Sel = 4'b0000; #10; display_output();

        // Test Subtraction
        A = 8'd30; B = 8'd10; ALU_Sel = 4'b0001; #10; display_output();

        // Test Multiplication
        A = 8'd7; B = 8'd6; ALU_Sel = 4'b0010; #10; display_output();

        // Test Division - Normal
        A = 8'd40; B = 8'd5; ALU_Sel = 4'b0011; #10; display_output();

        // Test Division by Zero
        A = 8'd40; B = 8'd0; ALU_Sel = 4'b0011; #10; display_output();

        // Logical Shift Left
        A = 8'b00001111; B = 8'd0; ALU_Sel = 4'b0100; #10; display_output();

        // Logical Shift Right
        A = 8'b00001111; B = 8'd0; ALU_Sel = 4'b0101; #10; display_output();

        // AND Operation
        A = 8'b10101010; B = 8'b11001100; ALU_Sel = 4'b1000; #10; display_output();

        // OR Operation
        // Keep A and B same as previous since you didn't assign new values
        ALU_Sel = 4'b1001; #10; display_output();

        // XOR Operation
        ALU_Sel = 4'b1010; #10; display_output();

        // Equal
        A = 8'd25; B = 8'd25; ALU_Sel = 4'b1111; #10; display_output();

        // Greater
        A = 8'd50; B = 8'd20; ALU_Sel = 4'b1110; #10; display_output();

        $finish;
    end

endmodule
