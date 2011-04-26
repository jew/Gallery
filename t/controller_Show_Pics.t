use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::Show_Pics;

ok( request('/show_pics')->is_success, 'Request should succeed' );
done_testing();
