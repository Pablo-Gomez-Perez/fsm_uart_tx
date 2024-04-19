module gw_gao(
    pulsito,
    tx,
    \conta_tx[15] ,
    \conta_tx[14] ,
    \conta_tx[13] ,
    \conta_tx[12] ,
    \conta_tx[11] ,
    \conta_tx[10] ,
    \conta_tx[9] ,
    \conta_tx[8] ,
    \conta_tx[7] ,
    \conta_tx[6] ,
    \conta_tx[5] ,
    \conta_tx[4] ,
    \conta_tx[3] ,
    \conta_tx[2] ,
    \conta_tx[1] ,
    \conta_tx[0] ,
    \conta_8[3] ,
    \conta_8[2] ,
    \conta_8[1] ,
    \conta_8[0] ,
    estado,
    siguiente_estado,
    \conta[15] ,
    \conta[14] ,
    \conta[13] ,
    \conta[12] ,
    \conta[11] ,
    \conta[10] ,
    \conta[9] ,
    \conta[8] ,
    \conta[7] ,
    \conta[6] ,
    \conta[5] ,
    \conta[4] ,
    \conta[3] ,
    \conta[2] ,
    \conta[1] ,
    \conta[0] ,
    clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input pulsito;
input tx;
input \conta_tx[15] ;
input \conta_tx[14] ;
input \conta_tx[13] ;
input \conta_tx[12] ;
input \conta_tx[11] ;
input \conta_tx[10] ;
input \conta_tx[9] ;
input \conta_tx[8] ;
input \conta_tx[7] ;
input \conta_tx[6] ;
input \conta_tx[5] ;
input \conta_tx[4] ;
input \conta_tx[3] ;
input \conta_tx[2] ;
input \conta_tx[1] ;
input \conta_tx[0] ;
input \conta_8[3] ;
input \conta_8[2] ;
input \conta_8[1] ;
input \conta_8[0] ;
input estado;
input siguiente_estado;
input \conta[15] ;
input \conta[14] ;
input \conta[13] ;
input \conta[12] ;
input \conta[11] ;
input \conta[10] ;
input \conta[9] ;
input \conta[8] ;
input \conta[7] ;
input \conta[6] ;
input \conta[5] ;
input \conta[4] ;
input \conta[3] ;
input \conta[2] ;
input \conta[1] ;
input \conta[0] ;
input clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire pulsito;
wire tx;
wire \conta_tx[15] ;
wire \conta_tx[14] ;
wire \conta_tx[13] ;
wire \conta_tx[12] ;
wire \conta_tx[11] ;
wire \conta_tx[10] ;
wire \conta_tx[9] ;
wire \conta_tx[8] ;
wire \conta_tx[7] ;
wire \conta_tx[6] ;
wire \conta_tx[5] ;
wire \conta_tx[4] ;
wire \conta_tx[3] ;
wire \conta_tx[2] ;
wire \conta_tx[1] ;
wire \conta_tx[0] ;
wire \conta_8[3] ;
wire \conta_8[2] ;
wire \conta_8[1] ;
wire \conta_8[0] ;
wire estado;
wire siguiente_estado;
wire \conta[15] ;
wire \conta[14] ;
wire \conta[13] ;
wire \conta[12] ;
wire \conta[11] ;
wire \conta[10] ;
wire \conta[9] ;
wire \conta[8] ;
wire \conta[7] ;
wire \conta[6] ;
wire \conta[5] ;
wire \conta[4] ;
wire \conta[3] ;
wire \conta[2] ;
wire \conta[1] ;
wire \conta[0] ;
wire clk;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top u_ao_top(
    .control(control0[9:0]),
    .data_i({pulsito,tx,\conta_tx[15] ,\conta_tx[14] ,\conta_tx[13] ,\conta_tx[12] ,\conta_tx[11] ,\conta_tx[10] ,\conta_tx[9] ,\conta_tx[8] ,\conta_tx[7] ,\conta_tx[6] ,\conta_tx[5] ,\conta_tx[4] ,\conta_tx[3] ,\conta_tx[2] ,\conta_tx[1] ,\conta_tx[0] ,\conta_8[3] ,\conta_8[2] ,\conta_8[1] ,\conta_8[0] ,estado,siguiente_estado,\conta[15] ,\conta[14] ,\conta[13] ,\conta[12] ,\conta[11] ,\conta[10] ,\conta[9] ,\conta[8] ,\conta[7] ,\conta[6] ,\conta[5] ,\conta[4] ,\conta[3] ,\conta[2] ,\conta[1] ,\conta[0] }),
    .clk_i(clk)
);

endmodule
