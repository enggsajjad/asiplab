/*
 * Testbench Sample for Brownie STD 32
 * 
 * Copyright (C) 2009 ASIP Solutions, Inc. All rights reserved.
 */

#include <systemc.h>
#include "BrownieSTD32.h"

SC_MODULE(imem)
{
	sc_in<sc_uint<32> > addr;
	sc_out<sc_uint<32> > data;
	sc_out<bool> fin;
	
	unsigned start_addr;
	unsigned mem_size;
	
	unsigned char *mem;
	
	SC_CTOR(imem)
	{
		SC_METHOD(proc_read);
		sensitive << addr;
		
		start_addr = 0x0ffe0000;
		mem_size = 0x10000;
		mem = (unsigned char *)malloc(mem_size);
	}
	
	imem(sc_module_name c_name, unsigned c_addr, unsigned c_size)
	{
		SC_METHOD(proc_read);
		sensitive << addr;
		
		start_addr = c_addr;
		mem_size = c_size;
		mem = (unsigned char *)malloc(mem_size);
	}
	
	void proc_read()
	{
		unsigned a = addr.read().to_uint();
		if (a < start_addr) {
			data.write(0);
			return;
		}
		if (a >= start_addr + mem_size) {
			data.write(0);
			return;
		}
		a -= start_addr;
		unsigned d = 0;
		for (int i = 0; i < 4; i++) {
			d = (d << 8) | mem[a++];
		}
		data.write(d);
		
		if (d == 0xffffffff) {
			fin.write(1);
		}
	}
	
	void load(char *filename = "TestData.IM")
	{
		FILE *fp = fopen(filename, "r");
		if (!fp) {
			perror(filename);
			exit(1);
		}
		char s[256];
		while (fgets(s, sizeof s, fp)) {
			unsigned addr, data;
			if (sscanf(s, "%x %x", &addr, &data) == 2) {
				if ((addr < start_addr) || (addr >= start_addr + mem_size)) {
					continue;
				}
				addr -= start_addr;
				mem[addr] = data;
			}
		}
		fclose(fp);
	}
};

SC_MODULE(dmem)
{
	sc_in<bool> clock;
	sc_in<sc_uint<32> > addr;
	sc_in<sc_uint<32> > data_in;
	sc_out<sc_uint<32> > data_out;
	sc_in<bool> req;
	sc_in<bool> rw;
	sc_in<sc_uint<2> > mode;
	sc_in<bool> ext;
	sc_in<bool> fin;
	
	unsigned start_addr;
	unsigned mem_size;
	
	unsigned char *mem;

	int fin_countdown;
	
	SC_CTOR(dmem)
	{
		SC_METHOD(proc_read);
		sensitive << addr << rw << mode << ext;
		
		SC_METHOD(proc_write);
		sensitive << clock.pos();
		
		SC_METHOD(proc_fin);
		sensitive << clock.pos();
		
		start_addr = 0x00000000;
		mem_size = 0x10000;
		mem = (unsigned char *)malloc(mem_size);

		fin_countdown = 5;
	}
	
	void proc_read()
	{
		unsigned a = addr.read().to_uint();
		if (a < start_addr) {
			data_out.write(0);
			return;
		}
		if (a >= start_addr + mem_size) {
			data_out.write(0);
			return;
		}
		a -= start_addr;
		unsigned d = 0;
		unsigned m = mode.read().to_uint();
		for (int i = 0; i <= m; i++) {
			d = (d << 8) | mem[a++];
		}
		if (ext.read()) {
			d = (signed)(d << (8 * (3 - m))) >> (8 * (3 - m));
		}
		data_out.write(d);
	}

	void proc_write()
	{
		if (!req.read() || !rw.read()) {
			return;
		}
		unsigned a = addr.read().to_uint();
		unsigned d = data_in.read().to_uint();
		if ((a < start_addr) || (a >= start_addr + mem_size)) {
			return;
		}
		a -= start_addr;
		unsigned m = mode.read().to_uint();
		a += m;
		for (int i = 0; i <= m; i++) {
			mem[a--] = d & 0xff;
			d >>= 8;
		}
	}
	
	void load(char *filename = "TestData.DM")
	{
		FILE *fp = fopen(filename, "r");
		if (!fp) {
			perror(filename);
			exit(1);
		}
		char s[256];
		while (fgets(s, sizeof s, fp)) {
			unsigned addr, data;
			if (sscanf(s, "%x %x", &addr, &data) == 2) {
				if ((addr < start_addr) || (addr >= start_addr + mem_size)) {
					continue;
				}
				addr -= start_addr;
				mem[addr] = data;
			}
		}
		fclose(fp);
	}
	
	void proc_fin()
	{
		if (!fin.read()) {
			return;
		}
		if (fin_countdown-- > 0) {
			return;
		}
		
		FILE *fp = fopen("TestData.OUT", "w");
		unsigned a;
		for (a = 0; a < mem_size; a += 4) {
			unsigned d = 0;
			for (int i = 0; i < 4; i++) {
				d = (d << 8) | mem[a + i];
			}
			fprintf(fp, "%08X %08X\n", a, d);
		}
		fclose(fp);
		
		sc_stop();
	}
};

SC_MODULE(im_mux)
{
	sc_in<sc_uint<32> > in1;
	sc_in<sc_uint<32> > in2;
	sc_out<sc_uint<32> > out;
	
	sc_in<bool> fin1;
	sc_in<bool> fin2;
	sc_out<bool> fin;
	
	SC_CTOR(im_mux)
	{
		SC_METHOD(mux);
		sensitive << in1 << in2;

		SC_METHOD(fin_mux);
		sensitive << fin1 << fin2;
	}
	
	void mux()
	{
		out.write(in1.read() | in2.read());
	}

	void fin_mux()
	{
		fin.write(fin1.read() | fin2.read());
	}
};


int sc_main(int argc, char** argv)
{
	ns_BrownieSTD32::BrownieSTD32 uut("uut");
	
	sc_clock clock("clock", 10, SC_NS);
	sc_signal<bool> reset, im_err, dm_err, dm_req, dm_ack, dm_can, dm_rw, dm_ext, intr_in, intr_cat;
	sc_signal<sc_uint<32> > im_addr, im_data, im_data1, im_data2, dm_addr, dm_in, dm_out;
	sc_signal<sc_uint<2> > dm_mode;
	
	uut(clock, reset, im_addr, im_data, im_err, dm_addr, dm_in, dm_out, dm_req, dm_ack, dm_rw, dm_mode, dm_ext, dm_err, dm_can, intr_in, intr_cat);
	
	dm_ack.write(1);
	
	imem im1("im1", 0x00000000, 0x10000);
	imem im2("im2", 0x0ffe0000, 0x00c00);
	sc_signal<bool> fin, fin1, fin2;
	im1(im_addr, im_data1, fin1);
	im2(im_addr, im_data2, fin2);
	im_mux mux("mux");
	mux(im_data1, im_data2, im_data, fin1, fin2, fin);
	
	if (argc == 2) {
		im1.load(argv[1]);
		im2.load(argv[1]);
	} else {
		im1.load();
		im2.load();
	}
	
	dmem dm("dm");
	dm(clock, dm_addr, dm_out, dm_in, dm_req, dm_rw, dm_mode, dm_ext, fin);
	dm.load();
	
	sc_start();
}
