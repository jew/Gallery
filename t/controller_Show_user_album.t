use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::Show_user_album;

ok( request('/show_user_album')->is_success, 'Request should succeed' );
done_testing();
