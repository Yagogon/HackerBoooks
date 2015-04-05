#Práctica HackerBooks

**¿Qué métodos similares existen a isKindOfClass:?**

**¿En qué se distingue isMemberOfClass:?**

isKindOfClass devuelve YES si es una instancia de esa clase o una subclase de esta, isMemberOfClass devuelve YES solo si es instancia de esa clase en concreto.

**¿Donde guardarías las imágenes de portada y los pdfs?**

Las imágenes ahora mismo, haciéndolo de forma bloqueante, las guardaría en Documents, usando bloques lo haría en cache y las cargaría al estilo Twitter.

Los PDFs los guardaría en Documents siempre, con posibilidad de eliminarlos, para no tirar tanto de la tarifa de datos del usuario en momentos donde no tenga wifi.

**¿Cómo harías para persistir los favoritos?**

Para usar un solo origen de datos lo que hice fue modificar el JSON que almaceno en local para marcar los libros como favoritos, pudiendo crear con este archivo toda la estructura a la hora de cargar la información.

Otra forma sería almacenar en otro archivo diferente el array de libros favoritos

**¿Cómo harías para enviar información del AGTBook a AGTLibraryViewTableController?**

La forma más lógica sería con notificaciones, ya que es información que puede interesar a diferentes controladores, otro camino sería implementar un protocolo y que el controlador sea el delegado

**¿Es una aberración desde el punto de vista del rendimiento usar reloadData de tableView?**

No, a fin de cuentas solo carga bajo demanda, solo pedirá información para aquellas celdas que sean visibles.

**¿Hay una forma alternativa?, ¿Cuando crees que vale la pena usarlo?**

Se podría actualizar solo la sección o las filas afectadas. Sería una buena opción si el coste de recuperar la información de las celdas fuera muy alto.

**¿Cómo actualizarías el AGTSImplePDFViewController al seleccionar un libro en la tabla?**

Enviando una notificación desde la tabla con el libro, al recibirla actualizaría el modelo y sincronizaría con la vista.

#Extras

**¿Qué funcionalidades le añadirías antes de subirla a la App Store?**

Opciones para añadir y eliminar libros y en la vista del PDF herramientas para traducir texto, marcar páginas, hacer notas, guardar el avance...

**Usando esta app como plantilla, ¿qué otras versiones se te ocurren y como monetizarlas?**

Una tabla con las fiestas a nivel de CCAA con información de que hacer, que llevar, mapa con los puntos y actividades a realizar...
