package File::ConfigDir::Plack;

use 5.006;

use strict;
use warnings FATAL => 'all';
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

use Carp qw(croak);
use Exporter ();
require File::Basename;
require File::Spec;
use File::ConfigDir ();

=head1 NAME

File::ConfigDir::Plack - Plack plugin for File::ConfigDir

=cut

$VERSION = '0.001';
@ISA     = qw(Exporter);
@EXPORT  = ();
@EXPORT_OK = (
               qw(plack_app_dir plack_env_dir),
             );
%EXPORT_TAGS = (
                 ALL => [@EXPORT_OK],
               );

my $plack_app;
BEGIN
{
    defined $ENV{PLACK_ENV} and $plack_app = $0;
}

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use File::ConfigFir 'config_dirs';
    use File::ConfigDir::Plack;

    my @dirs = config_dirs();

=head1 EXPORT

This module doesn't export anything by default. You have to request any
desired explicitly.

=head1 SUBROUTINES/METHODS

=head2 plack_app_dir

Returns the configuration directory of a L<Plack> application.

=cut

my $plack_app_dir = sub {
    my @dirs;

    defined $plack_app and push( @dirs, File::Basename::dirname($plack_app) );

    return @dirs;
};

sub plack_app_dir
{
    my @cfg_base = @_;
    0 == scalar(@cfg_base)
      or croak "plack_app_dir(), not plack_app_dir("
      . join( ",", ("\$") x scalar(@cfg_base) ) . ")";
    return &{$plack_app_dir}();
}

=head2 plack_env_dir

Returns the environment directory of a L<Plack> application.

=cut

my $plack_env_dir = sub {
    my @dirs;

    defined $ENV{PLACK_ENV} and push( @dirs, map { File::Spec->catdir( $_, "environment", $ENV{PLACK_ENV} ) } $plack_app_dir->() );

    return @dirs;
};

sub plack_env_dir
{
    my @cfg_base = @_;
    0 == scalar(@cfg_base)
      or croak "plack_app_dir(), not plack_app_dir("
      . join( ",", ("\$") x scalar(@cfg_base) ) . ")";
    return &{$plack_app_dir}();
}

my $registered;
$registered or do {
    File::ConfigDir::_plug_dir_source($plack_app_dir, ++$registered);
    File::ConfigDir::_plug_dir_source($plack_env_dir, ++$registered);
};

=head1 AUTHOR

Jens Rehsack, C<< <rehsack at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-file-configdir-plack at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=File-ConfigDir-Plack>.
I will be notified, and then you'll automatically be notified of progress
on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc File::ConfigDir::Plack

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=File-ConfigDir-Plack>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/File-ConfigDir-Plack>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/File-ConfigDir-Plack>

=item * Search CPAN

L<http://search.cpan.org/dist/File-ConfigDir-Plack/>

=back

=head1 ACKNOWLEDGEMENTS

Celogeek San inspired that module by including L<MooX::ConfigFromFile>
into L<Jedi>.

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Jens Rehsack.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.

=cut

1; # End of File::ConfigDir::Plack
