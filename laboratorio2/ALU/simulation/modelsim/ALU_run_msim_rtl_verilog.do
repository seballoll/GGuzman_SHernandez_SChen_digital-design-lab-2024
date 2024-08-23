transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/sebas/OneDrive/Documentos/GitHub/GGuzman_SHernandez_SChen_digital-design-lab-2024/laboratorio2/ALU {C:/Users/sebas/OneDrive/Documentos/GitHub/GGuzman_SHernandez_SChen_digital-design-lab-2024/laboratorio2/ALU/ALU_module.sv}
vlog -sv -work work +incdir+C:/Users/sebas/OneDrive/Documentos/GitHub/GGuzman_SHernandez_SChen_digital-design-lab-2024/laboratorio2/ALU {C:/Users/sebas/OneDrive/Documentos/GitHub/GGuzman_SHernandez_SChen_digital-design-lab-2024/laboratorio2/ALU/Functions.sv}

vlog -sv -work work +incdir+C:/Users/sebas/OneDrive/Documentos/GitHub/GGuzman_SHernandez_SChen_digital-design-lab-2024/laboratorio2/ALU {C:/Users/sebas/OneDrive/Documentos/GitHub/GGuzman_SHernandez_SChen_digital-design-lab-2024/laboratorio2/ALU/ALU_Testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ALU_Testbench

add wave *
view structure
view signals
run -all
