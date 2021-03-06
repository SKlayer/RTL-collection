--------------------------------------------------------------------------
--2010 CESCA @ Virginia Tech
--------------------------------------------------------------------------
--This program is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this program.  If not, see <http://www.gnu.org/licenses/>.
--------------------------------------------------------------------------
library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity sbox_us00 is
   port(
      din   :in  std_logic_vector(7 downto 0);
      dout  :out std_logic_vector(7 downto 0);
      rst_n :in  std_logic;
      clk   :in  std_logic

   );
end sbox_us00;


--signal declaration
architecture RTL of sbox_us00 is
signal sig_0:std_logic_vector(8 downto 0);
signal dout_int:std_logic_vector(7 downto 0);


--lookup table declaration
Type rom_table_0 is Array (Natural range <>) of std_logic_vector(8 downto 0);
constant T : rom_table_0 := (B"001100011",B"001111100",B"001110111",B"001111011",
	B"011110010",B"001101011",B"001101111",B"011000101",
	B"000110000",B"000000001",B"001100111",B"000101011",
	B"011111110",B"011010111",B"010101011",B"001110110",
	B"011001010",B"010000010",B"011001001",B"001111101",
	B"011111010",B"001011001",B"001000111",B"011110000",
	B"010101101",B"011010100",B"010100010",B"010101111",
	B"010011100",B"010100100",B"001110010",B"011000000",
	B"010110111",B"011111101",B"010010011",B"000100110",
	B"000110110",B"000111111",B"011110111",B"011001100",
	B"000110100",B"010100101",B"011100101",B"011110001",
	B"001110001",B"011011000",B"000110001",B"000010101",
	B"000000100",B"011000111",B"000100011",B"011000011",
	B"000011000",B"010010110",B"000000101",B"010011010",
	B"000000111",B"000010010",B"010000000",B"011100010",
	B"011101011",B"000100111",B"010110010",B"001110101",
	B"000001001",B"010000011",B"000101100",B"000011010",
	B"000011011",B"001101110",B"001011010",B"010100000",
	B"001010010",B"000111011",B"011010110",B"010110011",
	B"000101001",B"011100011",B"000101111",B"010000100",
	B"001010011",B"011010001",B"000000000",B"011101101",
	B"000100000",B"011111100",B"010110001",B"001011011",
	B"001101010",B"011001011",B"010111110",B"000111001",
	B"001001010",B"001001100",B"001011000",B"011001111",
	B"011010000",B"011101111",B"010101010",B"011111011",
	B"001000011",B"001001101",B"000110011",B"010000101",
	B"001000101",B"011111001",B"000000010",B"001111111",
	B"001010000",B"000111100",B"010011111",B"010101000",
	B"001010001",B"010100011",B"001000000",B"010001111",
	B"010010010",B"010011101",B"000111000",B"011110101",
	B"010111100",B"010110110",B"011011010",B"000100001",
	B"000010000",B"011111111",B"011110011",B"011010010",
	B"011001101",B"000001100",B"000010011",B"011101100",
	B"001011111",B"010010111",B"001000100",B"000010111",
	B"011000100",B"010100111",B"001111110",B"000111101",
	B"001100100",B"001011101",B"000011001",B"001110011",
	B"001100000",B"010000001",B"001001111",B"011011100",
	B"000100010",B"000101010",B"010010000",B"010001000",
	B"001000110",B"011101110",B"010111000",B"000010100",
	B"011011110",B"001011110",B"000001011",B"011011011",
	B"011100000",B"000110010",B"000111010",B"000001010",
	B"001001001",B"000000110",B"000100100",B"001011100",
	B"011000010",B"011010011",B"010101100",B"001100010",
	B"010010001",B"010010101",B"011100100",B"001111001",
	B"011100111",B"011001000",B"000110111",B"001101101",
	B"010001101",B"011010101",B"001001110",B"010101001",
	B"001101100",B"001010110",B"011110100",B"011101010",
	B"001100101",B"001111010",B"010101110",B"000001000",
	B"010111010",B"001111000",B"000100101",B"000101110",
	B"000011100",B"010100110",B"010110100",B"011000110",
	B"011101000",B"011011101",B"001110100",B"000011111",
	B"001001011",B"010111101",B"010001011",B"010001010",
	B"001110000",B"000111110",B"010110101",B"001100110",
	B"001001000",B"000000011",B"011110110",B"000001110",
	B"001100001",B"000110101",B"001010111",B"010111001",
	B"010000110",B"011000001",B"000011101",B"010011110",
	B"011100001",B"011111000",B"010011000",B"000010001",
	B"001101001",B"011011001",B"010001110",B"010010100",
	B"010011011",B"000011110",B"010000111",B"011101001",
	B"011001110",B"001010101",B"000101000",B"011011111",
	B"010001100",B"010100001",B"010001001",B"000001101",
	B"010111111",B"011100110",B"001000010",B"001101000",
	B"001000001",B"010011001",B"000101101",B"000001111",
	B"010110000",B"001010100",B"010111011",B"000010110");


begin


   --combinational logics
   dpCMB: process (sig_0,dout_int,din)
      begin
         sig_0 <= (others=>'0');
         dout_int <= (others=>'0');
         dout <= (others=>'0');

         sig_0 <= T(conv_integer(unsigned(din)));
         dout <= dout_int;
         dout_int <= sig_0(7 downto 0);
      end process dpCMB;
end RTL;
