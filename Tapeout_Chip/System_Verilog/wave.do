onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider testbench
add wave -noupdate -expand -group input /test_SQRD_top_spi/test_top/rst
add wave -noupdate -expand -group input /test_SQRD_top_spi/test_top/clk
add wave -noupdate -expand -group input -radix unsigned /test_SQRD_top_spi/test_top/h
add wave -noupdate -expand -group input /test_SQRD_top_spi/test_top/s_ssn
add wave -noupdate -expand -group input /test_SQRD_top_spi/test_top/s_sclk
add wave -noupdate /test_SQRD_top_spi/test_top/s_sclk_posedge
add wave -noupdate /test_SQRD_top_spi/test_top/s_ssn_negedge
add wave -noupdate /test_SQRD_top_spi/test_top/s_signal
add wave -noupdate /test_SQRD_top_spi/test_top/d_signal
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/sel_R
add wave -noupdate /test_SQRD_top_spi/test_top/clk
add wave -noupdate -expand -group output -radix unsigned /test_SQRD_top_spi/test_top/mosi
add wave -noupdate -expand -group output /test_SQRD_top_spi/test_top/m_ssn
add wave -noupdate -expand -group output /test_SQRD_top_spi/test_top/m_sclk
add wave -noupdate /test_SQRD_top_spi/test_top/ps_tx
add wave -noupdate /test_SQRD_top_spi/test_top/ns_tx
add wave -noupdate -radix unsigned -childformat {{{/test_SQRD_top_spi/test_top/shift_data_rx[11]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[10]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[9]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[8]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[7]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[6]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[5]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[4]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[3]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[2]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[1]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_rx[0]} -radix unsigned}} -expand -subitemconfig {{/test_SQRD_top_spi/test_top/shift_data_rx[11]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[10]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[9]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[8]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[7]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[6]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[5]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[4]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[3]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[2]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[1]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_rx[0]} {-height 15 -radix unsigned}} /test_SQRD_top_spi/test_top/shift_data_rx
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/sel_R
add wave -noupdate -radix unsigned -childformat {{{/test_SQRD_top_spi/test_top/shift_data_tx[11]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[10]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[9]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[8]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[7]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[6]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[5]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[4]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[3]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[2]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[1]} -radix unsigned} {{/test_SQRD_top_spi/test_top/shift_data_tx[0]} -radix unsigned}} -expand -subitemconfig {{/test_SQRD_top_spi/test_top/shift_data_tx[11]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[10]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[9]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[8]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[7]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[6]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[5]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[4]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[3]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[2]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[1]} {-height 15 -radix unsigned} {/test_SQRD_top_spi/test_top/shift_data_tx[0]} {-height 15 -radix unsigned}} /test_SQRD_top_spi/test_top/shift_data_tx
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/send_data_cnt
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/sclk_cnt
add wave -noupdate -divider FSM_1
add wave -noupdate /test_SQRD_top_spi/test_top/ps
add wave -noupdate /test_SQRD_top_spi/test_top/ns
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/cnt15
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/load_min
add wave -noupdate /test_SQRD_top_spi/test_top/HVM_start
add wave -noupdate -divider Sort4x4
add wave -noupdate /test_SQRD_top_spi/test_top/clk
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/h
add wave -noupdate /test_SQRD_top_spi/test_top/load_min
add wave -noupdate /test_SQRD_top_spi/test_top/load_min_index
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/normh_dff
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/min_norm_h
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/min_index
add wave -noupdate -divider Sort3x3
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/normh1
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/normh2
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/normh3
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/min1
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/min_index3x3
add wave -noupdate /test_SQRD_top_spi/test_top/min_index2x2
add wave -noupdate -divider FSM_2
add wave -noupdate /test_SQRD_top_spi/test_top/ps_VM
add wave -noupdate /test_SQRD_top_spi/test_top/ns_VM
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/sel_col
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/sel_QRdecom_VM
add wave -noupdate /test_SQRD_top_spi/test_top/rst_normh12
add wave -noupdate /test_SQRD_top_spi/test_top/rst_normh3
add wave -noupdate /test_SQRD_top_spi/test_top/load_normh12
add wave -noupdate /test_SQRD_top_spi/test_top/load_normh3
add wave -noupdate /test_SQRD_top_spi/test_top/load_VMout
add wave -noupdate /test_SQRD_top_spi/test_top/load_VM1
add wave -noupdate /test_SQRD_top_spi/test_top/load_VM2
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/sel_R
add wave -noupdate -divider QR_VM
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/A_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/B_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/C_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/D_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/E_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/F_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/G_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/QRdecom_VM_1/H_in
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/A_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/B_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/C_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/D_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/E_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/F_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/G_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/H_out
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/D_out_VM12
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/F_out_VM12
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/H_out_VM12
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/D_out_VM13
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/F_out_VM13
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/H_out_VM13
add wave -noupdate -divider Matrix
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h11
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h21
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h31
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h41
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h12
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h22
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h32
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h42
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h13
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h23
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h33
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h43
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h14
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h24
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h34
add wave -noupdate -radix unsigned /test_SQRD_top_spi/test_top/HH/h44
add wave -noupdate /test_SQRD_top_spi/test_top/sclk_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13324813 ps} 0} {{Cursor 2} {2312024 ps} 0} {{Cursor 5} {5149796 ps} 0} {{Cursor 6} {7150000 ps} 0} {{Cursor 7} {9013528 ps} 0} {{Cursor 8} {10960838 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {315789 ps} {5513049 ps}
