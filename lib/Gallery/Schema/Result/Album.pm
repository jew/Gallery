package Gallery::Schema::Result::Albums;
use base "DBIx::Class";
__PACKAGE__->load_components(qw/TimeStamp Core/);
__PACKAGE__->table("Albums");
__PACKAGE__->add_columns(
    "album_id"		=> { data_type => "INT", 		is_nullable => 0, },
	"album_name" 	=> { data_type => "VARCHAR", 	is_nullable => 1,	 size => 255, },
	"created_date" 	=> { data_type => 'datetime',	set_on_create => 1, set_on_update => 1 },
		
);

__PACKAGE__-> set_primary_key( "album_id ", "user_id" );
__PACKAGE__-> belongs_to( "users","Gallery::Schema::Result::Users",
	{ user_id => "users"},);
__PACKAGE__-> has_many( "pictures" => 'Gallery::Schema::Result::Pictures',
{"foreign.album_id"=>"self.album_id"},
);
1;