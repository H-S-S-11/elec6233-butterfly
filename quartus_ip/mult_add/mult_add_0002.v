// (C) 2001-2020 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module  mult_add_0002  (
            addnsub1,
            clock0,
            clock1,
            clock2,
            dataa_0,
            dataa_1,
            datab_0,
            datab_1,
            ena0,
            ena1,
            ena2,
            sclr0,
            result);

            input  addnsub1;
            input  clock0;
            input  clock1;
            input  clock2;
            input [15:0] dataa_0;
            input [15:0] dataa_1;
            input [15:0] datab_0;
            input [15:0] datab_1;
            input  ena0;
            input  ena1;
            input  ena2;
            input  sclr0;
            output [32:0] result;

            wire [32:0] sub_wire0;
            wire [32:0] result = sub_wire0[32:0];    

            wire [31:0] wire_dataa;   
            assign wire_dataa[15:0] = dataa_0;
            assign wire_dataa[31:16] = dataa_1;

            wire [31:0] wire_datab;   
            assign wire_datab[15:0] = datab_0;
            assign wire_datab[31:16] = datab_1;

            altera_mult_add        altera_mult_add_component (
                                        .addnsub1 (addnsub1),
                                        .clock0 (clock0),
                                        .clock1 (clock1),
                                        .clock2 (clock2),
                                        .ena0 (ena0),
                                        .ena1 (ena1),
                                        .ena2 (ena2),
                                        .sclr0 (sclr0),
                                        .dataa (wire_dataa),
                                        .datab (wire_datab),
                                        .result (sub_wire0),
                                        .accum_sload (1'b0),
                                        .aclr0 (1'b0),
                                        .aclr1 (1'b0),
                                        .aclr2 (1'b0),
                                        .aclr3 (1'b0),
                                        .addnsub1_round (1'b0),
                                        .addnsub3 (1'b1),
                                        .addnsub3_round (1'b0),
                                        .chainin (1'b0),
                                        .chainout_round (1'b0),
                                        .chainout_sat_overflow (),
                                        .chainout_saturate (1'b0),
                                        .clock3 (1'b1),
                                        .coefsel0 ({3{1'b0}}),
                                        .coefsel1 ({3{1'b0}}),
                                        .coefsel2 ({3{1'b0}}),
                                        .coefsel3 ({3{1'b0}}),
                                        .datac ({32{1'b0}}),
                                        .ena3 (1'b1),
                                        .mult01_round (1'b0),
                                        .mult01_saturation (1'b0),
                                        .mult0_is_saturated (),
                                        .mult1_is_saturated (),
                                        .mult23_round (1'b0),
                                        .mult23_saturation (1'b0),
                                        .mult2_is_saturated (),
                                        .mult3_is_saturated (),
                                        .negate (1'b0),
                                        .output_round (1'b0),
                                        .output_saturate (1'b0),
                                        .overflow (),
                                        .rotate (1'b0),
                                        .scanina ({16{1'b0}}),
                                        .scaninb ({16{1'b0}}),
                                        .scanouta (),
                                        .scanoutb (),
                                        .sclr1 (1'b0),
                                        .sclr2 (1'b0),
                                        .sclr3 (1'b0),
                                        .shift_right (1'b0),
                                        .signa (1'b0),
                                        .signb (1'b0),
                                        .sload_accum (1'b0),
                                        .sourcea ({2{1'b0}}),
                                        .sourceb ({2{1'b0}}),
                                        .zero_chainout (1'b0),
                                        .zero_loopback (1'b0));
            defparam
                    altera_mult_add_component.number_of_multipliers = 2,
                    altera_mult_add_component.width_a = 16,
                    altera_mult_add_component.width_b = 16,
                    altera_mult_add_component.width_result = 33,
                    altera_mult_add_component.output_register = "CLOCK2",
                    altera_mult_add_component.output_aclr = "NONE",
                    altera_mult_add_component.output_sclr = "SCLR0",
                    altera_mult_add_component.multiplier1_direction = "ADD",
                    altera_mult_add_component.port_addnsub1 = "PORT_USED",
                    altera_mult_add_component.addnsub_multiplier_register1 = "UNREGISTERED",
                    altera_mult_add_component.addnsub_multiplier_aclr1 = "NONE",
                    altera_mult_add_component.addnsub_multiplier_sclr1 = "NONE",
                    altera_mult_add_component.multiplier3_direction = "ADD",
                    altera_mult_add_component.port_addnsub3 = "PORT_UNUSED",
                    altera_mult_add_component.addnsub_multiplier_register3 = "UNREGISTERED",
                    altera_mult_add_component.addnsub_multiplier_aclr3 = "NONE",
                    altera_mult_add_component.addnsub_multiplier_sclr3 = "NONE",
                    altera_mult_add_component.use_subnadd = "YES",
                    altera_mult_add_component.representation_a = "SIGNED",
                    altera_mult_add_component.port_signa = "PORT_UNUSED",
                    altera_mult_add_component.signed_register_a = "UNREGISTERED",
                    altera_mult_add_component.signed_aclr_a = "NONE",
                    altera_mult_add_component.signed_sclr_a = "NONE",
                    altera_mult_add_component.port_signb = "PORT_UNUSED",
                    altera_mult_add_component.representation_b = "SIGNED",
                    altera_mult_add_component.signed_register_b = "UNREGISTERED",
                    altera_mult_add_component.signed_aclr_b = "NONE",
                    altera_mult_add_component.signed_sclr_b = "NONE",
                    altera_mult_add_component.input_register_a0 = "CLOCK0",
                    altera_mult_add_component.input_register_a1 = "CLOCK0",
                    altera_mult_add_component.input_register_a2 = "UNREGISTERED",
                    altera_mult_add_component.input_register_a3 = "UNREGISTERED",
                    altera_mult_add_component.input_aclr_a0 = "NONE",
                    altera_mult_add_component.input_aclr_a1 = "NONE",
                    altera_mult_add_component.input_aclr_a2 = "NONE",
                    altera_mult_add_component.input_aclr_a3 = "NONE",
                    altera_mult_add_component.input_sclr_a0 = "SCLR0",
                    altera_mult_add_component.input_sclr_a1 = "SCLR0",
                    altera_mult_add_component.input_sclr_a2 = "NONE",
                    altera_mult_add_component.input_sclr_a3 = "NONE",
                    altera_mult_add_component.input_register_b0 = "CLOCK1",
                    altera_mult_add_component.input_register_b1 = "CLOCK1",
                    altera_mult_add_component.input_register_b2 = "UNREGISTERED",
                    altera_mult_add_component.input_register_b3 = "UNREGISTERED",
                    altera_mult_add_component.input_aclr_b0 = "NONE",
                    altera_mult_add_component.input_aclr_b1 = "NONE",
                    altera_mult_add_component.input_aclr_b2 = "NONE",
                    altera_mult_add_component.input_aclr_b3 = "NONE",
                    altera_mult_add_component.input_sclr_b0 = "SCLR0",
                    altera_mult_add_component.input_sclr_b1 = "SCLR0",
                    altera_mult_add_component.input_sclr_b2 = "NONE",
                    altera_mult_add_component.input_sclr_b3 = "NONE",
                    altera_mult_add_component.scanouta_register = "UNREGISTERED",
                    altera_mult_add_component.scanouta_aclr = "NONE",
                    altera_mult_add_component.scanouta_sclr = "NONE",
                    altera_mult_add_component.input_source_a0 = "DATAA",
                    altera_mult_add_component.input_source_a1 = "DATAA",
                    altera_mult_add_component.input_source_a2 = "DATAA",
                    altera_mult_add_component.input_source_a3 = "DATAA",
                    altera_mult_add_component.input_source_b0 = "DATAB",
                    altera_mult_add_component.input_source_b1 = "DATAB",
                    altera_mult_add_component.input_source_b2 = "DATAB",
                    altera_mult_add_component.input_source_b3 = "DATAB",
                    altera_mult_add_component.multiplier_register0 = "UNREGISTERED",
                    altera_mult_add_component.multiplier_register1 = "UNREGISTERED",
                    altera_mult_add_component.multiplier_register2 = "UNREGISTERED",
                    altera_mult_add_component.multiplier_register3 = "UNREGISTERED",
                    altera_mult_add_component.multiplier_aclr0 = "NONE",
                    altera_mult_add_component.multiplier_aclr1 = "NONE",
                    altera_mult_add_component.multiplier_aclr2 = "NONE",
                    altera_mult_add_component.multiplier_aclr3 = "NONE",
                    altera_mult_add_component.multiplier_sclr0 = "NONE",
                    altera_mult_add_component.multiplier_sclr1 = "NONE",
                    altera_mult_add_component.multiplier_sclr2 = "NONE",
                    altera_mult_add_component.multiplier_sclr3 = "NONE",
                    altera_mult_add_component.preadder_mode = "SIMPLE",
                    altera_mult_add_component.preadder_direction_0 = "ADD",
                    altera_mult_add_component.preadder_direction_1 = "ADD",
                    altera_mult_add_component.preadder_direction_2 = "ADD",
                    altera_mult_add_component.preadder_direction_3 = "ADD",
                    altera_mult_add_component.width_c = 16,
                    altera_mult_add_component.input_register_c0 = "UNREGISTERED",
                    altera_mult_add_component.input_register_c1 = "UNREGISTERED",
                    altera_mult_add_component.input_register_c2 = "UNREGISTERED",
                    altera_mult_add_component.input_register_c3 = "UNREGISTERED",
                    altera_mult_add_component.input_aclr_c0 = "NONE",
                    altera_mult_add_component.input_aclr_c1 = "NONE",
                    altera_mult_add_component.input_aclr_c2 = "NONE",
                    altera_mult_add_component.input_aclr_c3 = "NONE",
                    altera_mult_add_component.input_sclr_c0 = "NONE",
                    altera_mult_add_component.input_sclr_c1 = "NONE",
                    altera_mult_add_component.input_sclr_c2 = "NONE",
                    altera_mult_add_component.input_sclr_c3 = "NONE",
                    altera_mult_add_component.width_coef = 18,
                    altera_mult_add_component.coefsel0_register = "UNREGISTERED",
                    altera_mult_add_component.coefsel1_register = "UNREGISTERED",
                    altera_mult_add_component.coefsel2_register = "UNREGISTERED",
                    altera_mult_add_component.coefsel3_register = "UNREGISTERED",
                    altera_mult_add_component.coefsel0_aclr = "NONE",
                    altera_mult_add_component.coefsel1_aclr = "NONE",
                    altera_mult_add_component.coefsel2_aclr = "NONE",
                    altera_mult_add_component.coefsel3_aclr = "NONE",
                    altera_mult_add_component.coefsel0_sclr = "NONE",
                    altera_mult_add_component.coefsel1_sclr = "NONE",
                    altera_mult_add_component.coefsel2_sclr = "NONE",
                    altera_mult_add_component.coefsel3_sclr = "NONE",
                    altera_mult_add_component.coef0_0 = 0,
                    altera_mult_add_component.coef0_1 = 0,
                    altera_mult_add_component.coef0_2 = 0,
                    altera_mult_add_component.coef0_3 = 0,
                    altera_mult_add_component.coef0_4 = 0,
                    altera_mult_add_component.coef0_5 = 0,
                    altera_mult_add_component.coef0_6 = 0,
                    altera_mult_add_component.coef0_7 = 0,
                    altera_mult_add_component.coef1_0 = 0,
                    altera_mult_add_component.coef1_1 = 0,
                    altera_mult_add_component.coef1_2 = 0,
                    altera_mult_add_component.coef1_3 = 0,
                    altera_mult_add_component.coef1_4 = 0,
                    altera_mult_add_component.coef1_5 = 0,
                    altera_mult_add_component.coef1_6 = 0,
                    altera_mult_add_component.coef1_7 = 0,
                    altera_mult_add_component.coef2_0 = 0,
                    altera_mult_add_component.coef2_1 = 0,
                    altera_mult_add_component.coef2_2 = 0,
                    altera_mult_add_component.coef2_3 = 0,
                    altera_mult_add_component.coef2_4 = 0,
                    altera_mult_add_component.coef2_5 = 0,
                    altera_mult_add_component.coef2_6 = 0,
                    altera_mult_add_component.coef2_7 = 0,
                    altera_mult_add_component.coef3_0 = 0,
                    altera_mult_add_component.coef3_1 = 0,
                    altera_mult_add_component.coef3_2 = 0,
                    altera_mult_add_component.coef3_3 = 0,
                    altera_mult_add_component.coef3_4 = 0,
                    altera_mult_add_component.coef3_5 = 0,
                    altera_mult_add_component.coef3_6 = 0,
                    altera_mult_add_component.coef3_7 = 0,
                    altera_mult_add_component.accumulator = "NO",
                    altera_mult_add_component.accum_direction = "ADD",
                    altera_mult_add_component.use_sload_accum_port = "NO",
                    altera_mult_add_component.loadconst_value = 64,
                    altera_mult_add_component.accum_sload_register = "UNREGISTERED",
                    altera_mult_add_component.accum_sload_aclr = "NONE",
                    altera_mult_add_component.accum_sload_sclr = "NONE",
                    altera_mult_add_component.double_accum = "NO",
                    altera_mult_add_component.width_chainin = 1,
                    altera_mult_add_component.chainout_adder = "NO",
                    altera_mult_add_component.chainout_adder_direction = "ADD",
                    altera_mult_add_component.port_negate = "PORT_UNUSED",
                    altera_mult_add_component.negate_register = "UNREGISTERED",
                    altera_mult_add_component.negate_aclr = "NONE",
                    altera_mult_add_component.negate_sclr = "NONE",
                    altera_mult_add_component.systolic_delay1 = "UNREGISTERED",
                    altera_mult_add_component.systolic_aclr1 = "NONE",
                    altera_mult_add_component.systolic_sclr1 = "NONE",
                    altera_mult_add_component.systolic_delay3 = "UNREGISTERED",
                    altera_mult_add_component.systolic_aclr3 = "NONE",
                    altera_mult_add_component.systolic_sclr3 = "NONE",
                    altera_mult_add_component.latency = 0,
                    altera_mult_add_component.input_a0_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_a1_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_a2_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_a3_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_a0_latency_aclr = "NONE",
                    altera_mult_add_component.input_a1_latency_aclr = "NONE",
                    altera_mult_add_component.input_a2_latency_aclr = "NONE",
                    altera_mult_add_component.input_a3_latency_aclr = "NONE",
                    altera_mult_add_component.input_a0_latency_sclr = "NONE",
                    altera_mult_add_component.input_a1_latency_sclr = "NONE",
                    altera_mult_add_component.input_a2_latency_sclr = "NONE",
                    altera_mult_add_component.input_a3_latency_sclr = "NONE",
                    altera_mult_add_component.input_b0_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_b1_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_b2_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_b3_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_b0_latency_aclr = "NONE",
                    altera_mult_add_component.input_b1_latency_aclr = "NONE",
                    altera_mult_add_component.input_b2_latency_aclr = "NONE",
                    altera_mult_add_component.input_b3_latency_aclr = "NONE",
                    altera_mult_add_component.input_b0_latency_sclr = "NONE",
                    altera_mult_add_component.input_b1_latency_sclr = "NONE",
                    altera_mult_add_component.input_b2_latency_sclr = "NONE",
                    altera_mult_add_component.input_b3_latency_sclr = "NONE",
                    altera_mult_add_component.input_c0_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_c1_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_c2_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_c3_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.input_c0_latency_aclr = "NONE",
                    altera_mult_add_component.input_c1_latency_aclr = "NONE",
                    altera_mult_add_component.input_c2_latency_aclr = "NONE",
                    altera_mult_add_component.input_c3_latency_aclr = "NONE",
                    altera_mult_add_component.input_c0_latency_sclr = "NONE",
                    altera_mult_add_component.input_c1_latency_sclr = "NONE",
                    altera_mult_add_component.input_c2_latency_sclr = "NONE",
                    altera_mult_add_component.input_c3_latency_sclr = "NONE",
                    altera_mult_add_component.coefsel0_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.coefsel1_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.coefsel2_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.coefsel3_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.coefsel0_latency_aclr = "NONE",
                    altera_mult_add_component.coefsel1_latency_aclr = "NONE",
                    altera_mult_add_component.coefsel2_latency_aclr = "NONE",
                    altera_mult_add_component.coefsel3_latency_aclr = "NONE",
                    altera_mult_add_component.coefsel0_latency_sclr = "NONE",
                    altera_mult_add_component.coefsel1_latency_sclr = "NONE",
                    altera_mult_add_component.coefsel2_latency_sclr = "NONE",
                    altera_mult_add_component.coefsel3_latency_sclr = "NONE",
                    altera_mult_add_component.signed_latency_clock_a = "UNREGISTERED",
                    altera_mult_add_component.signed_latency_aclr_a = "NONE",
                    altera_mult_add_component.signed_latency_sclr_a = "NONE",
                    altera_mult_add_component.signed_latency_clock_b = "UNREGISTERED",
                    altera_mult_add_component.signed_latency_aclr_b = "NONE",
                    altera_mult_add_component.signed_latency_sclr_b = "NONE",
                    altera_mult_add_component.addnsub_multiplier_latency_clock1 = "UNREGISTERED",
                    altera_mult_add_component.addnsub_multiplier_latency_aclr1 = "NONE",
                    altera_mult_add_component.addnsub_multiplier_latency_sclr1 = "NONE",
                    altera_mult_add_component.addnsub_multiplier_latency_clock3 = "UNREGISTERED",
                    altera_mult_add_component.addnsub_multiplier_latency_aclr3 = "NONE",
                    altera_mult_add_component.addnsub_multiplier_latency_sclr3 = "NONE",
                    altera_mult_add_component.accum_sload_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.accum_sload_latency_aclr = "NONE",
                    altera_mult_add_component.accum_sload_latency_sclr = "NONE",
                    altera_mult_add_component.negate_latency_clock = "UNREGISTERED",
                    altera_mult_add_component.negate_latency_aclr = "NONE",
                    altera_mult_add_component.negate_latency_sclr = "NONE",
                    altera_mult_add_component.selected_device_family = "Cyclone V";


endmodule


//--------------------------------------------------------------------------
// Module Name     : altera_mult_add
//
// Description     : Main module for altera_mult_add component
//--------------------------------------------------------------------------
module altera_mult_add (
		dataa, 
		datab,
		datac,
		scanina,
		scaninb,
		sourcea,
		sourceb,
		clock3, 
		clock2, 
		clock1, 
		clock0, 
		aclr3, 
		aclr2, 
		aclr1, 
		aclr0, 
		sclr3, 
		sclr2, 
		sclr1, 
		sclr0,
		ena3, 
		ena2, 
		ena1, 
		ena0, 
		signa, 
		signb, 
		addnsub1, 
		addnsub3, 
		result, 
		scanouta, 
		scanoutb,
		mult01_round,
		mult23_round,
		mult01_saturation,
		mult23_saturation,
		addnsub1_round,
		addnsub3_round,
		mult0_is_saturated,
		mult1_is_saturated,
		mult2_is_saturated,
		mult3_is_saturated,
		output_round,
		chainout_round,
		output_saturate,
		chainout_saturate,
		overflow,
		chainout_sat_overflow,
		chainin,
		zero_chainout,
		rotate,
		shift_right,
		zero_loopback,
		accum_sload,
		sload_accum,
		negate,		
		coefsel0,
		coefsel1,
		coefsel2,
		coefsel3		
	);

	//==========================================================
	// altera_mult_add parameters declaration
	//==========================================================
	// general setting parameters
	parameter extra_latency                   = 0;
	parameter dedicated_multiplier_circuitry  = "AUTO";
	parameter dsp_block_balancing             = "AUTO";
	parameter selected_device_family          = "Stratix V";
	parameter lpm_type                        = "altera_mult_add";
	parameter lpm_hint                        = "UNUSED";
		
	// Input A related parameters
	parameter width_a  = 1;
	
	parameter input_register_a0  		= "UNREGISTERED";
	parameter input_aclr_a0      		= "NONE";
	parameter input_sclr_a0      		= "NONE"; //added for sclr support
	parameter input_source_a0    		= "DATAA";
	parameter input_register_a1 		= "UNREGISTERED";
	parameter input_aclr_a1      		= "NONE";
	parameter input_sclr_a1      		= "NONE";  //added for sclr support
	parameter input_source_a1    		= "DATAA";
	parameter input_register_a2  		= "UNREGISTERED";
	parameter input_aclr_a2      		= "NONE";
	parameter input_sclr_a2      		= "NONE";  //added for sclr support
	parameter input_source_a2    		= "DATAA";
	parameter input_register_a3  		= "UNREGISTERED";
	parameter input_aclr_a3      		= "NONE";
	parameter input_sclr_a3      		= "NONE";  //added for sclr support
	parameter input_source_a3    		= "DATAA";

	parameter input_a0_latency_clock  	= "UNREGISTERED";
	parameter input_a0_latency_aclr   	= "NONE";	
	parameter input_a0_latency_sclr   	= "NONE"; //added for sclr support	
	parameter input_a1_latency_clock  	= "UNREGISTERED";
	parameter input_a1_latency_aclr   	= "NONE";	
	parameter input_a1_latency_sclr  	 = "NONE"; //added for sclr support
	parameter input_a2_latency_clock  	= "UNREGISTERED";
	parameter input_a2_latency_aclr   	= "NONE";	
	parameter input_a2_latency_sclr   	= "NONE"; //added for sclr support	
	parameter input_a3_latency_clock  	= "UNREGISTERED";
	parameter input_a3_latency_aclr   	= "NONE";			
	parameter input_a3_latency_sclr   	= "NONE"; //added for sclr support
	
	// Input B related parameters 
	parameter width_b  = 1;
	
	parameter input_register_b0  		= "UNREGISTERED";
	parameter input_aclr_b0      		= "NONE";
	parameter input_sclr_b0      		= "NONE"; //added for sclr support
	parameter input_source_b0    		= "DATAB";
	parameter input_register_b1  		= "UNREGISTERED";
	parameter input_aclr_b1      		= "NONE";
	parameter input_sclr_b1      		= "NONE";  //added for sclr support
	parameter input_source_b1    		= "DATAB";
	parameter input_register_b2  		= "UNREGISTERED";
	parameter input_aclr_b2      		= "NONE";
	parameter input_sclr_b2      		= "NONE"; //added for sclr support
	parameter input_source_b2    		= "DATAB";
	parameter input_register_b3  		= "UNREGISTERED";
	parameter input_aclr_b3      		= "NONE";
	parameter input_sclr_b3      		= "NONE"; //added for sclr support
	parameter input_source_b3    		= "DATAB";
	
	parameter input_b0_latency_clock  	= "UNREGISTERED";
	parameter input_b0_latency_aclr   	= "NONE";	
	parameter input_b0_latency_sclr   	= "NONE";  //added for sclr support	
	parameter input_b1_latency_clock  	= "UNREGISTERED";
	parameter input_b1_latency_aclr   	= "NONE";	
	parameter input_b1_latency_sclr   	= "NONE"; //added for sclr support
	parameter input_b2_latency_clock  	= "UNREGISTERED";
	parameter input_b2_latency_aclr   	= "NONE";	
	parameter input_b2_latency_sclr   	= "NONE"; //added for sclr support
	parameter input_b3_latency_clock  	= "UNREGISTERED";
	parameter input_b3_latency_aclr   	= "NONE";
	parameter input_b3_latency_sclr		= "NONE";  //added for sclr support
		
	// Input C related parameters 
	parameter width_c  = 1;	
	parameter input_register_c0  		= "UNREGISTERED";
	parameter input_aclr_c0      		= "NONE";
	parameter input_sclr_c0      		= "NONE";  //added for sclr support	
	parameter input_register_c1  		= "UNREGISTERED";
	parameter input_aclr_c1      		= "NONE";
	parameter input_sclr_c1      		= "NONE"; //added for sclr support	
	parameter input_register_c2  		= "UNREGISTERED";
	parameter input_aclr_c2      		= "NONE";
	parameter input_sclr_c2      		= "NONE";  //added for sclr support	
	parameter input_register_c3  		= "UNREGISTERED";
	parameter input_aclr_c3      		= "NONE";
	parameter input_sclr_c3      		= "NONE"; //added for sclr support

	parameter input_c0_latency_clock  	= "UNREGISTERED";
	parameter input_c0_latency_aclr   	= "NONE";	
	parameter input_c0_latency_sclr  	= "NONE"; //added for sclr support	
	parameter input_c1_latency_clock 	= "UNREGISTERED";
	parameter input_c1_latency_aclr   	= "NONE";	
	parameter input_c1_latency_sclr   	= "NONE";  //added for sclr support	
	parameter input_c2_latency_clock  	= "UNREGISTERED";
	parameter input_c2_latency_aclr   	= "NONE";	
	parameter input_c2_latency_sclr   	= "NONE";  //added for sclr support	
	parameter input_c3_latency_clock	= "UNREGISTERED";
	parameter input_c3_latency_aclr		= "NONE";	
	parameter input_c3_latency_sclr		= "NONE";  //added for sclr support
 	
	// Output related parameters
	parameter width_result				= 34;
	parameter output_register			= "UNREGISTERED";
	parameter output_aclr				= "NONE";
	parameter output_sclr				= "NONE";  //added for sclr support
	
	// Signed related parameters
	parameter port_signa				= "PORT_UNUSED";
	parameter representation_a			= "UNSIGNED";	
	parameter signed_register_a         = "UNREGISTERED";
	parameter signed_aclr_a             = "NONE";
	parameter signed_sclr_a             = "NONE";  //added for sclr support
	parameter signed_latency_clock_a  	= "UNREGISTERED";
	parameter signed_latency_aclr_a     = "NONE";
	parameter signed_latency_sclr_a     = "NONE";  //added for sclr support
	
	parameter port_signb        		= "PORT_UNUSED";
	parameter representation_b  		= "UNSIGNED";	
	parameter signed_register_b         = "UNREGISTERED";
	parameter signed_aclr_b             = "NONE";
	parameter signed_sclr_b             = "NONE";  //added for sclr support
	parameter signed_latency_clock_b  	= "UNREGISTERED";
	parameter signed_latency_aclr_b     = "NONE";
	parameter signed_latency_sclr_b     = "NONE";  //added for sclr support
	
	// Multiplier related parameters
	parameter number_of_multipliers  	= 1;	
	parameter multiplier1_direction  	= "NONE";
	parameter multiplier3_direction  	= "NONE";
	
	parameter multiplier_register0  	= "UNREGISTERED";
	parameter multiplier_aclr0     		= "NONE";
	parameter multiplier_sclr0			= "NONE";  //added for sclr support
	parameter multiplier_register1  	= "UNREGISTERED";
	parameter multiplier_aclr1      	= "NONE";
	parameter multiplier_sclr1      	= "NONE";  //added for sclr support
	parameter multiplier_register2  	= "UNREGISTERED";
	parameter multiplier_aclr2      	= "NONE";
	parameter multiplier_sclr2      	= "NONE";  //added for sclr support
	parameter multiplier_register3  	= "UNREGISTERED";
	parameter multiplier_aclr3      	= "NONE";
	parameter multiplier_sclr3      	= "NONE";  //added for sclr support
		
	// Adder related parameters
	parameter port_addnsub1                     = "PORT_UNUSED";
	parameter addnsub_multiplier_register1      = "UNREGISTERED";
	parameter addnsub_multiplier_aclr1          = "NONE";	
	parameter addnsub_multiplier_sclr1          = "NONE";  //added for sclr support
	parameter addnsub_multiplier_latency_clock1 = "UNREGISTERED";
	parameter addnsub_multiplier_latency_aclr1  = "NONE";
	parameter addnsub_multiplier_latency_sclr1  = "NONE";  //added for sclr support
   
	parameter port_addnsub3                     = "PORT_UNUSED";
	parameter addnsub_multiplier_register3      = "UNREGISTERED";
	parameter addnsub_multiplier_aclr3	        = "NONE";
	parameter addnsub_multiplier_sclr3	        = "NONE"; //added for sclr support
	parameter addnsub_multiplier_latency_clock3 = "UNREGISTERED";
	parameter addnsub_multiplier_latency_aclr3  = "NONE";
	parameter addnsub_multiplier_latency_sclr3  = "NONE"; //added for sclr support
	parameter use_subnadd						= "NO";
	
	// Rounding related parameters
	parameter adder1_rounding                   = "NO";
	parameter addnsub1_round_register           = "UNREGISTERED";
	parameter addnsub1_round_aclr               = "NONE";
	parameter addnsub1_round_sclr               = "NONE";  //added for sclr support	
	parameter adder3_rounding                   = "NO";
	parameter addnsub3_round_register           = "UNREGISTERED";
	parameter addnsub3_round_aclr               = "NONE";
	parameter addnsub3_round_sclr               = "NONE";  //added for sclr support
	
	parameter multiplier01_rounding  			= "NO";
	parameter mult01_round_register  			= "UNREGISTERED";
	parameter mult01_round_aclr      			= "NONE";
	parameter mult01_round_sclr      			= "NONE";  //added for sclr support	
	parameter multiplier23_rounding  			= "NO";
	parameter mult23_round_register  			= "UNREGISTERED";
	parameter mult23_round_aclr      			= "NONE";
	parameter mult23_round_sclr      			= "NONE";  //added for sclr support
	
	parameter width_msb                       	= 17;
	
	parameter output_rounding                 	= "NO";
	parameter output_round_type               	= "NEAREST_INTEGER";
	parameter output_round_register           	= "UNREGISTERED";
	parameter output_round_aclr               	= "NONE";
	parameter output_round_sclr               	= "NONE"; //added for sclr support
	
	parameter chainout_rounding                 = "NO";
	parameter chainout_round_register           = "UNREGISTERED";
	parameter chainout_round_aclr               = "NONE";
	parameter chainout_round_sclr               = "NONE"; //added for sclr support
	parameter chainout_round_output_register    = "UNREGISTERED";
	parameter chainout_round_output_aclr        = "NONE";
	parameter chainout_round_output_sclr        = "NONE";  //added for sclr support
	
	
	// Saturation related parameters
	parameter multiplier01_saturation     		= "NO";
	parameter mult01_saturation_register  		= "UNREGISTERED";
	parameter mult01_saturation_aclr      		= "NONE";
	parameter mult01_saturation_sclr      		= "NONE";  //added for sclr support	
	parameter multiplier23_saturation     		= "NO";
	parameter mult23_saturation_register 		= "UNREGISTERED";
	parameter mult23_saturation_aclr      		= "NONE";
	parameter mult23_saturation_sclr      		= "NONE";  //added for sclr support	
	parameter port_mult0_is_saturated  			= "NONE";
	parameter port_mult1_is_saturated  			= "NONE";
	parameter port_mult2_is_saturated  			= "NONE";
	parameter port_mult3_is_saturated  			= "NONE";
	
	parameter width_saturate_sign = 1;
	
	parameter output_saturation                 = "NO";
	parameter port_output_is_overflow           = "PORT_UNUSED";
	parameter output_saturate_type              = "ASYMMETRIC";
	parameter output_saturate_register          = "UNREGISTERED";
	parameter output_saturate_aclr              = "NONE";
	parameter output_saturate_sclr              = "NONE"; //added for sclr support	
	parameter chainout_saturation               = "NO";
	parameter port_chainout_sat_is_overflow     = "PORT_UNUSED";
	parameter chainout_saturate_register        = "UNREGISTERED";
	parameter chainout_saturate_aclr            = "NONE";
	parameter chainout_saturate_sclr            = "NONE"; //added for sclr support
	parameter chainout_saturate_output_register = "UNREGISTERED";
	parameter chainout_saturate_output_aclr     = "NONE";
	parameter chainout_saturate_output_sclr     = "NONE";  //added for sclr support
	
	// Scanchain related parameters
	parameter scanouta_register  				= "UNREGISTERED";
	parameter scanouta_aclr      				= "NONE";
	parameter scanouta_sclr      				= "NONE"; //added for sclr support	
	// Chain (chainin and chainout) related parameters
	parameter width_chainin  = 1;	
	parameter chainout_adder     			= "NO";
	parameter chainout_adder_direction     	= "ADD";	
	parameter chainout_register  			= "UNREGISTERED";
	parameter chainout_aclr      			= "NONE";
	parameter chainout_sclr      			= "NONE";  //added for sclr support
 	parameter port_negate		 			= "PORT_UNUSED";
	parameter negate_register 	 			= "UNREGISTERED";
	parameter negate_aclr 	     			= "NONE";
	parameter negate_sclr 	     			= "NONE"; //added for sclr support
	parameter negate_latency_clock 	 		= "UNREGISTERED";
	parameter negate_latency_aclr	 		= "NONE";
	parameter negate_latency_sclr	 		= "NONE";  //added for sclr support	
	parameter zero_chainout_output_register = "UNREGISTERED";
	parameter zero_chainout_output_aclr     = "NONE";
	parameter zero_chainout_output_sclr     = "NONE"; //added for sclr support
		
	// Rotate & shift related parameters
	parameter shift_mode  = "NO";	
	parameter rotate_register           	= "UNREGISTERED";
	parameter rotate_aclr               	= "NONE";
	parameter rotate_sclr               	= "NONE"; //added for sclr support
	parameter rotate_output_register    	= "UNREGISTERED";
	parameter rotate_output_aclr        	= "NONE";
	parameter rotate_output_sclr        	= "NONE";  //added for sclr support	
	parameter shift_right_register          = "UNREGISTERED";
	parameter shift_right_aclr              = "NONE";
	parameter shift_right_sclr              = "NONE"; //added for sclr support
	parameter shift_right_output_register   = "UNREGISTERED";
	parameter shift_right_output_aclr       = "NONE";
	parameter shift_right_output_sclr       = "NONE";  //added for sclr support
	
	// Loopback related parameters
	parameter zero_loopback_register        = "UNREGISTERED";
	parameter zero_loopback_aclr            = "NONE";
	parameter zero_loopback_sclr            = "NONE"; //added for sclr support
	parameter zero_loopback_output_register = "UNREGISTERED";
	parameter zero_loopback_output_aclr     = "NONE";
	parameter zero_loopback_output_sclr     = "NONE";  //added for sclr support	
	
	// Accumulator and loadconst related parameters
	parameter accumulator      				= "NO";
	parameter accum_direction  				= "ADD";
	parameter loadconst_value 				= 0;
	parameter use_sload_accum_port 			= "NO";	
	parameter accum_sload_register     		= "UNREGISTERED";
	parameter accum_sload_aclr         		= "NONE";
	parameter accum_sload_latency_clock  	= "UNREGISTERED";
	parameter accum_sload_latency_aclr      = "NONE";
	//Added for sclr
	parameter accum_sload_latency_sclr      = "NONE";
	parameter accum_sload_sclr         		= "NONE";	
	parameter loadconst_control_register 	= "UNREGISTERED";
	parameter loadconst_control_aclr	 	= "NONE";
	parameter loadconst_control_sclr	 	= "NONE";  //added for sclr support
	parameter double_accum      			= "NO";
	
	// Systolic related parameters
	parameter systolic_delay1 				= "UNREGISTERED";
	parameter systolic_delay3 				= "UNREGISTERED";
	parameter systolic_aclr1 				= "NONE";
	parameter systolic_aclr3				= "NONE";
	parameter systolic_sclr1 				= "NONE";  //added for sclr support
	parameter systolic_sclr3				= "NONE";  //added for sclr support
	
	// Preadder related parameters
	parameter preadder_mode  				= "SIMPLE";
	
	parameter preadder_direction_0  		= "ADD";
	parameter preadder_direction_1  		= "ADD";
	parameter preadder_direction_2  		= "ADD";
	parameter preadder_direction_3  		= "ADD";
	
	parameter width_coef  = 1;	
	parameter coefsel0_register  			= "UNREGISTERED";
	parameter coefsel0_aclr	     			= "NONE";
	parameter coefsel0_sclr	     			= "NONE";  //added for sclr support
	parameter coefsel1_register  			= "UNREGISTERED";
	parameter coefsel1_aclr	     			= "NONE";
	parameter coefsel1_sclr	     			= "NONE"; //added for sclr support
	parameter coefsel2_register  			= "UNREGISTERED";
	parameter coefsel2_aclr	     			= "NONE";
	parameter coefsel2_sclr	     			= "NONE"; //added for sclr support
	parameter coefsel3_register  			= "UNREGISTERED";
	parameter coefsel3_aclr	     			= "NONE";
	parameter coefsel3_sclr	     			= "NONE";  //added for sclr support

	parameter coef0_0  = 0;
	parameter coef0_1  = 0;
	parameter coef0_2  = 0;
	parameter coef0_3  = 0;
	parameter coef0_4  = 0;
	parameter coef0_5  = 0;
	parameter coef0_6  = 0;
	parameter coef0_7  = 0;

	parameter coef1_0  = 0;
	parameter coef1_1  = 0;
	parameter coef1_2  = 0;
	parameter coef1_3  = 0;
	parameter coef1_4  = 0;
	parameter coef1_5  = 0;
	parameter coef1_6  = 0;
	parameter coef1_7  = 0;

	parameter coef2_0  = 0;
	parameter coef2_1  = 0;
	parameter coef2_2  = 0;
	parameter coef2_3  = 0;
	parameter coef2_4  = 0;
	parameter coef2_5  = 0;
	parameter coef2_6  = 0;
	parameter coef2_7  = 0;

	parameter coef3_0  = 0;
	parameter coef3_1  = 0;
	parameter coef3_2  = 0;
	parameter coef3_3  = 0;
	parameter coef3_4  = 0;
	parameter coef3_5  = 0;
	parameter coef3_6  = 0;
	parameter coef3_7  = 0;	
	
	parameter coefsel0_latency_clock  		= "UNREGISTERED";
	parameter coefsel0_latency_aclr	  		= "NONE";
	parameter coefsel0_latency_sclr	  		= "NONE";  //added for sclr support
	parameter coefsel1_latency_clock  		= "UNREGISTERED";
	parameter coefsel1_latency_aclr	  		= "NONE";
	parameter coefsel1_latency_sclr	  		= "NONE"; //added for sclr support
	parameter coefsel2_latency_clock  		= "UNREGISTERED";
	parameter coefsel2_latency_aclr	  		= "NONE";
	parameter coefsel2_latency_sclr	  		= "NONE";  //added for sclr support
	parameter coefsel3_latency_clock  		= "UNREGISTERED";
	parameter coefsel3_latency_aclr	  		= "NONE";
	parameter coefsel3_latency_sclr	  		= "NONE";  //added for sclr support
	
	// Latency delay
	parameter latency = 0;

	//==================================================================================
	// Legacy pipeline register's parameters, keep for backward compatibility (DO NOT REMOVE)
	//==================================================================================
	parameter signed_pipeline_register_a  			= "UNREGISTERED";
	parameter signed_pipeline_aclr_a      			= "NONE";
	parameter signed_pipeline_register_b  			= "UNREGISTERED";
	parameter signed_pipeline_aclr_b      			= "NONE";	
	parameter addnsub_multiplier_pipeline_register1 = "UNREGISTERED";
	parameter addnsub_multiplier_pipeline_aclr1     = "NONE";
	parameter addnsub_multiplier_pipeline_register3 = "UNREGISTERED";
	parameter addnsub_multiplier_pipeline_aclr3     = "NONE";
	parameter addnsub1_round_pipeline_register  	= "UNREGISTERED";
	parameter addnsub1_round_pipeline_aclr      	= "NONE";
	parameter addnsub3_round_pipeline_register  	= "UNREGISTERED";
	parameter addnsub3_round_pipeline_aclr		  	= "NONE";
	parameter output_round_pipeline_register  		= "UNREGISTERED";
	parameter output_round_pipeline_aclr      		= "NONE";
	parameter chainout_round_pipeline_register  	= "UNREGISTERED";
	parameter chainout_round_pipeline_aclr      	= "NONE";
	parameter output_saturate_pipeline_register  	= "UNREGISTERED";
	parameter output_saturate_pipeline_aclr      	= "NONE";
	parameter chainout_saturate_pipeline_register  = "UNREGISTERED";
	parameter chainout_saturate_pipeline_aclr      = "NONE";
	parameter rotate_pipeline_register  			= "UNREGISTERED";
	parameter rotate_pipeline_aclr      			= "NONE";
	parameter shift_right_pipeline_register  		= "UNREGISTERED";
	parameter shift_right_pipeline_aclr      		= "NONE";
	parameter zero_loopback_pipeline_register  		= "UNREGISTERED";
	parameter zero_loopback_pipeline_aclr      		= "NONE";
	parameter zero_loopback_pipeline_sclr      		= "NONE";  //added for sclr support
	parameter accum_sload_pipeline_register  		= "UNREGISTERED";
	parameter accum_sload_pipeline_aclr      		= "NONE";
	//sclr support
	parameter addnsub1_round_pipeline_sclr      	= "NONE";  
	parameter addnsub3_round_pipeline_sclr			= "NONE";
	parameter chainout_round_pipeline_sclr      	= "NONE";
	parameter chainout_saturate_pipeline_sclr   	= "NONE";
	parameter output_round_pipeline_sclr      		= "NONE";
	parameter output_saturate_pipeline_sclr     	= "NONE";
	parameter rotate_pipeline_sclr      			= "NONE";
	parameter shift_right_pipeline_sclr      		= "NONE";
	
	
	
	//==========================================================
	// Internal parameters declaration
	//==========================================================
	// Width related parameters
		// Register related width parameters
		parameter width_clock_all_wire_msb = 3;   // Clock wire total width
		parameter width_aclr_all_wire_msb = 3;    // Aclr wire total width
		parameter width_ena_all_wire_msb = 3;     // Clock enable wire total width
		parameter width_sclr_all_wire_msb = 3;    // Sclr wire total width
		
		// Data input width related parameters
		parameter width_a_total_msb  = (width_a * number_of_multipliers) - 1;   // Total width of dataa input
		parameter width_a_msb  = width_a - 1;     // MSB for splited dataa width
		
		parameter width_b_total_msb  = (width_b * number_of_multipliers) - 1;   // Total width of data input
		parameter width_b_msb  = width_b - 1;     // MSB for splited datab width
		
		parameter width_c_total_msb  = (width_c * number_of_multipliers) - 1;   // Total width of datac input
		parameter width_c_msb  = width_c - 1;     // MSB for splited datac width

		// Scanchain width related parameters
		parameter width_scanina = width_a;                  // Width for scanina port
		parameter width_scanina_msb = width_scanina - 1;    // MSB for scanina port
		
		parameter width_scaninb = width_b;                  // Width for scaninb port
		parameter width_scaninb_msb = width_scaninb - 1;    // MSB for scaninb port
		
		parameter width_sourcea_msb = number_of_multipliers -1;    // MSB for sourcea port
		parameter width_sourceb_msb = number_of_multipliers -1;    // MSB for sourceb port
		
		parameter width_scanouta_msb = width_a -1;    // MSB for scanouta port
		parameter width_scanoutb_msb = width_b -1;    // MSB for scanoutb port

		// chain (chainin and chainout) width related parameters
		parameter width_chainin_msb = width_chainin - 1;    // MSB for chainin port
		
		// Result width related parameters
		parameter width_result_msb = width_result - 1;      // MSB for result port
		
		// Coef width related parameters
		parameter width_coef_msb = width_coef -1;           // MSB for selected coef output
	
	
	// Internal width related parameters
		// Input data width related parameters
		parameter dataa_split_ext_require = (port_signa === "PORT_USED") ? 1 : 0;        // Determine dynamic sign extension 
		parameter dataa_port_sign = port_signa;                                          // Dynamic sign port for dataa
		parameter width_a_ext = (dataa_split_ext_require == 1) ? width_a + 1 : width_a ; // Sign extension when require
		parameter width_a_ext_msb = width_a_ext - 1;                                     // MSB for dataa
		
		parameter datab_split_ext_require = (preadder_mode === "SIMPLE") ? ((port_signb === "PORT_USED") ? 1 : 0):
		                                                                   ((port_signa === "PORT_USED") ? 1 : 0) ;   // Determine dynamic sign extension 
		parameter datab_port_sign = (preadder_mode === "SIMPLE") ? port_signb : port_signa;    // Dynamic sign port for dataa
		parameter width_b_ext = (datab_split_ext_require == 1) ? width_b + 1 : width_b;        // Sign extension when require
		parameter width_b_ext_msb = width_b_ext - 1;                                           // MSB for datab
		
		parameter coef_ext_require = (port_signb === "PORT_USED") ? 1 : 0;                // Determine dynamic sign extension 
		parameter coef_port_sign  = port_signb;                                           // Dynamic sign port for coef
		parameter width_coef_ext = (coef_ext_require == 1) ? width_coef + 1 : width_coef; // Sign extension when require
		parameter width_coef_ext_msb = width_coef_ext - 1;                                // MSB for coef
		
		parameter datac_split_ext_require = (port_signb === "PORT_USED") ? 1 : 0;        // Determine dynamic sign extension 
		parameter datac_port_sign = port_signb;                                          // Dynamic sign port for datac
		parameter width_c_ext = (datac_split_ext_require == 1) ? width_c + 1 : width_c;  // Sign extension when require
		parameter width_c_ext_msb = width_c_ext - 1;                                     // MSB for datac
		
		
		// Scanchain width related parameters
		parameter width_scanchain = (port_signa === "PORT_USED") ? width_scanina + 1 : width_scanina;  // Sign extension when require
		parameter width_scanchain_msb = width_scanchain - 1;
		parameter scanchain_port_sign = port_signa;                                      // Dynamic sign port for scanchain
		
		
		// Preadder width related parameters
		parameter preadder_representation = (port_signa === "PORT_USED") ? "SIGNED" : representation_a;   // Representation for preadder adder
		
		parameter width_preadder_input_a = (input_source_a0 === "SCANA")? width_scanchain : width_a_ext;   // Preadder input a selection width
		parameter width_preadder_input_a_msb = width_preadder_input_a - 1;                                      // MSB for preadder input a
		
		parameter width_preadder_adder_result = (width_preadder_input_a > width_b_ext)? width_preadder_input_a + 1 : width_b_ext + 1; // Adder extension by one for the largest width
		
		parameter width_preadder_output_a = (preadder_mode === "INPUT" || preadder_mode === "SQUARE" || preadder_mode === "COEF")? width_preadder_adder_result:
		                                     width_preadder_input_a;              // Preadder first output width
		parameter width_preadder_output_a_msb = width_preadder_output_a - 1;      // MSB for preadder first output width
		
		parameter width_preadder_output_b = (preadder_mode === "INPUT")? width_c_ext :
		                                    (preadder_mode === "SQUARE")? width_preadder_adder_result :
		                                    (preadder_mode === "COEF" || preadder_mode === "CONSTANT")? width_coef_ext :
														width_b_ext;                         // Preadder second output width
		parameter width_preadder_output_b_msb = width_preadder_output_b - 1;     // MSB for preadder second output width
		
		
		// Multiplier width related parameters
		parameter multiplier_input_representation_a = (port_signa === "PORT_USED") ? "SIGNED" : representation_a;   // Representation for multiplier first input
		parameter multiplier_input_representation_b = (preadder_mode === "SQUARE") ? multiplier_input_representation_a :
		                                              (port_signb === "PORT_USED") ? "SIGNED" : representation_b;   // Representation for multiplier second input
		
		parameter width_mult_source_a = width_preadder_output_a;        // Multiplier first input width
		parameter width_mult_source_a_msb = width_mult_source_a - 1;    // MSB for multiplier first input width
		
		parameter width_mult_source_b = width_preadder_output_b;        // Multiplier second input width
		parameter width_mult_source_b_msb = width_mult_source_b - 1;    // MSB for multiplier second input width
		
		parameter width_mult_result = width_mult_source_a + width_mult_source_b +
		                              ((multiplier_input_representation_a === "UNSIGNED") ? 1 : 0) +
		                              ((multiplier_input_representation_b === "UNSIGNED") ? 1 : 0);   // Multiplier result width
		parameter width_mult_result_msb = width_mult_result -1;                                       // MSB for multiplier result width
		
		
		// Adder width related parameters
		parameter width_adder_source = width_mult_result;             // Final adder or systolic adder source width
		parameter width_adder_source_msb = width_adder_source - 1;    // MSB for adder source width
		
		parameter width_adder_result = width_adder_source + ((number_of_multipliers <= 2)? 1 : 2);  // Adder extension (2 when excute two level adder, else 1) and sign extension
		parameter width_adder_result_msb = width_adder_result - 1;                                  // MSB for adder result
		
		
		// Chainout adder width related parameters
		parameter width_chainin_ext = width_result - width_chainin;
		
		// Original output width related parameters
		parameter width_original_result = width_adder_result;               // The original result width without truncated
		parameter width_original_result_msb = width_original_result - 1;    // The MSB for original result 
		
		// Output width related parameters
		parameter result_ext_width    = (width_result_msb > width_original_result_msb) ? width_result_msb - width_original_result_msb : 1;   // Width that require to extend
		
		parameter width_result_output = (width_result_msb > width_original_result_msb) ? width_result : width_original_result + 1;   // Output width that ready for truncated
		parameter width_result_output_msb = width_result_output - 1;    // MSB for output width that ready for truncated
		
	//==========================================================
	// Port declaration
	//==========================================================
	// Data input related ports
	input [width_a_total_msb : 0] dataa;
	input [width_b_total_msb : 0] datab;
	input [width_c_total_msb : 0] datac;
	
	// Scanchain related ports
	input [width_scanina_msb : 0] scanina;
	input [width_scaninb_msb : 0] scaninb;
	input [width_sourcea_msb : 0] sourcea;
	input [width_sourceb_msb : 0] sourceb;
	
	output [width_scanouta_msb : 0] scanouta;
	output [width_scanoutb_msb : 0] scanoutb;
	
	// Clock related ports
	input clock0, clock1, clock2, clock3;	
	// Clear related ports
	input aclr0, aclr1, aclr2, aclr3;	
	// Synchronous Clear related ports (Added SCLR)
	input sclr0, sclr1, sclr2, sclr3;	
	// Clock enable related ports
	input ena0, ena1, ena2, ena3;
	
	// Signals control related ports
	input signa, signb;
	input addnsub1, addnsub3;
	
	// Rounding related ports
	input mult01_round, mult23_round;
	input addnsub1_round, addnsub3_round;
	input output_round;
	input chainout_round;
	
	// Saturation related ports
	input mult01_saturation, mult23_saturation;
	input output_saturate;
	input chainout_saturate;
	
	output mult0_is_saturated, mult1_is_saturated, mult2_is_saturated, mult3_is_saturated;
	output chainout_sat_overflow;
	
	// chain (chainin and chainout) related port
	input [width_chainin_msb : 0] chainin;
	input zero_chainout;
	input negate;
	
	// Rotate & shift related port
	input rotate;
	input shift_right;
	
	// Loopback related port
	input zero_loopback;
	
	// Accumulator related port
	input accum_sload;
	input sload_accum;	
	
	// Preadder related port
	input [2 : 0] coefsel0, coefsel1, coefsel2, coefsel3;
	
	// Output related port
	output [width_result_msb : 0] result;
	output overflow;
	
altera_mult_add_rtl #(
	.extra_latency(extra_latency),
	.dedicated_multiplier_circuitry(dedicated_multiplier_circuitry),
	.dsp_block_balancing(dsp_block_balancing),
	.selected_device_family(selected_device_family),
	.lpm_type(lpm_type),
	.lpm_hint(lpm_hint),
	.width_a(width_a),
	.input_register_a0(input_register_a0),
	.input_aclr_a0(input_aclr_a0),
	.input_sclr_a0(input_sclr_a0), //added for sclr support
	.input_source_a0(input_source_a0),
	.input_register_a1(input_register_a1),
	.input_aclr_a1(input_aclr_a1),
	.input_sclr_a1(input_sclr_a1),  //added for sclr support
	.input_source_a1(input_source_a1),
	.input_register_a2(input_register_a2),
	.input_aclr_a2(input_aclr_a2),
	.input_sclr_a2(input_sclr_a2), //added for sclr support
	.input_source_a2(input_source_a2),
	.input_register_a3(input_register_a3),
	.input_aclr_a3(input_aclr_a3),
	.input_sclr_a3(input_sclr_a3),  //added for sclr support
	.input_source_a3(input_source_a3),
	.width_b(width_b),
	.input_register_b0(input_register_b0),
	.input_aclr_b0(input_aclr_b0),
	.input_sclr_b0(input_sclr_b0), //added for sclr support
	.input_source_b0(input_source_b0),
	.input_register_b1(input_register_b1),
	.input_aclr_b1(input_aclr_b1),
	.input_sclr_b1(input_sclr_b1),  //added for sclr support
	.input_source_b1(input_source_b1),
	.input_register_b2(input_register_b2),
	.input_aclr_b2(input_aclr_b2),
	.input_sclr_b2(input_sclr_b2),  //added for sclr support
	.input_source_b2(input_source_b2),
	.input_register_b3(input_register_b3),
	.input_aclr_b3(input_aclr_b3),
	.input_sclr_b3(input_sclr_b3),  //added for sclr support
	.input_source_b3(input_source_b3),
	.width_c(width_c),
	.input_register_c0(input_register_c0),
	.input_aclr_c0(input_aclr_c0),
	.input_sclr_c0(input_sclr_c0),  //added for sclr support
	.input_register_c1(input_register_c1),
	.input_aclr_c1(input_aclr_c1),
	.input_sclr_c1(input_sclr_c1), //added for sclr support
	.input_register_c2(input_register_c2),
	.input_aclr_c2(input_aclr_c2),
	.input_sclr_c2(input_sclr_c2), //added for sclr support
	.input_register_c3(input_register_c3),
	.input_aclr_c3(input_aclr_c3),
	.input_sclr_c3(input_sclr_c3),  //added for sclr support
	.width_result(width_result),
	.output_register(output_register),
	.output_aclr(output_aclr),
	.output_sclr(output_sclr),  //added for sclr support
	.port_signa(port_signa),
	.representation_a(representation_a),
	.signed_register_a(signed_register_a),
	.signed_aclr_a(signed_aclr_a),
	.signed_sclr_a(signed_sclr_a),  //added for sclr support
	.signed_pipeline_register_a(signed_pipeline_register_a),
	.signed_pipeline_aclr_a(signed_pipeline_aclr_a),
	.port_signb(port_signb),
	.representation_b(representation_b),
	.signed_register_b(signed_register_b),
	.signed_aclr_b(signed_aclr_b),
	.signed_sclr_b(signed_sclr_b), //added for sclr support
	.signed_pipeline_register_b(signed_pipeline_register_b),
	.signed_pipeline_aclr_b(signed_pipeline_aclr_b),
	.number_of_multipliers(number_of_multipliers),
	.multiplier1_direction(multiplier1_direction),
	.multiplier3_direction(multiplier3_direction),
	.multiplier_register0(multiplier_register0),	
	.multiplier_aclr0(multiplier_aclr0),
	.multiplier_sclr0(multiplier_sclr0),  //added for sclr support
	.multiplier_register1(multiplier_register1),
	.multiplier_aclr1(multiplier_aclr1),
	.multiplier_sclr1(multiplier_sclr1), //added for sclr support
	.multiplier_register2(multiplier_register2),
	.multiplier_aclr2(multiplier_aclr2),
	.multiplier_sclr2(multiplier_sclr2),  //added for sclr support
	.multiplier_register3(multiplier_register3),
	.multiplier_aclr3(multiplier_aclr3),
	.multiplier_sclr3(multiplier_sclr3),  //added for sclr support
	.port_addnsub1(port_addnsub1),
	.addnsub_multiplier_register1 (addnsub_multiplier_register1),
	.addnsub_multiplier_aclr1(addnsub_multiplier_aclr1),
	.addnsub_multiplier_sclr1(addnsub_multiplier_sclr1),	//added for sclr support
	.addnsub_multiplier_pipeline_register1(addnsub_multiplier_pipeline_register1),
	.addnsub_multiplier_pipeline_aclr1(addnsub_multiplier_pipeline_aclr1),
	//.addnsub_multiplier_pipeline_sclr1(addnsub_multiplier_pipeline_sclr1),//added for sclr support
	.port_addnsub3(port_addnsub3),
	.addnsub_multiplier_register3(addnsub_multiplier_register3),
	.addnsub_multiplier_aclr3(addnsub_multiplier_aclr3),
	.addnsub_multiplier_sclr3(addnsub_multiplier_sclr3), //added for sclr support
	.addnsub_multiplier_pipeline_register3(addnsub_multiplier_pipeline_register3),
	.addnsub_multiplier_pipeline_aclr3(addnsub_multiplier_pipeline_aclr3),
	//.addnsub_multiplier_pipeline_sclr3(addnsub_multiplier_pipeline_sclr3),//added for sclr support
	.adder1_rounding(adder1_rounding),
	.addnsub1_round_register(addnsub1_round_register),
	.addnsub1_round_aclr(addnsub1_round_aclr),
	.addnsub1_round_sclr(addnsub1_round_sclr), //added for sclr support
	.addnsub1_round_pipeline_register(addnsub1_round_pipeline_register),
	.addnsub1_round_pipeline_aclr(addnsub1_round_pipeline_aclr),
	.addnsub1_round_pipeline_sclr(addnsub1_round_pipeline_sclr), //added for sclr support	
	.adder3_rounding(adder3_rounding),
	.addnsub3_round_register(addnsub3_round_register),
	.addnsub3_round_aclr(addnsub3_round_aclr),
	.addnsub3_round_sclr(addnsub3_round_sclr),  //added for sclr support
	.addnsub3_round_pipeline_register(addnsub3_round_pipeline_register),
	.addnsub3_round_pipeline_aclr(addnsub3_round_pipeline_aclr),
	.addnsub3_round_pipeline_sclr(addnsub3_round_pipeline_sclr), //added for sclr support
	.multiplier01_rounding(multiplier01_rounding),
	.mult01_round_register(mult01_round_register),
	.mult01_round_aclr(mult01_round_aclr),
	.mult01_round_sclr(mult01_round_sclr), //added for sclr support
	.multiplier23_rounding(multiplier23_rounding),
	.mult23_round_register(mult23_round_register),
	.mult23_round_aclr(mult23_round_aclr),
	.mult23_round_sclr(mult23_round_sclr), //added for sclr support
	.width_msb(width_msb),	
	.output_rounding(output_rounding),
	.output_round_type(output_round_type),
	.output_round_register(output_round_register),
	.output_round_aclr(output_round_aclr),
	.output_round_sclr(output_round_sclr),  //added for sclr support
	.output_round_pipeline_register(output_round_pipeline_register),
	.output_round_pipeline_aclr(output_round_pipeline_aclr),
	.output_round_pipeline_sclr(output_round_pipeline_sclr),  //added for sclr support
	.chainout_rounding(chainout_rounding),
	.chainout_round_register(chainout_round_register),
	.chainout_round_aclr(chainout_round_aclr),
	.chainout_round_sclr(chainout_round_sclr), //added for sclr support
	.chainout_round_pipeline_register(chainout_round_pipeline_register),
	.chainout_round_pipeline_aclr(chainout_round_pipeline_aclr),
	.chainout_round_pipeline_sclr(chainout_round_pipeline_sclr), //added for sclr support
	.chainout_round_output_register (chainout_round_output_register),
	.chainout_round_output_aclr (chainout_round_output_aclr),
	.chainout_round_output_sclr (chainout_round_output_sclr), //added for sclr support
	.multiplier01_saturation(multiplier01_saturation),
	.mult01_saturation_register(mult01_saturation_register),
	.mult01_saturation_aclr(mult01_saturation_aclr),
	.mult01_saturation_sclr(mult01_saturation_sclr),  //added for sclr support
	.multiplier23_saturation(multiplier23_saturation),
	.mult23_saturation_register(mult23_saturation_register),
	.mult23_saturation_aclr(mult23_saturation_aclr),
	.mult23_saturation_sclr(mult23_saturation_sclr), //added for sclr support
	.port_mult0_is_saturated(port_mult0_is_saturated),
	.port_mult1_is_saturated(port_mult1_is_saturated),
	.port_mult2_is_saturated(port_mult2_is_saturated),
	.port_mult3_is_saturated(port_mult3_is_saturated),
	.width_saturate_sign(width_saturate_sign),	
	.output_saturation(output_saturation),
	.port_output_is_overflow(port_output_is_overflow),
	.output_saturate_type(output_saturate_type),
	.output_saturate_register(output_saturate_register),
	.output_saturate_aclr(output_saturate_aclr),
	.output_saturate_sclr(output_saturate_sclr),  //added for sclr support
	.output_saturate_pipeline_register(output_saturate_pipeline_register),
	.output_saturate_pipeline_aclr(output_saturate_pipeline_aclr),
	.output_saturate_pipeline_sclr(output_saturate_pipeline_sclr), //added for sclr support
	.chainout_saturation(chainout_saturation),
	.port_chainout_sat_is_overflow(port_chainout_sat_is_overflow),
	.chainout_saturate_register(chainout_saturate_register),
	.chainout_saturate_aclr(chainout_saturate_aclr),
	.chainout_saturate_sclr(chainout_saturate_sclr), //added for sclr support
	.chainout_saturate_pipeline_register(chainout_saturate_pipeline_register),
	.chainout_saturate_pipeline_aclr(chainout_saturate_pipeline_aclr),
	.chainout_saturate_pipeline_sclr(chainout_saturate_pipeline_sclr), //added for sclr support
	.chainout_saturate_output_register(chainout_saturate_output_register),
	.chainout_saturate_output_aclr(chainout_saturate_output_aclr),
	.chainout_saturate_output_sclr(chainout_saturate_output_sclr), //added for sclr support
	.scanouta_register(scanouta_register),
	.scanouta_aclr(scanouta_aclr),
	.scanouta_sclr(scanouta_sclr),  //added for sclr support
	.width_chainin(width_chainin),
	.chainout_adder(chainout_adder),
	.chainout_register(chainout_register),
	.chainout_aclr(chainout_aclr),
	.chainout_sclr(chainout_sclr), //added for sclr support
	.port_negate(port_negate),
	.negate_register(negate_register),
	.negate_aclr(negate_aclr),
	.negate_sclr(negate_sclr),  //added for sclr support
	.negate_latency_clock(negate_latency_clock),
	.negate_latency_aclr(negate_latency_aclr),
	.negate_latency_sclr(negate_latency_sclr),  //added for sclr support		
	.zero_chainout_output_register(zero_chainout_output_register),
	.zero_chainout_output_aclr(zero_chainout_output_aclr),
	.zero_chainout_output_sclr(zero_chainout_output_sclr), //added for sclr support
	.shift_mode(shift_mode),
	.rotate_register(rotate_register),
	.rotate_aclr(rotate_aclr),
	.rotate_sclr(rotate_sclr),  //added for sclr support
	.rotate_pipeline_register(rotate_pipeline_register),
	.rotate_pipeline_aclr(rotate_pipeline_aclr),
	.rotate_pipeline_sclr(rotate_pipeline_sclr),  //added for sclr support
	.rotate_output_register(rotate_output_register),
	.rotate_output_aclr(rotate_output_aclr),
	.rotate_output_sclr(rotate_output_sclr),  //added for sclr support
	.shift_right_register(shift_right_register),
	.shift_right_aclr(shift_right_aclr),
	.shift_right_sclr(shift_right_sclr), //added for sclr support
	.shift_right_pipeline_register(shift_right_pipeline_register),
	.shift_right_pipeline_aclr(shift_right_pipeline_aclr),
	.shift_right_pipeline_sclr(shift_right_pipeline_sclr),
	.shift_right_output_register(shift_right_output_register),
	.shift_right_output_aclr(shift_right_output_aclr),
	.shift_right_output_sclr(shift_right_output_sclr), //added for sclr support
	.zero_loopback_register(zero_loopback_register),
	.zero_loopback_aclr(zero_loopback_aclr),
	.zero_loopback_sclr(zero_loopback_sclr),  //added for sclr support
	.zero_loopback_pipeline_register(zero_loopback_pipeline_register),
	.zero_loopback_pipeline_aclr(zero_loopback_pipeline_aclr),
	.zero_loopback_pipeline_sclr(zero_loopback_pipeline_sclr),  //added for sclr support
	.zero_loopback_output_register(zero_loopback_output_register),
	.zero_loopback_output_aclr(zero_loopback_output_aclr),
	.zero_loopback_output_sclr(zero_loopback_output_sclr),  //added for sclr support
	.accumulator(accumulator),
	.accum_direction(accum_direction),
	.chainout_adder_direction(chainout_adder_direction), 
	.loadconst_value (loadconst_value),
	.use_sload_accum_port (use_sload_accum_port),
	.use_subnadd(use_subnadd),
	.accum_sload_register(accum_sload_register),
	.accum_sload_aclr (accum_sload_aclr),
	.accum_sload_sclr (accum_sload_sclr),  //added for sclr support
	.accum_sload_pipeline_register(accum_sload_pipeline_register),
	.accum_sload_pipeline_aclr(accum_sload_pipeline_aclr),
	.loadconst_control_register(loadconst_control_register),
	.loadconst_control_aclr(loadconst_control_aclr),
	.loadconst_control_sclr(loadconst_control_sclr),  //added for sclr support
	.double_accum(double_accum),
	.systolic_delay1(systolic_delay1),
	.systolic_delay3(systolic_delay3),
	.systolic_aclr1(systolic_aclr1),
	.systolic_aclr3(systolic_aclr3),
	.systolic_sclr1(systolic_sclr1),  //added for sclr support
	.systolic_sclr3(systolic_sclr3),  //added for sclr support
	.preadder_mode(preadder_mode),
	.preadder_direction_0(preadder_direction_0),
	.preadder_direction_1(preadder_direction_1),
	.preadder_direction_2(preadder_direction_2),
	.preadder_direction_3(preadder_direction_3),
	.width_coef(width_coef),
	.coefsel0_register(coefsel0_register),
	.coefsel0_aclr(coefsel0_aclr),
	.coefsel0_sclr(coefsel0_sclr), //added for sclr support
	.coefsel1_register(coefsel1_register),
	.coefsel1_aclr(coefsel1_aclr),
	.coefsel1_sclr(coefsel1_sclr), //added for sclr support
	.coefsel2_register(coefsel2_register),
	.coefsel2_aclr(coefsel2_aclr),
	.coefsel2_sclr(coefsel2_sclr), //added for sclr support
	.coefsel3_register(coefsel3_register),
	.coefsel3_aclr(coefsel3_aclr),
	.coefsel3_sclr(coefsel3_sclr),  //added for sclr support
	.coef0_0(coef0_0),
	.coef0_1(coef0_1),
	.coef0_2(coef0_2),
	.coef0_3(coef0_3),
	.coef0_4(coef0_4),
	.coef0_5(coef0_5),
	.coef0_6(coef0_6),
	.coef0_7(coef0_7),
	.coef1_0(coef1_0),
	.coef1_1(coef1_1),
	.coef1_2(coef1_2),
	.coef1_3(coef1_3),
	.coef1_4(coef1_4),
	.coef1_5(coef1_5),
	.coef1_6(coef1_6),
	.coef1_7(coef1_7),
	.coef2_0(coef2_0),
	.coef2_1(coef2_1),
	.coef2_2(coef2_2),
	.coef2_3(coef2_3),
	.coef2_4(coef2_4),
	.coef2_5(coef2_5),
	.coef2_6(coef2_6),
	.coef2_7(coef2_7),
	.coef3_0(coef3_0),
	.coef3_1(coef3_1),
	.coef3_2(coef3_2),
	.coef3_3(coef3_3),
	.coef3_4(coef3_4),
	.coef3_5(coef3_5),
	.coef3_6(coef3_6),
	.coef3_7(coef3_7),
	.latency(latency),
	.input_a0_latency_clock(input_a0_latency_clock),
	.input_a0_latency_aclr(input_a0_latency_aclr),
	.input_a0_latency_sclr(input_a0_latency_sclr), //added for sclr support
	.input_a1_latency_clock(input_a1_latency_clock),
	.input_a1_latency_aclr(input_a1_latency_aclr),
	.input_a1_latency_sclr(input_a1_latency_sclr), //added for sclr support
	.input_a2_latency_clock(input_a2_latency_clock),
	.input_a2_latency_aclr(input_a2_latency_aclr),
	.input_a2_latency_sclr(input_a2_latency_sclr),  //added for sclr support
	.input_a3_latency_clock(input_a3_latency_clock),
	.input_a3_latency_aclr(input_a3_latency_aclr),
	.input_a3_latency_sclr(input_a3_latency_sclr), //added for sclr support
	.input_b0_latency_clock(input_b0_latency_clock),
	.input_b0_latency_aclr(input_b0_latency_aclr),
	.input_b0_latency_sclr(input_b0_latency_sclr), //added for sclr support
	.input_b1_latency_clock(input_b1_latency_clock),
	.input_b1_latency_aclr(input_b1_latency_aclr),
	.input_b1_latency_sclr(input_b1_latency_sclr), //added for sclr support
	.input_b2_latency_clock(input_b2_latency_clock),
	.input_b2_latency_aclr(input_b2_latency_aclr),
	.input_b2_latency_sclr(input_b2_latency_sclr), //added for sclr support
	.input_b3_latency_clock(input_b3_latency_clock),
	.input_b3_latency_aclr(input_b3_latency_aclr),
	.input_b3_latency_sclr(input_b3_latency_sclr),  //added for sclr support
	.input_c0_latency_clock(input_c0_latency_clock),
	.input_c0_latency_aclr(input_c0_latency_aclr),
	.input_c0_latency_sclr(input_c0_latency_sclr),  //added for sclr support
	.input_c1_latency_clock(input_c1_latency_clock),
	.input_c1_latency_aclr(input_c1_latency_aclr),
	.input_c1_latency_sclr(input_c1_latency_sclr), //added for sclr support
	.input_c2_latency_clock(input_c2_latency_clock),
	.input_c2_latency_aclr(input_c2_latency_aclr),
	.input_c2_latency_sclr(input_c2_latency_sclr),  //added for sclr support
	.input_c3_latency_clock(input_c3_latency_clock),
	.input_c3_latency_aclr(input_c3_latency_aclr),
	.input_c3_latency_sclr(input_c3_latency_sclr), //added for sclr support
	.coefsel0_latency_clock(coefsel0_latency_clock),
	.coefsel0_latency_aclr(coefsel0_latency_aclr),
	.coefsel0_latency_sclr(coefsel0_latency_sclr),  //added for sclr support
	.coefsel1_latency_clock(coefsel1_latency_clock),
	.coefsel1_latency_aclr(coefsel1_latency_aclr),
	.coefsel1_latency_sclr(coefsel1_latency_sclr),  //added for sclr support
	.coefsel2_latency_clock(coefsel2_latency_clock),
	.coefsel2_latency_aclr(coefsel2_latency_aclr),
	.coefsel2_latency_sclr(coefsel2_latency_sclr), //added for sclr support
	.coefsel3_latency_clock(coefsel3_latency_clock),
	.coefsel3_latency_aclr(coefsel3_latency_aclr),
	.signed_latency_clock_a(signed_latency_clock_a),
	.signed_latency_aclr_a(signed_latency_aclr_a),
	.signed_latency_sclr_a(signed_latency_sclr_a), //added for sclr support
	.signed_latency_clock_b(signed_latency_clock_b),
	.signed_latency_aclr_b(signed_latency_aclr_b),
	.signed_latency_sclr_b(signed_latency_sclr_b), //added for sclr support
	.addnsub_multiplier_latency_clock1(addnsub_multiplier_latency_clock1),
	.addnsub_multiplier_latency_aclr1(addnsub_multiplier_latency_aclr1),
	.addnsub_multiplier_latency_sclr1(addnsub_multiplier_latency_sclr1), //added for sclr support
	.addnsub_multiplier_latency_clock3(addnsub_multiplier_latency_clock3),
	.addnsub_multiplier_latency_aclr3(addnsub_multiplier_latency_aclr3),
	.addnsub_multiplier_latency_sclr3(addnsub_multiplier_latency_sclr3), //added for sclr support
	.accum_sload_latency_clock(accum_sload_latency_clock),
	.accum_sload_latency_aclr(accum_sload_latency_aclr),
	.accum_sload_latency_sclr(accum_sload_latency_sclr))
multiply_adder (
	.dataa(dataa), 
	.datab(datab),
	.datac(datac),
	.scanina(scanina),
	.scaninb(scaninb),
	.sourcea(sourcea),
	.sourceb(sourceb),
	.clock3(clock3), 
	.clock2(clock2), 
	.clock1(clock1), 
	.clock0(clock0), 
	.aclr3(aclr3), 
	.aclr2(aclr2), 
	.aclr1(aclr1), 
	.aclr0(aclr0), 
	.sclr3(sclr3), //sclr support
	.sclr2(sclr2), //sclr support
	.sclr1(sclr1), //sclr support
	.sclr0(sclr0), //sclr support
	.ena3(ena3), 
	.ena2(ena2), 
	.ena1(ena1), 
	.ena0(ena0), 
	.signa(signa), 
	.signb(signb), 
	.addnsub1(addnsub1), 
	.addnsub3(addnsub3), 
	.result(result), 
	.scanouta(scanouta), 
	.scanoutb(scanoutb),
	.mult01_round(mult01_round),
	.mult23_round(mult23_round),
	.mult01_saturation(mult01_saturation),
	.mult23_saturation(mult23_saturation),
	.addnsub1_round(addnsub1_round),
	.addnsub3_round(addnsub3_round),
	.mult0_is_saturated(mult0_is_saturated),
	.mult1_is_saturated(mult1_is_saturated),
	.mult2_is_saturated(mult2_is_saturated),
	.mult3_is_saturated(mult3_is_saturated),
	.output_round(output_round),
	.chainout_round(chainout_round),
	.output_saturate(output_saturate),
	.chainout_saturate(chainout_saturate),
	.overflow(overflow),
	.chainout_sat_overflow(chainout_sat_overflow),
	.chainin(chainin),
	.zero_chainout(zero_chainout),
	.rotate(rotate),
	.shift_right(shift_right),
	.zero_loopback(zero_loopback),
	.accum_sload(accum_sload),
	.sload_accum(sload_accum),
	.negate(negate),	
	.coefsel0(coefsel0),
	.coefsel1(coefsel1),
	.coefsel2(coefsel2),
	.coefsel3(coefsel3));

	
endmodule
