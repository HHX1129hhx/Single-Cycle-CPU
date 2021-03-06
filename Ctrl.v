`include "instruction_def.v"
`include "ctrl_encode_def.v"

module Ctrl(jump, RegDst, Branch, MemR, Mem2R, MemW, RegW, Alusrc, ExtOp, Aluctrl, OpCode, funct);
    input [5:0] OpCode;              //指令操作码字段
    input [5:0] funct;               //指令功能字段

    output reg jump;                 //指令跳转
    output reg RegDst;
    output reg Branch;               //分支
    output reg MemR;                 //读存储器
    output reg Mem2R;                //数据存储器到寄存器堆
    output reg MemW;                 //写数据存储器
    output reg RegW;                 //寄存器堆写入数据
    output reg Alusrc;               //运算器操作数选择
    output reg ExtOp;                //位扩展/符号扩展选择
    output reg [4:0] Aluctrl;        //Alu运算选择

    always@(OpCode or funct)
    begin
        case(OpCode)
            `INSTR_RTYPE_OP:
            begin
                assign jump = 0;
                assign RegDst = 0;
                assign Branch = 0;
                assign MemR = 0;
                assign Mem2R = 0;
                assign MemW = 0;
                assign RegW = 1;
                assign Alusrc = 0;
                assign ExtOp = `EXT_ZERO;
                case(funct)
                    `INSTR_ADDU_FUNCT:
                        assign Aluctrl = `ALUOp_ADDU;
                    `INSTR_SUBU_FUNCT:
                        assign Aluctrl = `ALUOp_SUBU;
                    `INSTR_ADD_FUNCT:
                        assign Aluctrl = `ALUOp_ADD;
                    `INSTR_SUB_FUNCT:
                        assign Aluctrl = `ALUOp_SUB;
                    `INSTR_SLT_FUNCT:
                        assign Aluctrl = `ALUOp_SLT;
                    `INSTR_OR_FUNCT:
                        assign Aluctrl = `ALUOp_OR;
                    `INSTR_AND_FUNCT:
                        assign Aluctrl = `ALUOp_AND;
                    `INSTR_SLL_FUNCT:
                        assign Aluctrl = `ALUOp_SLL;
                    `INSTR_SRL_FUNCT:
                        assign Aluctrl = `ALUOp_SRL;
                    default:
                        ;
                endcase
            end
            
            
            `INSTR_LW_OP:
            begin
                assign jump = 0;
                assign RegDst = 1;
                assign Branch = 0;
                assign MemR = 1;
                assign Mem2R = 1;
                assign MemW = 0;
                assign RegW = 1;
                assign Alusrc = 1;
                assign ExtOp = `EXT_SIGNED;
                assign Aluctrl = `ALUOp_ADD;
            end
            
            
            `INSTR_SW_OP:
            begin
                assign jump = 0;
                // assign RegDst = x;
                assign Branch = 0;
                assign MemR = 0;
                assign Mem2R = 0;
                assign MemW = 1;
                assign RegW = 0;
                assign Alusrc = 1;
                assign ExtOp = `EXT_SIGNED;
                assign RegDst=1;
                assign Aluctrl = `ALUOp_ADD;
            end
            
            
            `INSTR_LUI_OP:
            begin
                assign jump = 0;
                assign RegDst = 1;
                assign Branch = 0;
                assign MemR = 0;
                assign Mem2R =0;
                assign MemW = 0;
                assign RegW = 1;
                assign Alusrc = 1;
                assign ExtOp = `EXT_SIGNED;
                assign Aluctrl = `ALUOp_LUI;
            end
            
            `INSTR_ORI_OP:
            begin
                assign jump = 0;
                assign RegDst = 1;
                assign Branch = 0;
                assign MemR = 0;
                assign Mem2R =0;
                assign MemW = 0;
                assign RegW = 1;
                assign Alusrc =1;
                assign ExtOp =`EXT_ZERO;
                assign Aluctrl = `ALUOp_OR;
            end
            
         
	      	`INSTR_BEQ_OP:
		         begin
		            assign jump = 0;
		            assign RegDst=0;
		            assign Alusrc=0;
		            assign Mem2R=0;
		            assign RegW=0;
		            assign MemR=0;
		            assign MemW=0;
		            assign Branch=1;
		            assign ExtOp =`EXT_SIGNED;
		            assign Aluctrl=`ALUOp_EQL;
		         end
		      `INSTR_BNE_OP:
	          	begin
	          	  assign jump = 0;
		           assign RegDst=0;
		           assign Alusrc=0;
		           assign Mem2R=0;
		           assign RegW=0;
		           assign MemR=0;
		           assign MemW=0;
		           assign Branch=1;
		           assign ExtOp =`EXT_SIGNED;
		           assign Aluctrl=`ALUOp_BNE;//?ask 
		         end

         //j mistake   
          `INSTR_J_OP :
             begin
                assign jump = 1;
                assign RegDst = 0;
                assign Branch = 0;
                assign MemR = 0;
                assign Mem2R = 0;
                assign MemW = 0;
                assign RegW = 0;
                assign Alusrc = 0;
                assign ExtOp = `EXT_ZERO;
                assign Aluctrl=`ALUOp_ADD;
             end
            
           `INSTR_ADDI_OP :
              begin
                assign jump = 0;
                assign RegDst = 1;
                assign Branch = 0;
                assign MemR = 0;
                assign Mem2R = 0;
                assign MemW = 0;
                assign RegW = 1;
                assign Alusrc = 1;
                assign ExtOp = `EXT_SIGNED;
                assign Aluctrl = `ALUOp_ADD;
             end
                
        endcase
    end
endmodule
