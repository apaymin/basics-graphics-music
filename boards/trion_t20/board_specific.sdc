
# Auto-generated by Interface Designer
#
# WARNING: Any manual changes made to this file will be lost when generating constraints.

# Efinity Interface Designer SDC
# Version: 2023.2.307
# Date: 2024-03-30 22:35

# Copyright (C) 2013 - 2023 Efinix Inc. All rights reserved.

# Device: T20F256
# Timing Model: C4 (final)

# PLL Constraints
#################
create_clock -period 20.2020 pll_clk

# Clock Latency Constraints
############################
# set_clock_latency -source -setup <board_max + 1.796> [get_ports {pll_clk}]
# set_clock_latency -source -hold <board_min + 0.898> [get_ports {pll_clk}]
