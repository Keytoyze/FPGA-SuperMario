
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name SuperMario -dir "G:/course/Logic and Computer Design/Project/SuperMario/planAhead_run_1" -part xc7k160tfbg676-1
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "G:/course/Logic and Computer Design/Project/SuperMario/Top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {G:/course/Logic and Computer Design/Project/SuperMario} {ipcore_dir} }
add_files [list {ipcore_dir/Image.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/Test.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "constraints.ucf" [current_fileset -constrset]
add_files [list {constraints.ucf}] -fileset [get_property constrset [current_run]]
link_design
