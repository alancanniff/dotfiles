namespace eval lsp {

    proc create_config {fname} {
        
        set fd [open [file normalize $fname] "w"]

        puts $fd "{"
        puts $fd "    \"options\": {"
        puts $fd "        \"ghdl_analysis\": \["
        puts $fd "            \"--std=08\","
        puts $fd "            \"--workdir=work\","
        puts $fd "            \"--ieee=standard\""
        puts $fd "        ]"
        puts $fd "    },"
        puts $fd ""
        puts $fd "    \"files\": \["

        set filelist {}
        foreach fn [get_files *.vhd] {
            lappend filelist "        { \"file\": \"$fn\", \"language\": \"vhdl\" }"
        }
        puts $fd [join $filelist ",\n"]

        puts $fd "    ]"
        puts $fd "}"

        close $fd
    }
}

# lsp::create_config "hdl-prj.json"
