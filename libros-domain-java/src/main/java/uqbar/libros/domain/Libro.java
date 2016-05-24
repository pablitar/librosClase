package uqbar.libros.domain;

import org.apache.commons.lang.StringUtils;
import org.uqbar.commons.model.UserException;

/**
 * 
 * @author jfernandes
 */
public class Libro {
	private int id;
	private String titulo;
	private String autor;

	public Libro(int id, String titulo, String autor) {
		this.id = id;
		this.titulo = titulo;
		this.autor = autor;
	}
	
	// solo para Json.fromObject (backend en play)
	public Libro() {
	}
	
	public int getId() {
		return this.id;
	}

	public String getTitulo() {
		return this.titulo;
	}

	public String getAutor() {
		return this.autor;
	}
	
	public void validar() {
		assertNotEmpty(this.titulo, "Titulo es requerido");
		assertNotEmpty(this.autor, "Autor es requerido");
	}

	protected static void assertNotEmpty(String fieldValue, String message) {
		if (StringUtils.isEmpty(fieldValue)) throw new UserException(message);
	}
	
}
