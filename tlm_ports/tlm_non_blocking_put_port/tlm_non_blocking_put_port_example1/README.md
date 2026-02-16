# UVM Nonblocking Put Port Example  
## Producer → Consumer Communication

This example demonstrates transaction-level communication between two UVM components using a **nonblocking put TLM port**.

A `producer` component generates transactions and sends them to a `consumer` component through a `uvm_nonblocking_put_port`. The consumer implements the corresponding `uvm_nonblocking_put_imp` interface to receive and process transactions.

This example is intended as a learning reference for understanding **UVM TLM communication**, nonblocking transfers, and readiness-based transaction flow.

---

## 📌 Objectives

The goals of this example are to:

- Create a transaction object using `uvm_object`
- Implement a producer component that generates and sends transactions
- Implement a consumer component that receives transactions
- Demonstrate `uvm_nonblocking_put_port`
- Implement `try_put()` and `can_put()` methods
- Show how sender and receiver synchronize without blocking execution

---


