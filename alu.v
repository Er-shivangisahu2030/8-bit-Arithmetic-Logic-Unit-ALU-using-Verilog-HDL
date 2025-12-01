module alu(
    input [7:0] A, B,              // 8-bit Inputs
    input [3:0] ALU_Sel,           // 4-bit ALU operation selector
    output reg [15:0] ALU_Result,  // 16-bit Output to support multiplication
    output reg [7:0] Quotient,     // For division
    output reg [7:0] Remainder,    // For division
    output CarryOut,               // Carry Out Flag for addition
    output reg DivideByZero        // Optional error flag
);

    wire [8:0] tmp; // For carry out from 8-bit addition
    assign tmp = {1'b0, A} + {1'b0, B};
    assign CarryOut = tmp[8]; // 9th bit is the carry

    always @(*) begin
        // Default outputs
        Quotient = 8'd0;
        Remainder = 8'd0;
        DivideByZero = 1'b0; // Default: no error

        case (ALU_Sel)
            4'b0000: // Addition
                ALU_Result = A + B;

            4'b0001: // Subtraction
                ALU_Result = A - B;

            4'b0010: // Multiplication
                ALU_Result = A * B;

            4'b0011: begin // Division
                if (B != 0) begin
                    Quotient = A / B;
                    Remainder = A % B;
                    ALU_Result = {8'd0, Quotient}; // To display quotient in result
                end else begin
                    DivideByZero = 1'b1;
                    Quotient = 8'hFF;             // Error value
                    Remainder = 8'hFF;
                    ALU_Result = 16'hDEAD;        // Chosen error code for undefined
                end
            end

            4'b0100: // Logical shift left
                ALU_Result = A << 1;

            4'b0101: // Logical shift right
                ALU_Result = A >> 1;

            4'b0110: // Rotate left
                ALU_Result = {A[6:0], A[7]};

            4'b0111: // Rotate right
                ALU_Result = {A[0], A[7:1]};

            4'b1000: // AND
                ALU_Result = A & B;

            4'b1001: // OR
                ALU_Result = A | B;

            4'b1010: // XOR
                ALU_Result = A ^ B;

            4'b1011: // NOR
                ALU_Result = ~(A | B);

            4'b1100: // NAND
                ALU_Result = ~(A & B);

            4'b1101: // XNOR
                ALU_Result = ~(A ^ B);

            4'b1110: // Greater
                ALU_Result = (A > B) ? 16'd1 : 16'd0;

            4'b1111: // Equal
                ALU_Result = (A == B) ? 16'd1 : 16'd0;

            default:
                ALU_Result = 16'd0;
        endcase
    end

endmodule
