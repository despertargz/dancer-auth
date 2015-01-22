package Auth;

my $_auth = {};

sub set {
	my $class = shift;
	my $route = shift;
	my $roles = shift;

	$_auth->{$route} = $roles;
}

sub get {
	my $class = shift;
	my $route = shift;

	return $_auth->{$route};

}	

return 1;
