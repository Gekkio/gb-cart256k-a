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

entity mbc1 is
  port (
    reset_n: in std_logic;
    wr_n: in std_logic;
    addr: in std_logic_vector(15 downto 13);
    data: in std_logic_vector(3 downto 0);
    ra: out std_logic_vector(17 downto 14));
end entity;

architecture rtl of mbc1 is
  signal bank1: std_logic_vector(3 downto 0) := "0001";
  signal bank1_clk: std_logic;
begin
  ra <= "0000" when addr(14) = '0' else bank1;

  process(addr, wr_n)
  begin
    bank1_clk <= '1';
    if wr_n = '0' then
      case addr(15 downto 13) is
	when "001" => bank1_clk <= '0';
	when others =>
      end case;
    end if;
  end process;

  process(reset_n, bank1_clk)
  begin
    if reset_n = '0' then
      bank1 <= "0001";
    elsif rising_edge(bank1_clk) then
      if data(3 downto 0) = "0000" then
	bank1 <= "0001";
      else
	bank1 <= data(3 downto 0);
      end if;
    end if;
  end process;
end architecture;
