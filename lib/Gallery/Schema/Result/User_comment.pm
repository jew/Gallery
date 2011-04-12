package Gallery::Schema::Result::User_comments;
use base "DBIx::Class";
__PACKAGE__->table("user_comments");
__PACKAGE__->add_columns(
    "user_id"		=> { data_type => "INT", 	is_nullable => 0, },
    "comment_id"	=> { data_type => "INT", 	is_nullable => 0, },	
);
__PACKAGE__-> set_primary_key( "user_id","comment_id");
__PACKAGE__-> belongs_to( "users","Gallery::Schema::Result::Users",
	{"foreign.user_id"=>"self.id"},);
__PACKAGE__-> belongs_to( "comments","Gallery::Schema::Result::Comments",
	{"foreign.comment_id"=>"self.comment_id"},);
1;