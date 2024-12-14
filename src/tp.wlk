class Mago{ 
    var objetosMagicos = []
    var poderInnato = 0
    var nombre = ""
    var resistenciaMagica = 0
    var categoria
    var energiaMagica = 0

    method nombre() = nombre 

    method poderInnato() = poderInnato.between(1, 10)

    method poderTotal() = objetosMagicos.sum({o => o.poderBase(self)})*poderInnato

    method tieneNombrePar() = nombre.size().even()

    method resistenciaMagica() = resistenciaMagica

    method energiaMagica() = energiaMagica

    method perderEnergiaMagica(cantidad){
        energiaMagica -= cantidad
    } 

    method ganarEnergiaMagica(cantidad){
        energiaMagica += cantidad
    }

    method esVencido(mago, atacante) = categoria.esVencido(self, atacante) 

    method cambiarCategoria(nuevaCategoria){
        categoria = nuevaCategoria
    }

    method energiaMagicaQuePierde() = categoria.energiaMagicaQuePierde(self)

    method robarEnergiaMagica(otroMago){
        self.ganarEnergiaMagica(otroMago.energiaMagicaQuePierde())
        otroMago.perderEnergiaMagica(otroMago.energiaMagicaQuePierde())
    }

    method desafiar(otroMago){
        if(!otroMago.esVencido(otroMago, self)){
           self.error("No pudo vencer al mago que desafió.") 
        }
        self.robarEnergiaMagica(otroMago)
    }
}

class ObjetoMagico{
    var poderBase = 0

    method poderBase(mago){
        return poderBase
    }   
}

class Varita inherits ObjetoMagico{
    override method poderBase(mago){
        if(mago.tieneNombrePar()){
            return super(mago) + poderBase*0.5
        }
        return super(mago)
    }
}

class TunicaComun inherits ObjetoMagico{
    override method poderBase(mago){
        return super(mago) + 2*mago.resistenciaMagica()
    }
}

class TunicaEpica inherits TunicaComun{
    override method poderBase(mago){
        return super(mago) + 10
    }
}

class Amuleto inherits ObjetoMagico{
    override method poderBase(mago) = 200
}

object ojota inherits ObjetoMagico{
    override method poderBase(mago) = 10 * mago.nombre().size()
}

object aprendiz{
    method esVencido(mago, atacante) = mago.resistenciaMagica() < atacante.poderTotal()

    method energiaMagicaQuePierde(mago) = mago.energiaMagica()/2 

}

object magoVeterano{
    method esVencido(mago, atacante) = atacante.poderTotal() >= mago.resistenciaMagica()*1.5

    method energiaMagicaQuePierde(mago) = mago.energiaMagica()/4

}

object magoInmortal{
    method esVencido(mago, atacante) = false
}

class Gremio{
    var miembros = []
    
    method poderTotal() = miembros.sum({m => m.poderTotal()})

    method energiaMagica() = miembros.sum({m => m.energiaMagica()})

    method lider() = miembros.max({m => m.poderTotal()})

    method desafiar(gremio){

    }

    method esVencido(gremioAtacante){
        if()
    }
}