my $default_kill = "Preferences SpringBoard";

NIC->variable("KILL_PROCS") = "";

my $kill_apps = NIC->prompt("KILL_APPS", "List of applications to terminate upon installation (space-separated, '-' for none)", {default => $default_kill});
if ($kill_apps ne "-") {
	NIC->variable("KILL_PROCS") = "INSTALL_TARGET_PROCESSES = ".$kill_apps."\n";
}
