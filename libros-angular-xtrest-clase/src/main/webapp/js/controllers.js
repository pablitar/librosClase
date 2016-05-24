app.controller('TodosLosLibrosCtrl', function($resource, $timeout,
		cfpLoadingBar, Libros, LibrosNoLeidos) {
	'use strict';

	var self = this;

	self.libros = [];
	self.user = {
		name : "pepe"
	};
	
	self.noLeidos = {autor: "", libros:[]};
	
	self.autores = [];

	function errorHandler(error) {
		self.notificarError(error.data);
	}
	;
	
    function obtenerAutores(libros) {
    	libros.forEach(function(libro){
    		if(self.autores.indexOf(libro.autor) == -1) {
    			self.autores.push(libro.autor)
    		}
    	});
    }
    
    this.updateNoLeidos = function() {
    	//Buscar los libros lo leidos con self.noLeidos.autor
    	
    	LibrosNoLeidos.porAutor({
    		autor: self.noLeidos.autor,
    		usuario: self.user.name 
    	},function(libros) {
    		self.noLeidos.libros = libros;
    	}, errorHandler);
    };

	this.actualizarLista = function() {
		Libros.query(function(data) {
			self.libros = data;
		    self.noLeidos.autores = obtenerAutores(data);		
		}, errorHandler);
	};

	this.actualizarLista();

	// AGREGAR
	this.agregarLibro = function() {
		Libros.save(this.nuevoLibro, function(data) {
			self.notificarMensaje('Libro agregado con id:' + data.id);
			self.actualizarLista();
			self.nuevoLibro = null;
		}, errorHandler);
	};

	// ELIMINAR
	this.eliminar = function(libro) {
		var mensaje = "¿Está seguro de eliminar: '" + libro.titulo + "'?";
		bootbox.confirm(mensaje, function(confirma) {
			if (confirma) {
				Libros.remove(libro, function() {
					self.notificarMensaje('Libro eliminado!');
					self.actualizarLista();
				}, errorHandler);
			}
		});
	};

	// VER DETALLE
	this.libroSeleccionado = null;

	this.verDetalle = function(libro) {
		self.libroSeleccionado = libro;
		$("#verLibroModal").modal({});
	};

	// EDITAR LIBRO
	this.editarLibro = function(libro) {
		self.libroSeleccionado = libro;
		$("#editarLibroModal").modal({});
	};

	this.guardarLibro = function() {
		Libros.update(this.libroSeleccionado, function() {
			self.notificarMensaje('Libro actualizado!');
			self.actualizarLista();
		}, errorHandler);

		this.libroSeleccionado = null;
		$("#editarLibroModal").modal('toggle');
	};

	// FEEDBACK & ERRORES
	this.msgs = [];
	this.notificarMensaje = function(mensaje) {
		this.msgs.push(mensaje);
		this.notificar(this.msgs);
	};

	this.errors = [];
	this.notificarError = function(mensaje) {
		this.errors.push(mensaje);
		this.notificar(this.errors);
	};

	this.notificar = function(mensajes) {
		$timeout(function() {
			while (mensajes.length > 0)
				mensajes.pop();
		}, 3000);
	}

});
