class Mago{ 
    const objetosMagicos = []
    var poderInnato = 1
    const nombre
    const resistenciaMagica = 0
    var categoria
    var energiaMagica = 0

    method nombre() = nombre 

    method poderInnato(){
        if(!poderInnato.between(1, 10)){
            self.error("El poder innato debe estar entre 1 y 10")
        }
        return poderInnato
    }

    method reasignarPoderInnato(valor){
        poderInnato = valor
    }

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

    method esVencido(atacante) = categoria.esVencido(self, atacante) 

    method cambiarCategoria(nuevaCategoria){
        categoria = nuevaCategoria
    }

    method energiaMagicaQuePierde() = categoria.energiaMagicaQuePierde(self)

    method robarEnergiaMagica(magoOGremio){
        self.ganarEnergiaMagica(magoOGremio.energiaMagicaQuePierde())
        magoOGremio.perderEnergiaMagica(magoOGremio.energiaMagicaQuePierde())
    }

    method desafiar(magoOGremio){
        if(!magoOGremio.esVencido(self)){
           self.error("No pudo vencer al mago que desafió.") 
        }
        self.robarEnergiaMagica(magoOGremio)
    }
}

class ObjetoMagico{
    const poderBase = 0

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
    const miembros = []

    method miembros(){
        if(miembros.size() < 2){
            self.error("No cuenta con miembros suficientes")
        }
        return miembros
    }
    
    method poderTotal() = miembros.sum({m => m.poderTotal()})

    method energiaMagica() = miembros.sum({m => m.energiaMagica()})

    method resistenciaMagica() = miembros.sum({m => m.resistenciaMagica()})


    method lider() = miembros.max({m => m.poderTotal()})
    
    method robarEnergiaMagica(gremioOMago){
        self.lider().ganarEnergiaMagica(gremioOMago.energiaMagicaQuePierde())
        gremioOMago.perderEnergiaMagica(gremioOMago.energiaMagicaQuePierde())
    }

    method desafiar(gremioOMago){
        if(!gremioOMago.esVencido(self)){
            self.error("No puede vencer al gremio o mago desafiado.")
        }
        self.robarEnergiaMagica(gremioOMago)
    }

    method perderEnergiaMagica(cantidad){
        miembros.forEach({m => m.perderEnergiaMagica(cantidad)})
    }

    method esVencido(atacante) = atacante.poderTotal() > self.resistenciaMagica() + self.lider().resistenciaMagica()

    method energiaMagicaQuePierde() = miembros.sum({m => m.energiaMagicaQuePierde()})
}
