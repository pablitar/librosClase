app.factory('Libros', function($resource) {
    return $resource('/libros/:id', {'id': '@id'}, {
    	'query': { method: 'GET', isArray: true},
        'update': { method: 'PUT' },
        'save': { method: 'POST' },
        'remove': { method:'DELETE' }
    });
});

app.factory('LibrosNoLeidos', function($resource) {
    return $resource('/librosNoLeidos/:usuario', 
    		{'usuario': '@usuario'}, {
    	'porAutor': { method: 'GET', isArray: true, 
    		params:{'autor': '@autor'}}
    });
});





















