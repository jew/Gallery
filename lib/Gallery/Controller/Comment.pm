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
From menu: view your album
show picture and comment of user album and user can delete pic and comment 
=cut

sub index :Path :Args(0){
    my ( $self, $c, $picture_id) = @_;
    my $login_user= $c->user->user_id;
    $picture_id = $c->request->param('picture_id');
    #$c->log->debug("picId--->". $picture_id);
    #searching for comments
    my @comments = [$c->model('DB::Comment')->search({picture_id=>$picture_id}, {order_by => 'c_date DESC'})->all()];
    $c->stash(comments=>@comments);
    #get path : return row
    my $path = $c->model('DB::Picture')->find($picture_id)->path; 
    $c->stash(path => $path);
    $c->stash(template => 'comment/list.tt');
    $c->stash(picture_id=>$picture_id);
}

=head3 base 
get picture_id
=cut
sub base :Chained('/') :PathPart('comment') :CaptureArgs(1){
    my ( $self, $c, $picture_id) = @_;
    $c->stash(picture_id => $picture_id);

}

=head2 new_comment
Create  new comment
=cut
sub add :Local :Args(0){
    my ( $self, $c ) = @_;
    my $picture_id = $c->request->param('picture_id');
    my $login_user= $c->user->user_id;
    $c->log->debug("->" . $login_user);
    #get path 
    my $path = $c->model('DB::Picture')->find($picture_id)->path; 
    $c->log->debug("path------>" . $path);
    $c->stash(path => $path);
    if($c->req->method eq 'POST') {        
        $c->model('DB::Comment')->create({
						picture_id => $picture_id,
						comment =>$c->req->param('comment'),
						user_id =>  $login_user,
        });
        $c->response->redirect( ($c->uri_for('/comment/showcomment')).'?picture_id=' .$picture_id );      
    }
    else {
        $c->stash(template => 'comment/add_comment.tt');
        #$c->stash(template => 'comment/showcomment.tt');
        
    };
}

=head2 delete
delete comment
=cut

sub delete :Chained('base') :Args(0){
    my ( $self, $c) = @_;
 	my $comment_id = $c->request->param('comment_id'); 
    if($c->req->method eq 'POST') {
    	#delete comment	
		$c->model('DB::Comment')->find($comment_id)->delete;
		#stash->{picture_id} from chain
        $c->response->redirect($c->uri_for('/comment', { picture_id => $c->stash->{picture_id} } ));
    }
    else {
        $c->stash(title    => 'Delete comment');
        $c->stash(template => 'comment/delete.tt');
    }; 
}



=head2 
showcomment after do comment
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
    $c->stash(template => 'comment/showcomment.tt',picture_id=>$picture_id);
}

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
