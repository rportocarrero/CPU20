module registers(
    input i_clk,
    input i_rw,
    input[3:0] i_addr,
    output[15:0] o_data
);
reg[15:0] r_registers[15:0];
reg[15:0] r_data;

initial
r_registers[0] = 16'h00;

always@(posedge i_clk)
begin
    if(!i_rw) begin
        r_data = r_registers[i_addr];
    end
end
assign o_data = r_data;
endmodule