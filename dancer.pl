use strict;
use warnings;

use Dancer;
use Dancer::Logger;
use Data::Dumper;
use Routes;
use Auth;

set logger => 'console';

hook 'before' => sub {
	debug 'pattern: ', request->{_route_pattern};
	my $route = request->{_route_pattern};
	my $route_roles = Auth->get($route);
	if ($route_roles eq 'none') {
		return;
	}
	
	debug 'session: ', session;
 	my $user_roles = session 'roles';


	my $is_authorized = 0;
	foreach my $route_role (@$route_roles) {
		if (grep { $_ eq $route_role } @$user_roles) {
			$is_authorized = 1;
			last;
		}
	}
	
	if (!$is_authorized) {
		debug(session('username') . "is not authorized to access $route");
		status 403;
		halt 'You are not authorized';
	}
};

dance;   	
