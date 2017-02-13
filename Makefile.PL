use 5.024000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'USB::FX5DMX',
    VERSION_FROM      => 'lib/USB/FX5DMX.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/USB/FX5DMX.pm', # retrieve abstract from module
    AUTHOR            => 'ghandi <ghandi@(none)>',
    #LICENSE           => 'perl',
    #Value must be from legacy list of licenses here
    #http://search.cpan.org/perldoc?Module%3A%3ABuild%3A%3AAPI
    LIBS              => ['-L./usbdmx/ -lusbdmx'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
	 #MYEXTLIB			=> 'usbdmx/libusbdmx$(LIB_EXT)',
);

sub MY::postamble {
'
$(MYEXTLIB): usbdmx/Makefile
		cd usbdmx && $(MAKE) libusbdmx.so $(PASSTHRU)
';
}
