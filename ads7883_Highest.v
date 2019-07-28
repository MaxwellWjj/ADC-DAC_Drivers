module ads7883(
	input wire clk,
	input wire en,
	output reg cs,
	output reg sck,
	input wire sdo,
	output reg [11:0] data
    //output adc_idle
);

	reg [3:0] cnt16 = 4'd0;
	reg [11:0] data_ = 12'd0;

	always@(posedge clk)begin
		if(en)begin
			cs <= 1'b0;
			cnt16 <= 4'd0;
			sck <= 1'b1;
		end
		else begin
			if(~cs)begin
				sck <= ~sck;
				if(sck)begin
					data_ <= {data_[10:0],sdo};
					cnt16 <= cnt16 + 1'b1;
				end
				else begin
					if(cnt16 == 4'd14)data <= data_;
					if(cnt16 == 4'd0)cs <= 1'b1;
				end
			end
			else begin
				cnt16 <= 4'd0;
				sck <= 1'b1;
			end
		end
	end
	
endmodule
