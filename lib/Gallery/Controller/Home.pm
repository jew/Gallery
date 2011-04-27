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

sub index :Path :Args(0) {
	my ( $self, $c) = @_;
	my $albums_rs = $c->model('DB::Album');
	
    #Search for first pic to make thumbnail
     while ( my $album = $albums_rs->next() ) {
         my $picture = $album->pictures()->first(); #First picture for each album
         next if !$picture;
         $c->model('Thumb')->thumbmake( Gallery->path_to('/root/gallery') . '/' . $picture->path );
     }
    $c->stash( albums_rs => $albums_rs);
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
