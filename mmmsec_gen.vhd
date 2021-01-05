library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

Entity mmsec_gen is
  port (nRst : in std_logic;
        clk : in std_logic;
        start : in std_logic;
        stop_code : in std_logic;
        mmsec_sig : out std_logic);
end mmsec_gen;

Architecture beh of mmsec_gen is
  signal mmsig : std_logic :='0';
  signal cnt : integer range 0 to 2;
  
begin
  process(nRst, clk, start)
  begin
    if (nRst='0') then
      cnt <= 0;
      mmsig <= '0';
    elsif (start = '0') or(stop_code = '1') then
      mmsig <= '0';
    elsif rising_edge(clk) then
      if (cnt = 2) then
        cnt <= 0;
        mmsig <= not (mmsig);
      else
        cnt <= cnt+1;
      end if;
    end if;
  end process;
  
  mmsec_sig <= mmsig;

end beh;
