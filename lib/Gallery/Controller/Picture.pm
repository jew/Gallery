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


=head3 index

=cut

sub base :Chained('/') :PathPart('picture') :CaptureArgs(1){
    my ( $self, $c,$picture_id) = @_;
    my $login_user= $c->user->user_id;
    $c->stash(picture_id =>  $picture_id);
    $c->stash(picture => $c->model('DB::Picture')->search({picture_id=>$picture_id}));
    $c->stash(template => 'picture/show_pics.tt');
}

=head3 add picture to table Picture

=cut
sub add :Local :Args(0) {
    my ( $self, $c ) = @_;   
      # Retrieve the values from the form
	my $imagepath   = $c->request->params->{imagepath}    || '';
	my $imagename   = $c->request->params->{imagename}    || '';
	my $description   = $c->request->params->{description}    || '';
    my $upload = $c->request->upload('imagepath');
    my $imagegallerypath = $c->config->{'imagefallerypath'};
    my $login_user= $c->user->user_id;
    #search for albums 
    $c->stash( albums =>[$c->model('DB::Album')->search({user_id=>$login_user})]);
    my $album_id   = $c->request->params->{album_id};
    #$c->log->debug("ALBUM ID----->". $album_id);
	#Upload
    if (!$upload) {
    	$c->log->debug('No upload');
		$c->stash(template => 'picture/upload.tt',result=>'No upload');
    	return 1;
    }
    #find max of picture_id  $c->response->body('Matched Gallery::Controller::Picture in Picture.');
	my $links = $c->model('DB::Picture')->search_rs( { user_id => $login_user });
	my $picture_ids = $links->get_column('picture_id');
	my $maxpicture_id = $picture_ids->max;
	#$c->log->debug("MAXPICID ------------------->". $maxpicture_id);
	my $max;
	if($maxpicture_id == 0){
		$max = 1;
	}
	else {
		
		$max = $maxpicture_id+1;
	}
	#debug Max picture_id 
	$c->log->debug("MAX PIC ID --->".$max);
	$c->log->debug("imagegallerypath------------>".	$imagegallerypath);
	#$c->log->debug("DEBUG UPLOAD" .$upload);		

    #Use random name in gallery folder / store imagename in DB
   	my $upload_result = $upload->copy_to($imagegallerypath);
	$c->log->debug("UPLOAD_RESULT---->" .$upload);
  	if ($imagename eq '') { $imagename = $upload->filename;}
  	my($imagetmpname, $tmpdirectory, $suffix) = fileparse($upload->tempname);
    #$c->log->debug("Upload Basename-------->".$upload->basename);
   	#$c->log->debug('*** Upload result: '.$upload_result.' name:'.$imagename.' tmp:'.$imagetmpname.' tempname: '.$upload->tempname);
	#$c->log->debug("basename==================k> ".$upload->tempname);
	$c->log->debug("pictureID---->".$max);
	$c->log->debug("path--->" . $imagetmpname);
	$c->log->debug("name--->".$imagename);
	$c->log->debug("user_id---->".  $login_user);
	$c->log->debug("albumid----->". $album_id);
	$c->log->debug("-description-->".$description);
	#If upload success ==> continue
   		if ($upload_result==1) {
			$c->stash(status_msg => "Upload complete!");
			#Save image to table 'pictures'
			my $picture= $c->model('DB::Picture')->update_or_create({
						picture_id =>$max,
						path => $imagetmpname,
						name  => $imagename,
						description => $description,
						user_id => $login_user,
						album_id=> $album_id,
			});
			#if album's thumbnail = '' ==> insert current image to thumbnail
				if ($picture->get_column('thumbnail') eq '') {
				# chang name 19 April
					$imagetmpname =~ s/\.[^.]*$//;
					$c->log->debug("imagetmpname------------------->".$imagetmpname);
					$c->log->debug("$1------------------------------->" . $1);
        			my $name= $imagetmpname ;
        			$c->log->debug("NAME------------------------------->" . $name);
					my $thumb_name = ($name ."_low.png");
					$c->log->debug("thumb_name------------------------------->" . $thumb_name);
					$picture->update( {
					thumbnail => $thumb_name, 	
					});
				}
   		} else {
    		 $c->stash(error_msg => "Upload fail!");
    	}   
    $c->stash(template => 'picture/upload.tt');  
}

=head2 delete

=cut
#--------------------------------------------------------------------------------ว๊ากกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกกก
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
