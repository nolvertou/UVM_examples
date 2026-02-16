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

### `producer.sv`

The producer is responsible for sending data.

Key responsibilities:

- Declares a `uvm_blocking_put_port`
- Generates data
- Calls `put()` to send the transaction
- Waits until the consumer finishes processing

Important code:

```systemverilog
uvm_blocking_put_port #(int) send;
send.put(data);


The producer does not know who receives the transaction.
It only knows that a put() interface exists.

consumer.sv

The consumer receives and processes the transaction.

Key responsibilities:

Declares a blocking put export

Implements the blocking put interface using uvm_blocking_put_imp

Defines the put() task

Important code:

uvm_blocking_put_imp #(int, consumer) imp;

task put(int data);
  // Transaction processing
endtask


The consumer controls when the blocking operation ends.

env.sv

The environment instantiates and connects the producer and consumer.

Responsibilities:

Creates producer and consumer components

Connects TLM interfaces during connect_phase

Connections:

p.send.connect(c.recv);
c.recv.connect(c.imp);


This creates the communication path between components.

test.sv

The test creates the environment and starts the simulation.

Responsibilities:

Instantiates the environment

Relies on UVM phases to execute the test

tb.sv

Top-level testbench module.

Responsibilities:

Imports UVM package

Includes all component files

Calls run_test() to start simulation
