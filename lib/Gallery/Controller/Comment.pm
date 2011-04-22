package Gallery::Controller::Comment;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Comment - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0){
    my ( $self, $c, $picture_id) = @_;
    my $login_user= $c->user->user_id;
    $picture_id = $c->request->param('picture_id');
    $c->log->debug("picId--->". $picture_id);
    #searching for comments
    my @comments = [$c->model('DB::Comment')->search({picture_id=>$picture_id})->all()];
    $c->stash(comments=>@comments);
    #get path : return row
    my $path = $c->model('DB::Picture')->find($picture_id)->path; 
    $c->stash(path => $path);
    $c->stash(template => 'comment/list.tt');
}

=head3 base 

=cut

sub base :Chained('/') :PathPart('comment') :CaptureArgs(1){
    my ( $self, $c, $picture_id) = @_;
    my $login_user= $c->user->user_id;
    #$picture_id = $c->request->param('picture_id');
    $c->stash(picture_id => $picture_id);
  
   # my $picture = $c->model('DB::Picture')->find({picture_id=>$picture_id});
    #$c->log->debug("----------->" . $picture_id);
    #$c->stash(picture => $picture);
    #$c->stash(template => 'comment/add_comment.tt');
}

=head2 new_comment

Create  new comment

=cut
sub add :Local :Args(0){
    my ( $self, $c ) = @_;
    my $picture_id = $c->request->param('picture_id');
    #get path 
    my $path = $c->model('DB::Picture')->find($picture_id)->path; 
    $c->log->debug("path------>" . $path);
    $c->stash(path => $path);
    if($c->req->method eq 'POST') {        
        $c->model('DB::Comment')->create({
						picture_id => $picture_id,
						comment =>$c->req->param('comment'),
        });
      
        #$c->stash(template => 'comment/add_comment.tt');
        $c->response->redirect( ($c->uri_for('/comment/showcomment')).'?picture_id=' .$picture_id );
       
        
        
    }
    else {
        # Dump a log message to the development server debug output
        $c->log->debug('***There are someone who trying to post comment by Get method***');
        $c->stash(template => 'comment/add_comment.tt');
        
    };
}

=head2 index

=cut

sub delete :Chained('base') :Args(0){
    my ( $self, $c) = @_;
 	my $comment_id = $c->request->param('comment_id'); 
    if($c->req->method eq 'POST') {
    	#delete comment	
	    $comment_id = $c->request->param('comment_id');
		$c->model('DB::Comment')->find($comment_id)->delete;
        $c->response->redirect($c->uri_for('/comment', { picture_id => $c->stash->{picture_id} } ));
    }
    else {
        $c->stash(title    => 'Delete comment');
        $c->stash(template => 'comment/delete.tt');
    }; 
}



=head2 showcomment after do comment

=cut
sub showcomment :Local :Args(0){
    my ( $self, $c) = @_;
    my $login_user= $c->user->user_id;
    my $picture_id = $c->request->param('picture_id'); 
    $c->log->debug("picId--->". $picture_id);
    #searching for comments
    my @comments = [$c->model('DB::Comment')->search({picture_id=>$picture_id})->all()];
    $c->stash(comments=>@comments);
    #get path : return row
    my $path = $c->model('DB::Picture')->find($picture_id)->path; 
    $c->stash(path => $path);
    $c->stash(template => 'comment/showcomment.tt');
}





=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
