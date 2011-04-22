package Gallery::Controller::AddComment;
use Moose;
use namespace::autoclean;
use DBI;
use DBIx::Class::ResultSet;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::AddComment - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $album_id   = $c->request->params->{album_id};
	my $picture_id   = $c->request->params->{picture_id};
	my $path   = $c->request->params->{path};
	my $comment   = $c->request->params->{comments};
	my $user_id= $c->user->user_id;
	$c->log->debug("---->".$path);
    $c->stash( template => 'add_comment.tt',album_id=>$album_id,picture_id=>$picture_id,user_id=>$user_id,path=>$path);
    
    
    
    #Fetch Comment from Comments
	my @comments = [$c->model('DB::Comment')->search({album_id=>$album_id,picture_id=>$picture_id})->all()];
	$c->log->debug("comments----------------------------------------------------->".@comments);
    $c->stash(comments=>@comments);
    
    
    #Find Max comment_id
    my $links = $c->model('DB::Comment');
	my $comment_ids = $links->get_column('comment_id');
	my $maxcomment_id = $comment_ids->max;
	#$c->log->debug("maxalbum_id === $maxalbum_id");
	my $max;
	if($maxcomment_id ==0){
		$max = 1;
		
	}
	else {
		
		$max = $maxcomment_id+1;
	}
    
    #$c->log->debug("max------>". $max."Comment---->".$comment);
    
    #add comment to database 
	my $result_add= $c->model('DB::Comment')->update_or_create({
						album_id =>$album_id,
						picture_id => $picture_id,
						comment => $comment,
			}); 
}


=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
