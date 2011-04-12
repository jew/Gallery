package Gallery::Schema::Result::Pictures;
use base "DBIx::Class";
__PACKAGE__->table("pictures");
__PACKAGE__->add_columns(
    "picture_id"		=> { data_type => "INT", 		is_nullable => 0, },
	"description" 		=> { data_type => "VARCHAR", 	is_nullable => 1, size => 255, },
);

__PACKAGE__-> set_primary_key( "album_id" ,"user_id","picture_id" );
__PACKAGE__-> belongs_to( "albums","Gallery::Schema::Result::Albums",
	{"foreign.picture_id"=>"self.picture_id"},
);
1;