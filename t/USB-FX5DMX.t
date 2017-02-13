# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl USB-FX5DMX.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use Data::Dumper;

use Test::More;
BEGIN { use_ok('USB::FX5DMX') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(USB::FX5DMX::ThisIsWorking(), 1, "works");

my $serials = USB::FX5DMX::GetInterfaces();
is(ref($serials), "ARRAY", "is an array ref");
ok(scalar(@$serials) > 0, "there is a device connected") or BAIL_OUT("Either no USB-Interface connected, or fatal error!");
isnt($serials->[0], "0000000000000000", "there is a valid serial number");

done_testing;
