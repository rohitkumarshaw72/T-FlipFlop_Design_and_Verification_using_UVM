
module tff (
    input clk, resetn, t,
    output reg q
);
    always @(posedge clk) begin
        if (!resetn)
            q <= 0;
        else if (t)
            q <= ~q;
    end
endmodule

