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

    proc create_rust_hdl_config {fname} {
        
        set fd [open [file normalize $fname] "w"]

        puts $fd "standard=\"2008\""
        puts $fd "\[libraries\]"
        puts $fd "defaultlib.files = \["
        foreach fn [get_files *.vhd] {
            puts $fd "    '$fn',"
        }
        puts $fd "\]"
        # Libraries can be marked as third-party to disable some analysis warnings, such as unused declarations
        puts $fd "UNISIM.files = \["
        puts $fd "    '/home/alan/Tools/Xilinx/Vivado/2023.1/data/vhdl/src/unisims/unisim_VCOMP.vhd',"
        puts $fd "\]"
        puts $fd "UNISIM.is_third_party = true"
        puts $fd "\[lint\]"
        puts $fd "unused = 'error' # Upgrade the 'unused' diagnostic to the 'error' severity"
        puts $fd "unnecessary_work_library = false # Disable linting for the 'library work;' statement"

        close $fd
    }
}

# lsp::create_config "hdl-prj.json"
