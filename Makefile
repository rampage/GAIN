ERL          ?= erl
ERLC 				 ?= erlc
EBIN_DIRS    := $(wildcard deps/*/ebin)

.SUFFIXES: .erl .beam
.erl.beam:
	erlc -W $<

all: erl

erl:
	@mkdir -p ebin
	@$(ERL) -pa $(EBIN_DIRS) -noinput +B \
          -eval 'case make:all() of up_to_date -> halt(0); error -> halt(1) end.'

erlc:
	@mkdir -p ebin
	$(ERLC) -I include -I deps +debug_info -o ebin src/*.erl 

clean:
	rm -rf *.beam ebin/*.beam src/*.beam erl_crash.dump 
