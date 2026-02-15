
# Virtual Sequencer – Example 1

## Overview

This example demonstrates the basic usage of a **Virtual Sequencer** in a UVM environment.

A virtual sequencer is used when multiple sequencers must be controlled and synchronized from a single sequence. This is commonly required in system-level verification where coordinated stimulus must be applied across different interfaces or agents.

This example shows how a virtual sequence controls two independent agents through their respective sequencers.

---

## Motivation

In simple environments, sequences run directly on a single sequencer.  
However, in complex verification environments such as CPUs, interconnects, or memory subsystems, stimulus must be coordinated across multiple interfaces.

Examples include:

- Read and write traffic synchronization
- Producer–consumer traffic generation
- Multi-interface protocol interaction
- System-level traffic scenarios

The virtual sequencer provides a centralized control point for such scenarios.

---

## Concepts Demonstrated

This example covers the following UVM concepts:

- Virtual sequencer definition
- Virtual sequence implementation
- Connecting agent sequencers to virtual sequencer
- Coordinating multiple sequences
- Starting sequences from a single control layer
- Environment-level stimulus control

---

## Block Diagram
<p align="center">
  <img src="https://github.com/nolvertou/UVM_examples/blob/66da791270c309f7680e8d37f36668931a15ea92/virtual_sequencer/virtual_sequencer_example1/virtual_sequencer_block_diagram1.png" width="600"/>
  
</p>

