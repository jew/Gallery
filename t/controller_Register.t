use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::Register;

ok( request('/register')->is_success, 'Request should succeed' );
done_testing();
