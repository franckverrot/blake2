require 'mkmf'
$CFLAGS += ' -std=c99'
create_makefile 'blake2_ext'
