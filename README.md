# Alcance proyecto
- Versión básica: con persistencia con SwiftData
- Vesión media: opción de filtros customizados
- Versión avanzada: login, registro y sincronización de colecciones

## Versión básica

### Custom view
Distribución customizada para iPad.

### Pantalla Inicio

Se han añadido listas con todas las categorizaciones: autores, gemografía, temática y género, a través de las cuales se puede acceder a una lista filtrada por cada una.
Se ha añadido también un listado con el Top 10 de mangas, donde se indica en la card si está guardado en la colección con un icono violeta.
Si se pulsa en cualquier card se permite navegar al detalle del manga.
Incluye pull to refresh para poder refrescar todos los datos.

### Pantalla Mi colección

Grid con las colecciones de mangas guardadas. 
Cada card refleja el volumen que se está leyendo, los volúmenes adquiridos y si está completa.
Si se pulsa en la card permite ir al detalle de la colección.

### Detalle del manga

Pantalla con toda la información del manga: imagen, título, sinopsis, autores, si está completada.
Además desde esta pantalla se permite añadir/eliminar el manga a la colección.
En caso de estar añadida se informa de los datos de la colección y se permite editar dichos datos.

## Versión media

### Pantalla Filtrado

Pantalla que contiene el listado de mangas con paginación. La paginación se ha hecho vertical para dar mejor experiencia de usuario.
Se permite elegir el tipo de filtrado: categorías, empieza/contiene y personalizado.
También hay una opción de eliminar filtros aplicados.
Las cards indican si el manga está añadido a la colección y permiten navegar al detalle del mismo.

### Detalle y grid
Ambos están añadidos en la versión básica.

## Versión avanzada

- Se ha añadido un control de acceso con login y registro (con validaciones de formatos).
- También se añadió control de refresco de token.
- Opción de poder cerrar sesión en una sección de "Mi cuenta".
- Control de token con cierre de sesión.
- Sincronización de la colección de la nube con la local.

## Otros

- Vistas para el control de estados de la vista: loading con redacted, vista error y vista sin datos
- Localización de la app en español e inglés



