module tb_pipeline;
parameter width = 32;
logic clk;
logic rstn;
logic in_valid;
logic [width-1:0] in_data;
logic in_ready;
logic out_valid;
logic [width-1:0] out_data;
logic out_ready;
pipeline #(width) dut (
    .clk(clk),
    .rstn(rstn),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_ready(out_ready),
    .in_ready(in_ready),
    .out_valid(out_valid),
    .out_data(out_data)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("pipeline.vcd");
    $dumpvars(0, tb_pipeline);
    clk = 0;
    rstn = 0;
    in_valid = 0;
    in_data = 0;
    out_ready = 0;
    #12 rstn = 1;
    @(posedge clk);
    in_valid = 1;
    in_data  = 32'h1111_1111;
    @(posedge clk);
    in_valid = 0;
    repeat (2) @(posedge clk);
    out_ready = 1;
    @(posedge clk);
    if (out_valid && out_ready)
        $display("Time=%0t Output=%h", $time, out_data);
    in_valid = 1;
    in_data  = 32'h2222_2222;
    @(posedge clk);
    in_valid = 0;
    @(posedge clk);
    if (out_valid && out_ready)
        $display("Time=%0t Output=%h", $time, out_data);
    $finish;
end
endmodule