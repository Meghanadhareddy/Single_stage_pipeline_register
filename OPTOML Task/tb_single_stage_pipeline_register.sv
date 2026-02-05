`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Meghanadha
// 
// Create Date: 05.02.2026 23:04:12
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
module tb_single_stage_pipeline_register;

    parameter DATA_WIDTH = 32;

    logic clk;
    logic rst_n;

    logic in_valid;
    logic in_ready;
    logic [DATA_WIDTH-1:0] in_data;

    logic out_valid;
    logic out_ready;
    logic [DATA_WIDTH-1:0] out_data;

    single_stage_pipeline_register #(.DATA_WIDTH(DATA_WIDTH)) dut (.clk(clk), .rst_n(rst_n),
    .in_valid(in_valid), .in_ready(in_ready), .in_data(in_data),
     .out_data(out_data), .out_valid(out_valid), .out_ready(out_ready));

    always #5 clk = ~clk;

    logic [DATA_WIDTH-1:0] queue[$];

    initial begin
        clk = 0;
        rst_n = 0;
        in_valid = 0;
        out_ready = 0;

        repeat(5) @(posedge clk);
        rst_n = 1;

        repeat(200) begin
            @(posedge clk);

            in_valid  = $urandom_range(0,1);
            out_ready = $urandom_range(0,1);
            in_data   = $urandom();

            if (in_valid && in_ready)
                queue.push_back(in_data);

            if (out_valid && out_ready) begin
                if (queue.size() == 0)
                    $fatal("Unexpected output");

                if (queue.pop_front() != out_data)
                    $fatal("Mismatch");
            end
        end

        #50;
        $display("Simulation Passed");
        $finish;
    end

endmodule
