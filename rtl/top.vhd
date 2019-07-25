-- Copyright (C) 2019 Joonas Javanainen <joonas.javanainen@gmail.com>
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
library ieee;
use ieee.std_logic_1164.all;
use work.common.all;

entity top is
  port (
    reset_n: in std_logic;
    prg_n: in std_logic;
    wr_n: in std_logic;
    rwr_n: out std_logic;
    addr: in std_logic_vector(15 downto 12);
    data: in std_logic_vector(7 downto 0);
    ra: out std_logic_vector(17 downto 14));

  attribute syn_keep: integer;
  attribute syn_keep of addr, data: signal is 1;
  attribute opt: string;
  attribute opt of addr, data: signal is "keep";
end entity;

architecture rtl of top is
  constant MBC_KIND: MbcKind := Mbc5; -- Mbc1 or Mbc5
begin
  rwr_n <= prg_n;

  gen_mbc5: if MBC_KIND = Mbc5 generate
    mbc5_inst: entity work.mbc5
    port map (
      reset_n => reset_n,
      wr_n => wr_n,
      addr => addr(15 downto 12),
      data => data(3 downto 0),
      ra => ra);
  end generate;

  gen_mbc1: if MBC_KIND = Mbc1 generate
    mbc1_inst: entity work.mbc1
    port map (
      reset_n => reset_n,
      wr_n => wr_n,
      addr => addr(15 downto 13),
      data => data(3 downto 0),
      ra => ra);
  end generate;
end architecture;
