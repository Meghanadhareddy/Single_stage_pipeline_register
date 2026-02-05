`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Meghanadha
// 
// Create Date: 05.02.2026 22:24:58
// Design Name: 
// Module Name: single_stage_pipeline_register
// Project Name: 
// Target Devices: 
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


module single_stage_pipeline_register #(
    parameter DATA_WIDTH = 32
)(
    input  logic                    clk,
    input  logic                    rst_n,

    // Input interface
    input  logic                    in_valid,
    output logic                    in_ready,
    input  logic [DATA_WIDTH-1:0]   in_data,

    // Output interface
    output logic                    out_valid,
    input  logic                    out_ready,
    output logic [DATA_WIDTH-1:0]   out_data
);

    // Internal storage
    logic [DATA_WIDTH-1:0] data_reg;
    logic                  valid_reg;

    // -----------------------------
    // Ready Logic
    // -----------------------------
    // Ready when:
    //   1. Stage is empty OR
    //   2. Output is being accepted
    assign in_ready = !valid_reg || (out_ready);

    // Output assignments
    assign out_valid = valid_reg;
    assign out_data  = data_reg;

    // -----------------------------
    // Sequential Logic
    // -----------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_reg <= 1'b0;
            data_reg  <= '0;
        end
        else begin
            // Accept new data
            if (in_valid && in_ready) begin
                data_reg  <= in_data;
                valid_reg <= 1'b1;
            end
            // Data consumed but no new data arriving
            else if (out_ready && valid_reg) begin
                valid_reg <= 1'b0;
            end
        end
    end

endmodule

