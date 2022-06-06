Brownie v.1.1 パッケージ
								All Rights Reserved 2008. ASIP Solutions, Inc.
																  2008/07/22


＊　Brownie v.1.1 は ASIP Meister Std v.2.3 で生成可能である


パッケージ内容物 ===============================================================

[package/]	+ README.txt
			+ ReleaseNotes.txt
			+ BrownieSTD32_Spec.pdf
			+ browstd32.pdb
			+ [fhm/]
			|	+ browregfile.fhm
			|	+ dummy_register.fhm
			+ [util/]
			|	+ gccout2img
			|	+ pasout2img
			|	+ img2mem
			|	+（その他補助スクリプト）
			+ [testbench/]
			|	+ README.txt
			|	+ tb_*.vhd
			|	+ wave_*.do
			+ [src/]
				+ t001.asm
				+ browtb.x
				+ startup.s
				+ handler.s

	README.txt				本ファイル
	ReleaseNotes.txt		リリースノート，既知のバグ
	BrownieSTD32_Spec.pdf	Brownie の仕様書
	browstd32.pdb			Brownie のPDBファイル
	[fhm/]					Brownie用 FHM
	[util/]					Brownie用 ユーティリティ・スクリプトサンプル
	[testbench/]			Brownie用 簡易テストベンチファイル
	[src/]					Brownie用 簡易テストコード類


＊　以降，
　　ASIP Meister が [/usr/local/ASIPmeister] にインストールされているとする．



Brownie の生成方法 =============================================================

１．FHM のインストール

	＊ ASIP Meister Std 2.3 には Brownie 用のFHMがインストールされているので，
	　 本項目 FHMのインストール はスキップ可能である

	パッケージの [fhm/] ディレクトリ以下の 
	[browregfile.fhm] および [dummy_register.fhm] を，

/usr/local/ASIPmeister/share/fhmdb/workdb/FHM_work

	にコピーし，

	[/usr/local/ASIPmeister/share/fhmdb/fhmdbstruct] ファイル内の
	<class name="FHM_work"> に対してを本パッケージ付属の [fhm/fhmdbstruct] 
	を参考に，以下のように内容を書き加える．

		<class name="FHM_work">
				:
				:
			<model>dummy_register</model>
			<model>browregfile</model>

２．１の作業後， ASIPmeister を起動し，browstd32.pdb を開くことで，
　　Brownieのデータが読み込まれる．この時点で生成可能な状態になる．


３．アセンブラの生成には Assembler Generation，
　　HDLの生成には HDL Generation のボタンを押す．
　　生成されたファイルは生成ディレクトリ [meister/] 以下に置かれる．


４．コンパイラの生成には Compiler Generation ボタンを押す．
　　生成されたコンパイラ類は [meister/browstd32.swgen/] 以下に展開されるので，
　　利用する際は [meister/browstd32.swgen/bin/] にパスを通すこと．



簡易テスト =====================================================================

VHDL バージョンのテスト方法 ----------------------------------------------------

	簡易テストベンチのメモリマップ等については [testbench/README.txt] を参照．

	testbench ディレクトリ内の t001.asm を pas を使ってアセンブルする

% pas -des browstd32.des -src t001.asm > t001.out

	pas は [/usr/local/ASIPmeister/bin] にある．
	また，brownie32.des はGUIの[Assenbler Generation]で生成されるもので，
	生成ディレクトリ [meister/] 以下にある．

	次に，アセンブル後の .out ファイルを [util/] ディレクトリ下にある 
	pasout2img を使って

TestData.IM
TestData.DM

	に変換する．
	両者はVHDL用テストベンチ tb_browstd32.vhd が参照するメモリイメージである．
	変換するためのコマンドは，以下の通りである．

% pasout2img t001.out

	ただし、[util/] ディレクトリ内のツールを利用する際には [util/] ディレクトリに
	パスを通しておくこと。または、パスが通った場所にコピーして利用すること。

	メモリイメージ生成後は，以下のファイルを同一ディレクトリに入れることで，
	ModelSim等でシミュレーションできる．

・生成した HDL [meister/browstd32.VHDL.syn/*.vhd] 
・テストベンチ [testbench/tb_browstd32.vhd]
               [testbench/tb_im_mifu.vhd]
               [testbench/tb_dm_mifu.vhd]
・上で作成したプログラムのイメージ TestData.IM と TestData.DM

	コピーしたディレクトリにて，

% vlib work
% vcom *.vhd
% vsim work.cfg

	を実行．
	ModelSimの doファイル [testbench/wave_vhdl.do] が準備されているので，
	波形観測時には必要に応じて ModelSim のコンソール上で以下のように利用可能である．

VSIM 1 > do wave_vhdl.do



Verilog バージョンのテスト方法 -------------------------------------------------

	簡易テストベンチのメモリマップ等については [testbench/README.txt] を参照．

	testbench ディレクトリ内の t001.asm を pas を使ってアセンブルする

% pas -des browstd32.des -src t001.asm > t001.out

	pas は [/usr/local/ASIPmeister/bin] にある．
	また，brownie32.des はGUIの[Assenbler Generation]で生成されるもので，
	生成ディレクトリ [meister/] 以下にある．

	次に，アセンブル後の .out ファイルを [util/] ディレクトリ下にある 
	pasout2img を使って

TestData.IM
TestData.DM

	に変換する．
	両者はVHDL用テストベンチ tb_browstd32.vhd が参照するメモリイメージである．
	変換するためのコマンドは，以下の通りである．

% pasout2img t001.out

	ただし、[util/] ディレクトリ内のツールを利用する際には [util/] ディレクトリに
	パスを通しておくこと。または、パスが通った場所にコピーして利用すること。

	メモリイメージ生成後は，以下のファイルを同一ディレクトリに入れることで，
	ModelSim等でシミュレーションできる．ただし，テストベンチはVHDLを使用し，
	ModelSimによる混合シミュレーションを行うものとする．

・生成した HDL [meister/browstd32.Verilog.syn/*.v] 
・テストベンチ [testbench/tb_browstd32.vhd]
               [testbench/tb_im_mifu.vhd]
               [testbench/tb_dm_mifu.vhd]
・上で作成したプログラムのイメージ TestData.IM と TestData.DM

	コピーしたディレクトリにて，

% vlib work
% vlog *.v
% vcom *.vhd
% vsim -novopt work.cfg

	を実行．
	ModelSimのdoファイル [testbench/wave_vlog.do] が準備されているので，
	必要に応じて利用可能である．

VSIM 1 > do wave_vlog.do

	なお，コンパイル後のオブジェクトファイルをVerilog用メモリ形式（.mem）へ
	変換できる．pasout2img，によって出力された TestData.?? ファイルと
	同じディレクトリで img2mem を使用する．

% pasout2img main
% img2mem

	img2mem は TestData.IM および TestData.DM から，
	.mem 形式のファイル TestData.IM.mem と TestData.DM.mem を出力する．



コンパイラの利用 ===============================================================

	
	gccの出力であるelf形式から、メモリイメージを抽出するためのユーティリティ・
	スクリプトのサンプルをgccout2img，img2mem として本パッケージの [util/] に
	添付している．
	なお，本パッケージ付属のユーティリティを利用するためには [util/]に
	パスを通しておく必要がある．

	はじめに，BrownieSTD32 用のGCCセットを生成する．
	展開後の [meister/browstd32.swgen/bin] にパスを通しておく．


通常のコンパイル法 -------------------------------------------------------------

% brownie32-elf-gcc -S main.c -o main.s
% brownie32-elf-as -o startup.o startup.s
% brownie32-elf-as -o handler.o handler.s
% brownie32-elf-as -o main.o main.s
% brownie32-elf-ld -o test -T browtb.x main.o startup.o handler.o

	以上のコマンドを順に入力することで，
	プロセッサのオブジェクトコード test が生成される．
	startup.sとhandler.sはスタートアップルーチンと，
	割り込みハンドラルーチンであり，リンカスクリプト browtb.x
	にしたがってリンクされる．
	startup.s, handler.s, browtb.xは、ユーザが環境にあわせて準備
	する必要がある．


コンパイル後のオブジェクトファイルを簡易テストベンチのメモリイメージへ変換 -----
	「通常のコンパイル法」にて得られた elf 形式のファイルに対して
	gccout2img を利用する．

% gccout2img test

	gccout2img は TestData.IM と TestData.DM を出力するので，
	それを用いて簡易テストの方式でシミュレーション可能である．



コンパイル後のオブジェクトファイルをVerilog用メモリ形式（.mem）へ変換 ----------
	gccout2img，または pasout2img によって出力された TestData.?? ファイルと
	同じディレクトリで img2mem を使用する．

% gccout2img test
% img2mem

	img2mem は TestData.IM および TestData.DM から，
	.mem 形式のファイル TestData.IM.mem と TestData.DM.mem を出力する．


以上．
