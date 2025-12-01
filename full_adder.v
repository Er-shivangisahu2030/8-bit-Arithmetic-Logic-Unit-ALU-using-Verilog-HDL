module full_adder (
    input a,       // First input bit
    input b,       // Second input bit
    input cin,     // Carry input
    output sum,    // Sum output
    output cout    // Carry output
);

assign sum = a ^ b ^ cin;          // Sum is XOR of inputs and carry in
assign cout = (a & b) | (b & cin) | (a & cin);  // Carry out is majority function

endmodule
