# Four-Channel Complex Beamforming Core

Four-channel complex weighted-sum DSP datapath in Verilog with Q1.7 coefficients, signed fixed-point arithmetic and output saturation.

## Intended use

Combines four complex I/Q channels with user-supplied weights; antenna steering and array-gain validation are outside the current implementation.

## Repository structure

- `rtl/beamformer4.v`: synthesizable Verilog module
- `tb/tb_beamformer4.v`: self-checking RTL testbench
- `reference/test_model.py`: independent Python algorithm/arithmetic sanity checks
- `run_tests.sh`: Python check and optional Icarus Verilog simulation

## Run

Requirements: Python 3; optional Icarus Verilog (`iverilog`, `vvp`) for RTL simulation.

```bash
bash run_tests.sh
```

## Verification status

- Python reference sanity checks: passed in original authoring environment.
- RTL self-checking testbench: written, not yet executed in original authoring environment.
- RTL vs Python sample-by-sample comparison: not yet established.
- ASIC synthesis / timing / silicon: not completed.

## Scope

A standalone educational/portfolio prototype using only original generic signal-processing techniques. It does not reproduce proprietary RPMA or satellite SoC design, and makes no claims of production readiness.
