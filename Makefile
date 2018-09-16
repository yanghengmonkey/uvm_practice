VCS_OPTIONS = -full64 -sverilog -CFLAGS -DVCS -fsdb -debug_all -debug_acess+all -kdb -lca
RUN_OPTIONS = +UVM_VERBOSITY=UVM_HIGH DUMP=1 +UVM_TIMEOUT=10000000
FILELISTS = ${PWD}/filelist.f
OUTPUT_DIR = ${PWD}/out

comp:
	vcs ${VCS_OPTIONS} -file ${FILELISTS} -o ${OUTPUT_DIR}/sim
run:
	${OUTPUT_DIR}/sim ${RUN_OPTIONS}

all:
	make comp && make run
clean:
	${RM} -rf sim.daidir
	${RM} -rf csrc
	${RM} ucli.key
	${RM} ${OUTPUT}
