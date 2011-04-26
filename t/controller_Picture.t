use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::Picture;

ok( request('/picture')->is_success, 'Request should succeed' );
done_testing();
