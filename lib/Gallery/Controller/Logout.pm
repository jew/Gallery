package Gallery::Controller::Logout;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

=head2 index

    Logout logic

=cut

sub index :Path :Args(0) {
	my ($self, $c) = @_;
	# Clear the user's state
	$c->logout;
	# Send the user to the starting point
    $c->response->redirect($c->uri_for('/home'));
}

=head1 AUTHOR

jew,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
