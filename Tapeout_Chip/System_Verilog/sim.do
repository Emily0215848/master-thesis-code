vsim -voptargs=+acc work.test_SQRD_top_spi
view structure wave signals

do wave.do

log -r *
run -all

