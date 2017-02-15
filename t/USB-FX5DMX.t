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

my $serials = USB::FX5DMX::GetAllConnectedInterfaces();
is(ref($serials), "ARRAY", "is an array ref");
ok(scalar(@$serials) > 0, "there is a device connected") or BAIL_OUT("No serial number found. Probably no FX5 DMX USB-Interface connected! Can't continue!");
isnt($serials->[0], "0000000000000000", "there is a valid serial number");
foreach my $serial (@$serials) {
	is(length($serial), 16, "serial is exactly 16 bytes long");
}

my $openSerials = USB::FX5DMX::GetAllOpenedInterfaces();
is(ref($openSerials), "ARRAY", "is an array ref");
ok(scalar(@$openSerials) == 0, "no opened interfaces");
USB::FX5DMX::OpenLink($serials->[0]);
is(scalar(@{USB::FX5DMX::GetAllOpenedInterfaces()}), 1, "opened one device");
USB::FX5DMX::CloseLink($serials->[0]);
is(scalar(@{USB::FX5DMX::GetAllOpenedInterfaces()}), 0, "all devices closed again");

done_testing;
