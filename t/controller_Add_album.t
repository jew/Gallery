use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::Add_album;

ok( request('/add_album')->is_success, 'Request should succeed' );
done_testing();
