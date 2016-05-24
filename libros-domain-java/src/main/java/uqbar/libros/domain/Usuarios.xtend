package uqbar.libros.domain

import java.util.List
import java.util.NoSuchElementException

class Usuarios {
	List<Usuario> usuarios = newArrayList()
	
	public static val instance = new Usuarios
	
	new() {
		val pepe = new Usuario("pepe")
		Biblioteca.getGeneral.todasLasInstancias.filter[
			#["Ficciones","El Aleph", "Patas Arriba"].contains(it.titulo)
		].forEach[
			pepe.agregarLibroLeido(it)
		]
		this.agregarUsuario(pepe)
	}
	
	def agregarUsuario(Usuario u) {
		this.usuarios.add(u)
	}
	
	def encontrarUsuario(String nombreUsuario) {
		val usuario = this.usuarios.findFirst[it.nombreUsuario == nombreUsuario]
		if(usuario == null) {
			throw new NoSuchElementException()
		}
		usuario
	}
}