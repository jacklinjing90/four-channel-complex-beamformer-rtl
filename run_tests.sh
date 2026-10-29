#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
python3 reference/test_model.py
if command -v iverilog >/dev/null && command -v vvp >/dev/null; then
  mkdir -p build
  iverilog -g2012 -s tb_beamformer4 -o build/beamformer4.vvp rtl/beamformer4.v tb/tb_beamformer4.v
  vvp build/beamformer4.vvp
else
  echo 'RTL SIMULATION NOT RUN: install iverilog and vvp first.'
fi
