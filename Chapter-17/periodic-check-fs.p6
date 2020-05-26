react {
    whenever Supply.interval(@*ARGS[0]) {
	with volumes-info()</> {
            say "Free M ", (.<free>/2**20).Int,
            "- Used ", .<used%>
	}
    }
}
