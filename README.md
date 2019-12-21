# quizSwiftUI
Proyecto de Quiz, en SwiftUI, para la asignatura de Ingeniería Web.

No está correctamente implementado la View para que se vea bien al girar la pantalla.

# Funcionamiento

Primera pantalla: formada por una View (RowView) que contiene la foto, la estrella que indica si la pregunta es favorito o no, y la propia pregunta. Descargas todas de una URL. 

Se pasa a la segunda pantalla, mediante un NavigationLink con un ForEach (en la ContentView)

Segunda pantalla: Pantalla que saca todos los detalles del quiz al que hemos pulsado en la primera pantalla. Si pulsamos en la estrella que hay en la foto, se marcará como favorito en el servidor local cambiando el valor de favourite = true.

Las descargas del JSON, de las imágenes y el método para hacer o deshacer favoritos está en "Model"
