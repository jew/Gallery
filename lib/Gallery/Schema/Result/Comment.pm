package Gallery::Schema::Result::Comments;
use base "DBIx::Class";
__PACKAGE__->load_components(qw/TimeStamp Core/);
__PACKAGE__->table("comments");
__PACKAGE__->add_columns(
    "comment_id"	=> { data_type => "INT", 		is_nullable => 0, },
	"comment" 		=> { data_type => "VARCHAR", 	is_nullable => 1, size => 255, },
	"c_date" 		=> { data_type => 'datetime',	set_on_create => 1, set_on_update => 1 }	
);
__PACKAGE__-> set_primary_key( "comment_id" );
__PACKAGE__-> has_many( 'user_comments' => 'Gallery::Schema::Result::User_comments', { "foreign.comment_id" => "self.comment_id" });
__PACKAGE__-> many_to_many( uses => 'user_comments', 'user');

1;