module ADC_Ctrl(
                 input clk,
                 output CS,
                 output DCLOCK,
                 input DOUT,
                 output [15:0] data,
                 output [15:0] realdat
                 
               );
      
    integer i;  
    reg cs,dclock,dout_reg;
    assign CS=cs;
    
    reg [15:0]Realdat;
    reg [15:0]Data;
    assign data=Data;
    assign realdat=Realdat;
    assign DCLOCK=dclock;
    
    initial begin
      cs<=1'b1;
      dclock<=0;
      Realdat<=0;
      Data<=0;
    end
    
    always@(posedge clk)begin
      if(i==80)cs<=0;
      if(i==120)dclock<=1;//1
      if(i==160)dclock<=0;
      if(i==200)dclock<=1;//2
      if(i==240)dclock<=0;
      if(i==280)dclock<=1;//3
      if(i==320)dclock<=0;
      if(i==360)dclock<=1;//4
      if(i==400)dclock<=0;
      if(i==440)dclock<=1;//5
      if(i==480)dclock<=0;
      if(i==520)dclock<=1;////00
      if(i==560)dclock<=0;
      if(i==600)begin
          dclock<=1;////0
          Data[15]<=DOUT;
        end
      if(i==640)dclock<=0;
      if(i==680)begin
          dclock<=1;////1
          Data[14]<=DOUT;
        end
      if(i==720)dclock<=0;
      if(i==760)begin
          dclock<=1;////2
          Data[13]<=DOUT;
        end
      if(i==800)dclock<=0;
      if(i==840)begin
          dclock<=1;////3
          Data[12]<=DOUT;
        end
      if(i==880)dclock<=0;
      if(i==920)begin
          dclock<=1;////4
          Data[11]<=DOUT;
        end
      if(i==960)dclock<=0;
      if(i==1000)begin
          dclock<=1;////5
          Data[10]<=DOUT;
        end
      if(i==1040)dclock<=0;
      if(i==1080)begin
          dclock<=1;////6
          Data[9]<=DOUT;
        end
      if(i==1120)dclock<=0;
      if(i==1160)begin
          dclock<=1;////7
          Data[8]<=DOUT;
        end
      if(i==1200)dclock<=0;
      if(i==1240)begin
          dclock<=1;////8
          Data[7]<=DOUT;
        end
      if(i==1280)dclock<=0;
      if(i==1320)begin
          dclock<=1;////9
          Data[6]<=DOUT;
      end
      if(i==1360)dclock<=0;
      if(i==1400)begin
          dclock<=1;////10
          Data[5]<=DOUT;
        end
      if(i==1440)dclock<=0;
      if(i==1480)begin
          dclock<=1;////11
          Data[4]<=DOUT;
        end
      if(i==1520)dclock<=0;
      if(i==1560)begin
          dclock<=1;////12
          Data[3]<=DOUT;
        end
      if(i==1600)dclock<=0;
      if(i==1640)begin
          dclock<=1;////13
          Data[2]<=DOUT;
        end
      if(i==1680)dclock<=0;
      if(i==1720)begin
          dclock<=1;////14
          Data[1]<=DOUT;
        end
      if(i==1760)dclock<=0;
      if(i==1800)begin
          dclock<=1;////15
          Data[0]<=DOUT;
        end
      if(i==1840)begin
          dclock<=0;
          Realdat<=Data;
        end
      if(i==1880)begin
          dclock<=1;////00
        end
      if(i==1920)dclock<=0;
      if(i==1960)begin
        cs<=1;
        dclock<=0;
      end
    end
    
    always@(posedge clk)begin
       if(i<2000)i<=i+1;
       else i<=0;
    end
                     
endmodule
