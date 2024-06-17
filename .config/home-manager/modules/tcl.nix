{config, pkgs, ...}:
{
  home.packages = [
    pkgs.tcl
    pkgs.tclreadline
  ];

  home.file.".tclshrc".text = ''
    if {$tcl_interactive} {
      if {![catch {package require tclreadline}]} {
        namespace eval ::tclreadline {
          proc prompt1 {} { return "%% " }
          proc prompt2 {} { return " > " }
        }
        ::tclreadline::Loop "${config.xdg.stateHome}/tcl-history"
      }
    }
  '';
}
