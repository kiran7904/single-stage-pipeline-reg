module pipeline #(parameter width=32)(input clk,rstn,input logic in_valid,input logic [width-1:0]in_data,input logic out_ready,output logic in_ready,output logic out_valid,output logic [width-1:0]out_data);
logic [width-1:0]data_reg;
logic valid_reg;
wire in = in_valid && in_ready;
wire out = out_valid && out_ready;

assign in_ready = ~valid_reg || out;
assign out_valid = valid_reg;
assign out_data = data_reg;
always_ff @(posedge clk or negedge rstn) begin
  if(!rstn) begin 
    valid_reg<=1'b0;
    data_reg  <= '0;
  end else begin 
         case ({in,out})
              2'b10: begin 
                       data_reg<=in_data;
                       valid_reg<=1'b1;
              end
              2'b01:valid_reg<=1'b0;
              2'b11:begin 
                  data_reg<=in_data;
                  valid_reg<=1'b1;
              end
             default: valid_reg<=valid_reg;
         endcase
    end
 end
endmodule                