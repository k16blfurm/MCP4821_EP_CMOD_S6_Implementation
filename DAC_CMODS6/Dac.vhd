----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:13:05 09/02/2019 
-- Design Name: 
-- Module Name:    Dac - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComp

entity Dac is
port(
	VDD: out std_logic;
	CS: out std_logic;
	SCK: out std_logic;
	SDI: out std_logic;
	LDAC: out std_logic;
	Vref: out std_logic;
	Vss: out std_logic;
	Vout: out std_logic;
	CLK_LFC: in STD_LOGIC;
	PORTB: in STD_LOGIC_VECTOR (7 downto 0);
	BTN_0: in std_logic
	);
end Dac;

architecture Behavioral of Dac is
begin
process(CLK_LFC)
begin
	
	-- Note that the delays I've used are for 5 Mz, 200 ns
	-- This is for the write command using the 10-channel dac
	if rising_edge(CLK_LFC) then 
		CS <= 1;
		LDAC <= 1;
	end if;
	
	SDI <= 0 after 200 ns;
	-- Delay here and buffer pin
	SDI <= 1 after 200 ns;
	-- set SDI to 1 for gain =1, SDI to 0 if gain is 2X
	SDI <= 1 after 200 ns;
	-- Setting SHDN to 1 (active mode operation)
	SDI <= 1 after 200 ns;
	-- The next bits will be written to the DAC from existing ports on the board
	-- Since this is just a test, we'll write to the DAC from PORTB and loop for extra channels 
	SDI <= PORTB(0) after 200 ns;
	SDI <= PORTB(1) after 200 ns;
	SDI <= PORTB(2) after 200 ns;
	SDI <= PORTB(3) after 200 ns;
	SDI <= PORTB(4) after 200 ns;
	SDI <= PORTB(5) after 200 ns;
	SDI <= PORTB(6) after 200 ns;
	SDI <= PORTB(7) after 200 ns;
	SDI <= PORTB(0) after 200 ns;
	SDI <= PORTB(1) after 200 ns;
	SDI <= PORTB(2) after 200 ns;
	SDI <= PORTB(3) after 200 ns;
	-- note that the DAC type doesn't matter (8 10 or 12 channel), all of the bits get thrown away after anyways
	-- stop writting to DAC now
	if rising_edge(CLK_LFC) then
		CS <= 0;
		LDAC <= 0;
		Vout <= 1;
	end if;
	end process;
end Behavioral;

