use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
                              module_name       => 'File::ConfigDir::Plack',
                              license           => 'perl',
                              dist_author       => q{Jens Rehsack <rehsack@cpan.org>},
                              dist_version_from => 'lib/File/ConfigDir/Plack.pm',
                              build_requires    => {
                                                  'Test::More' => '0.90',
                                                },
                              requires => {
                                            'File::ConfigDir'           => '0.008',
                                            'File::Basename' => 0,
                                            'File::Path'     => '2.00',
                                            'File::Spec'     => 0,
                                          },
                              add_to_cleanup => ['File-ConfigDir-Plack-*'],
                              meta_merge     => {
                                  resources => {
                                      repository => "https://github.com/perl5-utils/File-ConfigDir-Plack",
                                  },
                                  prereqs => {
                                               develop => {
                                                     requires => {
                                                         'Test::CPAN::Changes'                 => 0,
                                                         'Test::CheckManifest'                 => 0,
                                                         'Test::Pod'                           => 0,
                                                         'Test::Pod::Coverage'                 => 0,
                                                         'Test::Pod::Spelling::CommonMistakes' => 0,
                                                     },
                                                     recommends => {},
                                               },
                                             },
                                            },
                              test_files => join( ' ' => 't/*.t xt/*.t' ),
);

$builder->create_build_script();
