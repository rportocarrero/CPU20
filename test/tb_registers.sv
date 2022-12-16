`timescale 1ns/10ps

module tb_registers;
    reg clk;
    reg[3:0] r_addr;
    wire[15:0] w_data;
    reg r_rw;
    integer fd, r, fo;

    reg[15:0] vec_input;
    reg[15:0] vec_exp;

    registers uut(.i_addr(r_addr), .i_clk(clk), .i_rw(r_rw), .o_data(w_data));

    initial
    begin
        $display("Testing Register File...");


        fd = $fopen("test/vectors/tb_registers_vec.csv", "r");
        if(fd) $display("opened test vector file %h", fd);
        else begin
            $display("unable to open test vector file %h", fd);
            $finish;
        end


        fo = $fopen("test/logs/tb_registers.txt", "w");
        if(fo) $display("opened test output file %h", fo);
        else begin
            $display("unable to open output text file %h", fo);
            $finish;
        end

        while(! $feof(fd))
        begin
            r = $fscanf(fd,"%h,%h",vec_input, vec_exp);
            r_addr = vec_input[3:0];
            r_rw = vec_input[4];
            #20;
            $fwrite(fo, "address: %h, r/w: %b, data:%h, expected:%h\n", r_addr, r_rw, w_data,vec_exp);
        end
        $fclose(fd);
        $fclose(fo);
        $finish;
    end

    initial begin 
    forever begin
    clk = 0;
    #10 clk = ~clk;
    end end

endmodule