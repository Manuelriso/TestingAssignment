# OpenHW CV32E40P Testing Workspace

## Requirements

The following tools are required for the proper functionality of the environment:

|Tool|Purpose|
|-|-|
| Synopsys VCS | Logic Simulation|
| Synopsys VC-Z01X | Functional Fault Simulation |
| Synopsys Design Compiler | Logic Synthesis |

## Software Test Libraries

To compile your STLs, you can run the command:
```
$ make compile_sbst
```

## Logic simulation

### RT-Level
To perform the RT-Level logic simulation run:
```
$ make vcs/sim/rtl/shell
```
To perform the RT-Level logic simulation with GUI run:
```
$ make vcs/sim/rtl/gui
```

### Gate-Level

To perform the Gate-Level logic simulation run:
```
$ make vcs/sim/gate/shell
```
To perform the Gate-Level logic simulation with GUI run:
```
$ make vcs/sim/gate/gui
```
## Fault simulation
To perform the Gate-Level fault simulation run:
```
$ make vcs/fsim/shell
```
To perform the Gate-Level fault simulation with GUI run:
```
$ make vcs/fsim/gui
```

You can modify the following files to better fine tune your fault simulation parameters:

|File|Purpose|
|-|-|
| *fsim/strobe.sv*   | Strobe Points definition|
| *fsim/fcm.tcl*    | Fault Simulation instructions |
| *fsim/gen_saf_cv32e40p_top.sff*  | Stuck-At Fault list definition |
| *fsim/gen_tdf_cv32e40p_top.sff*  | Transition-Delay Fault list definition |
| *fsim/config.sff*  | Fault Simulation configuration (Promotion Table/Coverage...) |

To choose between Stuck-At and Transitiom-Delay fault models, open the Makefile and modify the FAULT_TYPE variable.

Stuck-At Faults:
```
line_15: FAULT_TYPE ?= saf
```

Transition-Delay Faults:
```
line_15: FAULT_TYPE ?= tdf
```

## Synthesis
To synthesize the design run:
```
$ make synthesis/nangate45
```

## Clean-up

To clean-up the environment run:
```
$ make distclean
```

## Other

To retrieve a full list of commands run:
```
$ make help
```

## Contacts

For further clarification you can message us on the Telegram or e-mail.
