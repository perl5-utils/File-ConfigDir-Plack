use strict;
use warnings;
use File::ConfigDir;
use File::ConfigDir::Plack;
use DDP;
 
p(%ENV);
my @config_dirs = File::ConfigDir::config_dirs;
p(@config_dirs);
 
return sub {
    my ($env) = @_;
    my $cfg_dirs = [File::ConfigDir::config_dirs];
    return [200, [], [p($env), p($cfg_dirs)]];
}
