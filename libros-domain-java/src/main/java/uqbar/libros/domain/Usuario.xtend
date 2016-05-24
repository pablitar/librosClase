package uqbar.libros.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

class Usuario {
	@Accessors
	String nombreUsuario
	@Accessors
	Biblioteca biblioteca = new Biblioteca
	
	new() {
		
	}
	
	new(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario
	}
	
	def librosNoLeidos(List<Libro> libros) {
		libros.filter[!biblioteca.todasLasInstancias.contains(it)]
	}
	
	def agregarLibroLeido(Libro libro) {
		biblioteca.agregarLibro(libro)
	}
	
}