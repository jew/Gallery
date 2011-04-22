package Gallery::Controller::Show_user_album;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Show_user_album - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my $login_user= $c->user->user_id;
    
    $c->stash(albums => [$c->model('DB::Album')->search({user_id=>$login_user})]);

    $c->stash(template => 'show_user_album.tt');  	
}

sub delete_album :Path('/delete/') :Args($album_id){
	my ( $self, $c ) = @_;
	
	
	
	
	
	
}
=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
