use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Gallery';
use Gallery::Controller::AddComment;

ok( request('/addcomment')->is_success, 'Request should succeed' );
done_testing();
