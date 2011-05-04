package Gallery::Controller::Home;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Home - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index
show all albums
=cut

sub home :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $albums_rs = $c->model( 'DB::Album' );
    $c->stash( albums_rs => $albums_rs );
    $c->stash( template  => 'home.tt' );
}


=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
