module AddressMux #(
    parameter WIDTH = 5 
)(
    input sel,
    input [WIDTH - 1:0] A,
    input [WIDTH - 1:0] B,
    output [WIDTH - 1:0] Z
);
    assign Z = sel ? A : B;
endmodule

module DataMux #(
    parameter WIDTH = 5 
)(
    input sel,
    input [WIDTH - 1:0] A,
    output [WIDTH - 1:0] Z
);
    assign Z = sel ? A : 8'bz;
endmodule

