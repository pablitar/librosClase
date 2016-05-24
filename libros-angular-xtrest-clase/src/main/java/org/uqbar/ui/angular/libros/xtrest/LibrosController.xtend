package org.uqbar.ui.angular.libros.xtrest

import org.uqbar.commons.model.UserException
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import uqbar.libros.domain.Biblioteca
import org.uqbar.xtrest.api.annotation.Post
import uqbar.libros.domain.Libro
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Put
import uqbar.libros.domain.Usuarios
import java.util.NoSuchElementException

/**
 * Ejemplo de controller REST/JSON en xtrest
 * 
 * @author jfernandes
 */
@Controller
class LibrosController {
	extension JSONUtils = new JSONUtils

	//	@Filter("/*")
	//	def defineJsonContentType(HandlerChain chain) {
	//		response.contentType = "application/json"
	//		chain.proceed
	//	}
	
	@Get("/libros")
	def Result libros() {
		val libros = Biblioteca.getGeneral.todasLasInstancias.clone
		response.contentType = ContentType.APPLICATION_JSON
		ok(libros.toJson)
	}

	@Get('/libros/:id')
	def Result libro() {
		val iId = Integer.valueOf(id)
		
		try {
			response.contentType = "application/json"
			ok(Biblioteca.getGeneral.getLibro(iId).toJson)
		} 
		catch (UserException e) {
			notFound("No existe libro con id '" + id + "'");
		}
	}

	@Delete('/libros/:id')
	def Result eliminarLibro() {
		try {
			val iId = Integer.valueOf(id)
			Biblioteca.getGeneral.eliminarLibro(iId)
			ok('''{ "status" : "ok" }''')
		} catch (UserException e) {
			return notFound("No existe libro con id '" + id + "'");
		}
	}

	@Get('/libros/search')
	def Result buscar(String titulo) {
		ok(Biblioteca.getGeneral.buscar(titulo).toJson)
	}

	@Post('/libros')
	def Result agregarLibro(@Body String body) {
		try {
			var nuevo = body.fromJson(Libro)

			nuevo.validar
			nuevo = Biblioteca.getGeneral.agregarLibro(nuevo.titulo, nuevo.autor)

			ok('''{ "id" : "«nuevo.id»" }''')
		} 
		catch (UserException e) {
			// badRequest(''' { "error" : "«e.message»" }''')
			badRequest(e.message)
		}
	}

	@Put('/libros/:id')
	def Result actualizar(@Body String body) {
		val actualizado = body.fromJson(Libro)
		if (Integer.parseInt(id) != actualizado.id) {
			return badRequest('{ "error" : "Id en URL distinto del cuerpo" }')
		}

		Biblioteca.getGeneral.actualizarLibro(actualizado)
		ok('{ "status" : "OK" }');
	}
	
	@Get('/librosNoLeidos/:nombreUsuario')
	def Result librosNoLeidos(String autor) {
		try{
			response.contentType = "application/json"
			val usuario = Usuarios.instance.encontrarUsuario(nombreUsuario)
			ok(usuario.librosNoLeidos(Biblioteca.getGeneral.deAutor(autor)).toList.toJson)
		} catch (NoSuchElementException nse) {
			notFound('''No se encontró el usuario con nombre de usuario = «nombreUsuario»''')
		}
	} 

	def static void main(String[] args) {
		XTRest.start(LibrosController, 9100)
	}

}
