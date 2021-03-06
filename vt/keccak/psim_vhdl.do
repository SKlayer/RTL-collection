vmap simprims_ver /home/xuguo/work/xilinx_lib/verilog/simprims_ver
vmap unimacro_ver /home/xuguo/work/xilinx_lib/verilog/unimacro_ver
vmap unisims_ver /home/xuguo/work/xilinx_lib/verilog/unisims_ver
vmap XilinxCoreLib_ver /home/xuguo/work/xilinx_lib/verilog/XilinxCoreLib_ver
vmap simprim /home/xuguo/work/xilinx_lib/vhdl/simprim
vmap unimacro /home/xuguo/work/xilinx_lib/vhdl/unimacro
vmap unisim /home/xuguo/work/xilinx_lib/vhdl/unisim
vmap XilinxCoreLib /home/xuguo/work/xilinx_lib/vhdl/XilinxCoreLib

vlib work
vcom -93 sim_keccak.vhd
vlog tb_v2.1.v
vsim -novopt -t ps -sdfmax /tb_sha/U_Keccak_top=sim_keccak.sdf work.tb_sha
run 1ms
