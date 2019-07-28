module ADS8861(
    input clk,
    input rst,
    input en,
    input sdo,
    output sck,
    output convst,
    output [15:0] adcdata,
    output adc_idle
);

    logic sclk = 1'b0;
    logic conv = 1'b0;
    logic [15:0] data = 16'd0;
    logic [15:0] realdata = 16'd0;
    assign sck = sclk;
    assign convst = conv;

    logic [7:0] cnt100 = 8'd0;
    logic [4:0] cnt16 = 5'd0;
    logic Sample_flag = 1'b0;
    logic Get_flag = 1'b0;
    always_ff@(posedge clk) begin
        if (en) begin
            cnt100 <= 8'd0;
            conv <= 1'b1;
            Sample_flag <= 1'b1; 
        end
        else if(Sample_flag) begin
            sclk <= ~sclk;
            cnt100 <= cnt100 + 1;
            if (cnt100 == 8'd9) begin
                conv <= 1'b0;
            end
            else if(cnt100 > 8'd59 && sclk && Get_flag == 1'b0) begin
                data <= {data[14:0],sdo};
                cnt16 <= cnt16 + 1;
                if (cnt16 == 5'd15) begin
                    cnt16 <= 5'd0;
                    Get_flag <= 1'b1;
                    realdata <= data;
                end
            end
            else if(cnt100 == 8'd99)begin
                Sample_flag <= 1'b0;
            end
        end
    end
endmodule