VCS_OPTIONS = -full64 -sverilog -CFLAGS -DVCS -fsdb 
FILELISTS = ${PWD}/filelist.f
OUTPUT = ${PWD}/sim

comp:
	vcs ${VCS_OPTIONS} -file ${FILELISTS} -o ${OUTPUT}
clean:
	${RM} -rf sim.daidir
	${RM} -rf csrc
	${RM} ucli.key
	${RM} ${OUTPUT}
