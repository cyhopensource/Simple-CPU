vlib work

vmap work work

vcom addition.vhd addition_plus.vhd alu.vhd BDR.vhd decodeur.vhd extension.vhd pcreg.vhd psr.vhd
vcom extension_instruction.vhd mem.vhd mem_instruction.vhd mux21.vhd mux21_4.vhd mux21_instruction.vhd
vcom partie_1.vhd partie_2.vhd cpu.vhd cpu_tb.vhd
# Les documents est places au-dessus. 

onerror {resume}
vsim work.cpu_tb -t 1ps
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Literal /cpu_tb/uut/g1/g1/banc
add wave -noupdate -format Logic /cpu_tb/uut/g1/g1/clk
add wave -noupdate -format Logic /cpu_tb/uut/g1/g1/reset
add wave -noupdate -format Literal /cpu_tb/uut/g1/g5/addr
add wave -noupdate -format Literal /cpu_tb/uut/g1/g5/banc
add wave -noupdate -format Literal /cpu_tb/uut/g4/psr_in
add wave -noupdate -format Literal /cpu_tb/uut/g2/g2/instruction
add wave -noupdate -format Literal /cpu_tb/uut/g2/g2/pc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4055529 ps} 0}
configure wave -namecolwidth 196
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {14904774 ps}

run -all
