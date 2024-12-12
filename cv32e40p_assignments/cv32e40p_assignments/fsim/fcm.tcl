set_config -global_max_jobs 1

## DYNAMIC RUNTIME
create_testcases -name {"test1"} \
    -exec ${::env(VCS_WORK_DIR)}/simv \
    -args "./simv +firmware=${::env(FIRMWARE)}"

# Start fault simulation
fsim -verbose

# Write results report
report -campaign cv32e40p -report fsim_out.rpt -overwrite
report -campaign cv32e40p -report fsim_out_hier.rpt -overwrite -hierarchical 0
