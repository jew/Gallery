package Gallery::Controller::Upload;
use Moose;
use namespace::autoclean;
use URI::Escape;
use File::Basename;
use Catalyst qw/Request::Upload/;
use DBI;
use DBIx::Class::ResultSet;
BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Upload - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut
#TODO:album_ID still dont have 
sub index :Path :Args(0) {
    my ($self, $c) = @_;
    
    # Retrieve the values from the form
	my $imagepath   = $c->request->params->{imagepath}    || '';
	my $imagename   = $c->request->params->{imagename}    || '';
	my $description   = $c->request->params->{description}    || '';
    my $upload = $c->request->upload('imagepath');
    my $imagegallerypath = $c->config->{'imagefallerypath'};
    my $login_user= $c->user->user_id;
    my $album_id   = $c->request->params->{album_id};
    $c->log->debug("ALBUM ID----->". $album_id);
    
    
#Upload
    if (!$upload) {
    	$c->log->debug('No upload');
		$c->stash(template => 'upload.tt',result=>'No upload');
    	return 1;
    }
    #find max of picture_id 
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
			#$c->stash(template => 'upload.tt',result=>"Yes U Can");
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
					$imagetmpname =~ s/\.[^.]*$//;;
        			my $name=$1;
					my $thumb_name = $name ."_low.png";
					$picture->update( {
					thumbnail => $thumb_name, 	
					});
				}
   		} else {
    		 $c->stash(error_msg => "Upload fail!");
			#$c->stash(template => 'upload.tt',result=>"No U Cant");	
    	}
    
	
    $c->stash(template => 'upload.tt');  	
}
__PACKAGE__->meta->make_immutable;

1;