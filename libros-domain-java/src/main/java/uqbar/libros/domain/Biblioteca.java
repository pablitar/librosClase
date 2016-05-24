package uqbar.libros.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.uqbar.commons.model.UserException;


public class Biblioteca {
	private static final Biblioteca general = new Biblioteca();
	private List<Libro> libros = new ArrayList<Libro>();
	private int id = 0;

	public Biblioteca() {
		this.agregarLibro("Las venas abiertas de América Latina", "Eduardo Galeano");
		this.agregarLibro("Guerra y Paz", "León Tolstoi");
		this.agregarLibro("Patas Arriba", "Eduardo Galeano");
		this.agregarLibro("El fútbol a sol y a sombra", "Eduardo Galeano");
		this.agregarLibro("Historia del siglo XX", "Eric Hobsbawm");
		this.agregarLibro("Ficciones", "Jorge Luis Borges");
		this.agregarLibro("El Aleph", "Jorge Luis Borges");
		this.agregarLibro("La invención de Morel", "Adolfo Bioy Casares");
		this.agregarLibro("Rayuela", "Julio Cortázar");
		this.agregarLibro("El barón rampante", "Italo Calvino");
		this.agregarLibro("El vizconde demediado", "Italo Calvino");
		this.agregarLibro("100 años de soledad", "Gabriel García Márquez");
		this.agregarLibro("Un día en la vida de Ivan Denisovich", "Alexander Solyenitsin");
		this.agregarLibro("El día del arquero", "Juan Sasturain");
	}

	public static Biblioteca getGeneral() {
		return general;
	}

	public Libro agregarLibro(String titulo, String autor) {
		Libro libro = new Libro(this.id++, titulo, autor);
		return agregarLibro(libro);
	}

	public Libro agregarLibro(Libro libro) {
		this.libros.add(libro);
		return libro;
	}
	
	
	public void actualizarLibro(Libro actualizado) {
		this.libros.set(indiceDe(actualizado.getId()), actualizado);
	}

	protected int indiceDe(int idLibro) {
		int i = 0;
		for (Libro libro : this.libros) {
			if (libro.getId() == idLibro) {
				return i;
			}
		}
		throw new UserException("No existe el libro con id '" + idLibro + "'");
	}

	public List<Libro> buscarPorTitulo(String titulo) {
		List<Libro> seleccionDeLibros = new ArrayList<Libro>();
		for (Libro libro : this.libros) {
			if (contiene(libro.getTitulo(), titulo)) {
				seleccionDeLibros.add(libro);
			}
		}
		return seleccionDeLibros;
	}
	
	public List<Libro> buscar(String criterio) {
		List<Libro> seleccionDeLibros = new ArrayList<Libro>();
		for (Libro libro : this.libros) {
			if (contiene(libro.getTitulo(), criterio) || contiene(libro.getAutor(), criterio)) {
				seleccionDeLibros.add(libro);
			}
		}
		return seleccionDeLibros;
	}
	
	public List<Libro> deAutor(String autor) {
		List<Libro> seleccionDeLibros = new ArrayList<Libro>();
		for (Libro libro : this.libros) {
			if (libro.getAutor().toLowerCase().equals(autor.toLowerCase())) {
				seleccionDeLibros.add(libro);
			}
		}
		return seleccionDeLibros;
	}
	
	/**
	 * Compara si un string contiene a otro, no importa el case.
	 */
	public static boolean contiene(String uno, String otro) {
		return uno.toLowerCase().contains(otro.toLowerCase());
	}

	public Libro getLibro(int id) {
		for (Libro libro : this.libros) {
			if (libro.getId() == id) {
				return libro;
			}
		}
		throw new UserException("No tengo ese libro, man. (el del id = " + id + ")");
	}
	
	public void eliminarLibro(int id) {
		this.libros.remove(this.getLibro(id));
	}
	
	public Collection<Libro> todasLasInstancias() {
		return this.libros;
	}

}
