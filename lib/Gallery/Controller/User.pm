package Gallery::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(template => 'user/register.tt');
}
sub register :Path :Args(0) {
	my ( $self, $c ) = @_;
	if($c->req->method eq 'POST') {
	   	my $user_id = $c->request->param('user_id');
	   	my $user_name = $c->request->param('user_name');
	   	my $password = $c->request->param('password');
	   	my $email = $c->request->param('email');
	   	my $first_name = $c->request->param('first_name');
	   	my $last_name = $c->request->param('last_name');

	}
	else {
	
	}
	
}	
	
	

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
