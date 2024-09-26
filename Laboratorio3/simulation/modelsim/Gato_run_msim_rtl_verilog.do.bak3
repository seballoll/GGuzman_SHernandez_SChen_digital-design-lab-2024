transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/vgaController.sv}
vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/pll.sv}
vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/videoGen.sv}
vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/MEF.sv}
vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/Pantalla_Inicial.sv}
vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/matrixRegister.sv}
vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/matrixControl.sv}

vlog -sv -work work +incdir+C:/Users/gabri/OneDrive/Desktop/Proyectos\ pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3 {C:/Users/gabri/OneDrive/Desktop/Proyectos pichudos/GGuzman_SHernandez_SChen_digital-design-lab-2024/Laboratorio3/MEF_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  MEF_testbench

add wave *
view structure
view signals
run -all
