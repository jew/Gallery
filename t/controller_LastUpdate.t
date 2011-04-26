use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::LastUpdate;

ok( request('/lastupdate')->is_success, 'Request should succeed' );
done_testing();
