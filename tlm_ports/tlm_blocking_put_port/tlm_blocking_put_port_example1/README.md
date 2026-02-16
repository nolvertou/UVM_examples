# UVM TLM Blocking Put Example

This example demonstrates how to use **UVM Transaction-Level Modeling (TLM) Blocking Put**
to transfer transactions between components in a synchronized manner.

The example shows a simple communication flow where a **producer**
sends data to a **consumer**, and the producer waits until the consumer
finishes processing the transaction.

---

## 📌 Objective

The goals of this example are:

- Understand blocking communication in UVM TLM
- Learn the roles of port, export, and implementation
- Understand how transactions flow between components
- Observe blocking behavior during simulation
- Provide a minimal and clear TLM example for learning purposes

---

## 🏗 Architecture Overview

The communication chain used in this example is:

Producer (Port) → Export → Implementation (Consumer)



### Flow Description

1. The producer generates data.
2. The producer calls `put()` using a blocking put port.
3. The call is forwarded through the export.
4. The consumer implementation receives the transaction.
5. The producer resumes execution after the consumer finishes.

Because this is a **blocking** call, the producer waits until the
consumer completes the `put()` task.

---

## 📁 File Description

This example is organized into multiple SystemVerilog files, each representing a standard UVM component. The goal is to clearly demonstrate how blocking put communication is implemented and connected inside a UVM environment.

---

### `producer.sv`

The producer is responsible for generating and sending data to another component using a blocking TLM interface.

Responsibilities:

- Declares a `uvm_blocking_put_port`
- Generates transaction data
- Calls the `put()` method to send data
- Waits until the consumer finishes processing the transaction

The producer does not know which component receives the data. It only interacts through the TLM interface.

---

### `consumer.sv`

The consumer receives and processes the transaction sent by the producer.

Responsibilities:

- Declares a `uvm_blocking_put_export`
- Implements the blocking put interface using `uvm_blocking_put_imp`
- Defines the `put()` task where the transaction is handled

The consumer controls when the blocking operation ends because the producer resumes execution only after this task completes.

---

### `env.sv`

The environment instantiates and connects all components required for communication.

Responsibilities:

- Creates the producer and consumer components
- Connects TLM ports, exports, and implementations in the `connect_phase`
- Defines the communication path between components

This file represents the structural integration layer of the testbench.

---

### `test.sv`

The test is the top-level UVM test class.

Responsibilities:

- Instantiates the environment
- Starts the UVM test execution
- Relies on UVM phases to run the simulation

The test itself contains minimal logic since the focus of this example is TLM communication.

---

### `tb.sv`

The top-level testbench module.

Responsibilities:

- Imports the UVM package
- Includes all SystemVerilog files
- Calls `run_test()` to start simulation

This module serves as the simulation entry point.
