object knightrider {
    method peso() = 500

    method nivelDePeligrosidad() = 10
    method bultos() = 1

    method consecuenciasDeLaCarga() {}
}

object bumblebee {
    var formaActual = auto

    method bultos() = 2

    method cambiarForma(nuevaForma) { formaActual = nuevaForma}

    method peso() = 800

    method nivelDePeligrosidad() = formaActual.nivel()

    method consecuenciasDeLaCarga() {
        formaActual = robot
        self.cambiarForma(robot)
    }

}

object auto {
    method nivel() = 15
}

object robot {
    method nivel() = 30
}

object paqueteDeLadrillos {
    var cantidadDeLadrillos = 10

    method bultos() {
        if(cantidadDeLadrillos <= 100){
            return 1
        } else if (cantidadDeLadrillos.between(101, 300)) {
            return 2
        } else {return 3}
    }

    method peso() = 2 * cantidadDeLadrillos

    method nivelDePeligrosidad() = 2

    method cambiarCantidad(cantidad) {
        cantidadDeLadrillos = cantidad
    }

    method consecuenciasDeLaCarga() {cantidadDeLadrillos += 12}
}

object arena {
    var property peso = 10

    method nivelDePeligrosidad() = 1 
    method bultos() = 1

    method consecuenciasDeLaCarga() {peso = (peso-10).max(0)}
}

object bateria {
    var estaConMisiles = false

    method bultos() = if(estaConMisiles) 2 else 1

    method peso() = if (estaConMisiles) 300 else 200

    method nivelDePeligrosidad() = if (estaConMisiles) 100 else 0

    method cargarYDescargarMisiles() { estaConMisiles = !estaConMisiles}

    method consecuenciasDeLaCarga() {estaConMisiles = true}
}

object contenedor {
    const cosasContenidas = []

    method bultos() = 1 + self.bultosDeCosasContenidas()

    method bultosDeCosasContenidas() = cosasContenidas.sum({ c => c.bultos()})

    method peso() = 100 + self.pesoDeCosasContenidas()

    method pesoDeCosasContenidas() = cosasContenidas.sum({ c => c.peso() })

    method nivelDePeligrosidad() = if (!cosasContenidas.isEmpty()) self.cosaContenidaMasPeligrosa().nivelDePeligrosidad() else 0

    method cosaContenidaMasPeligrosa() = cosasContenidas.max({ c => c.nivelDePeligrosidad() })

    method meterElementos(listaDeElementos) {
        cosasContenidas.addAll(listaDeElementos)
    }

    method consecuenciasDeLaCarga() {
        cosasContenidas.forEach({c => c.consecuenciasDeLaCarga()})
    }
}

object residuos {
    var property peso = 10

    method bultos() = 1

    method nivelDePeligrosidad() = 200

    method consecuenciasDeLaCarga() {peso += 15}
}

object embalaje {
    var cosaQueEnvuelve = residuos

    method peso() = cosaQueEnvuelve.peso()

    method bultos() = 2

    method nivelDePeligrosidad() = cosaQueEnvuelve.nivelDePeligrosidad() * 0.5

    method cambiarLoQueEnvuelve(nuevaCosa) {
        cosaQueEnvuelve = nuevaCosa
    }

    method consecuenciasDeLaCarga() {}
}
