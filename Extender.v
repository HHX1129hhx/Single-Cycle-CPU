`define EXT_ZERO    2'b00
`define EXT_SIGNED  2'b01
`define EXT_HIGHPOS 2'b10
module Extender(ExtOut, DataIn, ExtOp);

input [15: 0] DataIn;
input ExtOp;
output reg[31: 0] ExtOut;

integer i;     //逻辑计数

always@(DataIn or ExtOp)
begin
    case (ExtOp)
        `EXT_ZERO:
            ExtOut = {16'd0, DataIn};
        `EXT_SIGNED:
            ExtOut = {{16{DataIn[15]}}, DataIn};
        `EXT_HIGHPOS:
            ExtOut = {DataIn, 16'd0};
        default:
            ;
    endcase
end

/*
begin
 if(ExtOp == 1)
  begin
   for(i=0;i<32;i=i+1)
   begin
    if(i<16)
     ExtOut[i] = DataIn[i];
    else
     ExtOut[i] = 0;
   end 
  end
 else
  begin
   for(i=0;i<32;i=i+1)
   begin
    if(i<16)
     ExtOut[i] = DataIn[i];
    else
     ExtOut[i] = DataIn[15];
   end
  end*/
endmodule
