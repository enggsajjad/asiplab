
Brownie STD 32用 SystemC版 テストベンチ
=======================================

2009年7月
エイシップ・ソリューションズ株式会社


ファイル構成
------------

  tb_brownie.cpp


動作確認済みシミュレーションカーネル
------------------------------------

  OSCI SystemC 2.2  (http://www.systemc.org/ より入手可能)


コンパイル方法
--------------

  1. ASIP MeisterよりHDL Generation実行
  2. 生成先ディレクトリ (meister/browstd32.SystemC.simなど) に
     tb_brownie.cpp をコピー
  3. コマンドラインよりコンパイル実行
     $ g++ -I /usr/local/systemc-2.2/include -L /usr/local/systemc-2.2/lib-linux *.cpp -lsystemc


シミュレーション実行方法
------------------------

  1. 入力となるメモリイメージのフォーマットは VHDL版 と共通
     カレントディレクトリの TestData.IM と TestData.DM を使用
  2. コマンドラインよりシミュレーション実行
     $ ./a.out
     命令として 0xffffffff をフェッチするまで実行
  3. 実行後データメモリの内容が TestData.OUT に出力される


以上

