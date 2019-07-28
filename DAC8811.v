module DAC_Ctrl(input clk,
                output CS,
                output SCLK
               );
    integer num;
    reg cs,sclk;
    assign CS=cs;
    assign SCLK=sclk;
    reg state,next_state;
    initial begin
      num<=0;
      state<=1'b0;
      cs<=1;
      sclk<=1;
    end
    
    always@(posedge clk)begin
      sclk<=~sclk;
    end
    always@(posedge clk)begin
      state<=next_state;
    end
    always@(posedge clk)begin
      case(state)
        1'b0:cs<=1;
        1'b1:begin
               cs<=0;
               if(num<34)num<=num+1;
               else num<=0;
             end
      endcase
    end
    always@(posedge clk)begin
      case(state)
        1'b0:next_state<=4'b1;
        1'b1:begin
                if(num!=33)next_state<=2'b1;
                else next_state<=2'b0;
             end
      endcase
    end
endmodule

module UseDAC(input clk,
              input [15:0] data,//
              output CS,
              output SCLK,
              output SerialData//
              );
    integer i;
    reg sclk2;
    wire SCLK2;
    assign SCLK2=sclk2;
    initial sclk2<=0;
    always@(posedge clk)begin
       if(i<10)i<=i+1;//control the sclk
       else begin
          i<=0;
          sclk2<=~sclk2;
       end
    end
  
    DAC_Ctrl dac(.clk(SCLK2),.CS(CS),.SCLK(SCLK));
    reg ori1,ori2;
    always@(posedge SCLK)begin//SCLK
       ori1<=CS;
       ori2<=ori1;
    end
    wire en;
    assign en=ori1&&(~ori2);
    reg [16:0] Data;
    reg serialdata;
    assign SerialData=serialdata;
    integer num;
    initial num<=0;
    always@(posedge SCLK)begin
       if(CS)num<=0;
       if(num<16)num<=num+1;
    end
    always@(posedge en)begin
       Data<={data,1'b0};
    end
    always@(posedge SCLK)begin
      if(num!=16)
        serialdata<=Data[16-num];
      else serialdata<=0;
    end
endmodule
