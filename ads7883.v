`timescale 1ns/1ps

module ads7883(
	input wire clk,
	input wire en,
	output reg cs,
	output reg sck,
	input wire sdo,
	output reg [11:0] data,
    output adc_idle
);

	reg [1:0] cnt4 = 2'd0;
	reg [3:0] cnt16 = 4'd0;
	reg [11:0] data_ = 12'd0;
    reg sample_state = 1'b0;
    assign adc_idle = sample_state;
	always@(posedge clk)begin
		if(en)begin
			cs <= 1'b0;
			cnt4 <= 2'b0;
			cnt16 <= 4'b0;
          sample_state <= 1'b1;
		end
		else begin
			if(~cs)cnt4 <= cnt4 + 1'b1;
			else cnt4 <= 2'b0;
			if(cnt4 == 2'd1)begin
				sck <= 1'b0;
				data_ <= {data_[10:0],sdo};
			end
			else if(cnt4 == 2'd3)begin
				sck <= 1'b1;
				if(cnt16 < 4'd15) begin
					if(cnt16 == 4'd13)begin data <= data_; end
					cnt16 <= cnt16 + 1'b1;
				end	
				else begin
					cs <= 1'b1; sample_state <= 1'b0; 
				end
			end
		end
	end
	
endmodule