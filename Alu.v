`include "ctrl_encode_def.v"

module Alu(AluResult, Zero, DataIn1, DataIn2, AluCtrl);
input [31: 0] DataIn1;        //运算数据1
input [31: 0] DataIn2;        //运算数据2
input [4: 0] AluCtrl;        //运算器控制信号
output reg [31: 0] AluResult;      //运算器输出结果
output reg Zero;           //结果是否为零

initial
begin
    Zero = 0;
    AluResult = 0;
end

always@(DataIn1 or DataIn2 or AluCtrl)
begin
    case (AluCtrl)
        `ALUOp_NOP:
            ;
        `ALUOp_ADDU:
            AluResult = DataIn1 + DataIn2;
        `ALUOp_ADD:
            AluResult = DataIn1 + DataIn2;
        `ALUOp_SUBU:
            AluResult = DataIn1 - DataIn2;
        `ALUOp_SUB:
            AluResult = DataIn1 - DataIn2;
        `ALUOp_AND:
            AluResult = DataIn1 & DataIn2;
        `ALUOp_OR:
            AluResult = DataIn1 | DataIn2;
        `ALUOp_NOR:
            AluResult = ~ (DataIn1 ^ DataIn2);
        `ALUOp_XOR:
            AluResult = DataIn1 ^ DataIn2;
        `ALUOp_SLT:
            AluResult = (DataIn1 < DataIn2) ? 1 : 0;
        `ALUOp_SLTU:
            AluResult = (DataIn1 < DataIn2) ? 1 : 0;
        `ALUOp_EQL:
            AluResult = (DataIn1 == DataIn2) ? 1 : 0;
        `ALUOp_LUI:
            AluResult = {DataIn2[15: 0], 16'd0};
        /*  `ALUOp_BNE:
          `ALUOp_GT0:
          `ALUOp_GE0:
          `ALUOp_LT0:
          `ALUOp_LE0:
          `ALUOp_SLL:
          `ALUOp_SRL:
          `ALUOp_SRA: */
        default:
            ;
    endcase
    if (DataIn1 == DataIn2)
        Zero = 1;
    else
        Zero = 0;
end

endmodule
