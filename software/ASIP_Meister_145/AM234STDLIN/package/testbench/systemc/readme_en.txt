
SystemC Testbench for Brownie STD 32
====================================

ASIP Solutions, Inc.

July 2009


File
----

  tb_brownie.cpp


Verified Simulation Kernel
--------------------------

  OSCI SystemC 2.2 (available from http://www.systemc.org/)


Compilation
-----------

  1. Run "HDL Generation" in ASIP Meister

  2. Copy tb_brownie.cpp to generated directory
     (e.g. meister/browstd32.SystemC.sim)

  3. Execute compile from command line:
     $ g++ -I /usr/local/systemc-2.2/include \
           -L /usr/local/systemc-2.2/lib-linux \
           *.cpp -lsystemc

Simulation
----------

  1. Format of input memory image file is same as VHDL version

  2. Execute simulation from command line:
     $ ./a.out
     Simulation ends when instruction code 0xffffffff is fetched

  3. Data memory contents are written in TestData.OUT


