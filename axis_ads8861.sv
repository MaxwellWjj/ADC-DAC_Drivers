`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HUST-STI
// Engineer: Tony Wu
// 
// Create Date: 2019/07/24 13:20:06
// Design Name: 
// Module Name: axis_ads8861
// Project Name: ADS8861 (ADC) Driver
// Target Devices: ADS8861 (ADC) Driver With AXIStream Interface
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axis_ads8861(
    input clk,
    input rst,
    input m_axis_tready,    
    input sdo,
    output sck,
    output convst,
    output din,
	output logic [31:0] m_axis_tdata,
	output logic m_axis_tlast,
	output logic m_axis_tvalid        
    );
    logic [15:0] adcdata;
    logic [7:0] cnt_en = 8'd0;
    logic [9:0] count_512 = 10'd0;    
    logic adc_idle;
    logic en_adc_finish;    
    logic en = 1'b0;
    
    Rising2En Finishen (clk,adc_idle,en_adc_finish);    
    
    always_ff@(posedge clk) begin
        if(!rst) begin cnt_en<=8'd0; en<=1'b0;  end    
        if(cnt_en==8'd119) begin cnt_en <= 8'd0; en<=1'b1; end
        else begin
            cnt_en<=cnt_en+1;
            en <= 1'b0;
        end
    end
    
    always_ff@(posedge clk) begin
        if(!rst) begin count_512<=10'd0; m_axis_tlast <= 1'b0; m_axis_tvalid <= 1'b0; m_axis_tdata<=16'd0; end
        else if(en_adc_finish&&m_axis_tready) begin
            m_axis_tvalid <= 1'b1;
            m_axis_tdata <= {16'b0000000000000000,adcdata};
            count_512 <= count_512+1;
            m_axis_tlast <= 1'b0;
            if(count_512 == 10'd511)begin
                count_512 <= 10'd0;
                m_axis_tlast <= 1'b1;
            end
        end
        else begin
            m_axis_tvalid <= 1'b0;
            m_axis_tdata <= m_axis_tdata;
        end
    end     
    
    ads8861 ADC (clk,sdo,en,din,convst,sck,adcdata,adc_idle);
endmodule
