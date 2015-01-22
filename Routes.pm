package Routes;

use Dancer;
use Auth;
Auth->set('/hello/:name', ['admin']);
Auth->set('/login', 'none');

get '/hello/:name' => sub {
	return 'hello, ' . params->{name};
};

get '/login' => sub {
	session username => 'chris';
	session->{roles} = ['admin'];
	return to_json({ msg => "You are not logged in!" });
};

return 1;
