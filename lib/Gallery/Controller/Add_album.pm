package Gallery::Controller::Add_album;
use Moose;
use namespace::autoclean;
use DBI;
use DBIx::Class::ResultSet;
BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Add_album - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
   	my $album_name = $c->request->params->{album_name};
   	my $userid = $c->user->user_id;

  
	#my $links = $c->model('DB::Album')->search_rs( { user_id => 1 }, {order_by => 'album_id DESC'})->single();
	#my $link = $links->album_id;
	#$c->log->debug("max user id === $link");

	my $links = $c->model('DB::Album')->search_rs( { user_id => $userid });
	my $album_ids = $links->get_column('album_id');
	my $maxalbum_id = $album_ids->max;
	$c->log->debug("maxalbum_id === $maxalbum_id");
	my $max;
	if($maxalbum_id ==0){
		$max = 1;
		
	}
	else {
		
		$max = $maxalbum_id+1;
	}
	
	
    my $r = $links->update_or_create(
    {
       album_id =>$max,
       user_id =>$userid,  
       album_name =>  $album_name 
          
     });

	#if($r->album_id) {
	
			#$c->(statusmsg=>"Successful");

	
	#}



	 $c->log->debug("Debug link".$r->album_id);
	 
    $c->stash(template => 'add_album',albumname=>$album_name,maxalbum_id=>$max,userid=>$userid);
}


=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
