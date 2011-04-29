package Gallery::Controller::Picture;
use Moose;
use namespace::autoclean;
use URI::Escape;
use File::Basename;
use Catalyst qw/Request::Upload/;
use DBI;
use DBIx::Class::ResultSet;
BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Picture - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

   
}

=head3 base
get picture_id
Store the ResultSet from Picture in stash so it's available for other methods
=cut

sub base :Chained('/') :PathPart('picture') :CaptureArgs(1){
    my ( $self, $c,$picture_id) = @_;
    $c->stash(picture_id =>  $picture_id);
    #Store the ResultSet from  delete
    $c->stash(picture => $c->model('DB::Picture')->search({picture_id=>$picture_id}));
    #$c->stash(template => 'picture/show_pics.tt');
    #$c->stash(title    => 'Show Picture');
}

=head3 add
add picture 
=cut
sub add :Local :Args(0) {
    my ( $self, $c ) = @_;   
    # Retrieve the values from the form
	my $imagepath   = $c->request->params->{imagepath};
	my $imagename   = $c->request->params->{imagename};
	my $description   = $c->request->params->{description};
    my $upload = $c->request->upload('imagepath');
    my $imagegallerypath = $c->config->{'imagefallerypath'};
    my $login_user= $c->user->user_id;
    $c->stash( albums =>[$c->model('DB::Album')->search({user_id=>$login_user})]);
    my $album_id   = $c->request->params->{album_id};
	#Upload
    if (!$upload) {
    	$c->log->debug('No upload');
		$c->stash(template => 'picture/upload.tt',result=>'No upload');
		$c->stash(title    => 'Upload Picture');
    	return 1;
    }
   	my $upload_result = $upload->copy_to($imagegallerypath);
	$c->log->debug("UPLOAD_RESULT---->" .$upload);
  	if ($imagename eq '') { $imagename = $upload->filename;}
  	my($imagetmpname) = fileparse($upload->tempname);
   		if ($upload_result==1) {
			$c->stash(status_msg => "Upload complete!");
			#Save image to table 'pictures'
			my $picture= $c->model('DB::Picture')->update_or_create({
						#picture_id =>$max,
						path => $imagetmpname,
						name  => $imagename,
						description => $description,
						user_id => $login_user,
						album_id=> $album_id,
			});
			#if album's thumbnail = '' ==> insert current image to thumbnail
				if ($picture->get_column('thumbnail') eq '') {
				# get name 
					$imagetmpname =~ s/\.[^.]*$//;
        			my $name= $imagetmpname ;;
					my $thumb_name = ($name ."_low.png");
					$picture->update( {
					thumbnail => $thumb_name, 	
					});
				}
   		} else {
    		 $c->stash(error_msg => "Upload fail!");
    		 $c->stash(title    => 'Upload Picture');
    	}   
    $c->stash(template => 'picture/upload.tt');  
    $c->stash(title    => 'Upload Picture');
}

=head2 delete
delete picture
=cut
sub delete :Chained('base') :PathPart('delete') :Args(0){ 
    my ( $self, $c) = @_;
     if($c->req->method eq 'POST') {
        $c->stash->{picture}->delete;
        $c->response->redirect($c->uri_for('/album'));
    }
    else {
        $c->stash(title    => 'Delete Picture');
        $c->stash(template => 'picture/delete.tt');
}; 

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;
}
1;
