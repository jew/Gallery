use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::ShowPic;

ok( request('/showpic')->is_success, 'Request should succeed' );
done_testing();
