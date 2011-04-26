use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::Album;

ok( request('/album')->is_success, 'Request should succeed' );
done_testing();
