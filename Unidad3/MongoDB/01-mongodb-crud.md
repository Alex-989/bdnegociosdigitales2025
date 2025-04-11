# Mongodb Crud

## Crear una base de datos

**Solo se crea si contiene por lo menos una coleccion**

```json
use basededatos
```

# Crear una Collection

`usedb1
db.createCollection('Empleado')`

## Mostrar colleciones
`show collections`

## Inserccion de un documento 
db.Empleado.insertOne(
    {
        nombre: 'Soyla',
        apellido: 'Vaca',
        edad: 32,
        ciudad: 'San Miguel de las Piedras'
    }
)

## Insercion de un documento mas complejo con array
- Un jason siempre lleva llavez
```json
db.Empleado.insertOne(
    {
        nombre: 'Ivan',
        apellido: 'Baltazar',
        apellido2: 'Rodriguez',
        aficiones: ['Cerveza', 'Canabis', 'Crico']
    }
)
```
**Eliminar una coleccion**
```json
db.collection.drop()
```
_Ejemplo_
```json
db.empleado.drop()
```
## Insercion de documentos mas complejos con anidados, arrays y ID

```json
db.alumnos.insertOne
({
    nombre: 'Jose Luis',
    apellido1: 'Herrera',
    apellido2: 'Gallardo',
    edad: 41,
    estudios:[
        'Ingenieria en Sistemas Computacionales',
        'Maestria en Administracion de Tecnologias de la Informacion'
    ],
    experiencia: {
        lenguaje: 'SQL',
        sgb: 'SQL Server',
        anios_experiencia: 20
    }
})
```
```json

db.alumnos.insertOne({
    _id:3,
    nombre:'Sergio',
    apellido: 'Ramos',
    equipo: 'Monterrey',
    aficiones:['Dinero', 'Hombres', 'Fiesta'],
    talentos:{
        futbol: true,
        banarse: false
    }
})

## Insertar Multiples Documentos
```json
db.alumnos.insertMany(
[
    {
        id:12,
        nombre: 'Oswaldo',
        apellido: 'Venado',
        edad: 20,
        descripcion: 'Es un quejumbroso'
    },
    {
        nombre: 'Maritza',
        apellido: 'Rechiken',
        edad: 20,
        habilidades:[
            'Ser Vibora', 'Ilusionar', 'Caguamear'
        ],
        direccion: {
            calle: 'Del infierno',
            numero: 666
        },
        esposos:[
            {
                nombre:'Joshua',
                edad:20,
                pension:-34,
                hijos:['Ivan', 'Jose']
            },
            {
                nombre:'Leo',
                edad: 15,
                pension: 70,
                complaciente: true
            }
        ]
    }
]
)
```

# Busquedas, Condiciones Simples de igualdad Metodos find()
1. Seleccionar todos los documentos de la coleccion libros
```json
db.libros.find({})
```
2. Seleccionar todos los documentos que sean de la editorial biblio
```json
db.libros.find({editorial:'Biblio'})
```
3. Seleccionar todos los documentos que el precio sea 25
```json
db.libros.find({precio:25})
```
4. Seleccionar todos los documentos donde el titulo sea 'jason para todos'
```json
db.libros.find({titulo: 'JSON para todos'})
```

## Operadores de comparacion
[Operadores de Comparacion](https://www.mongodb.com/docs/manual/reference/operator/query/)
![Operadores de comparacion](./img/operadores-Relacionales.png)

1. Mostrar todos los documentos donde el precio sea mayor a 25

```json
db.libros.find({precio:{$gt : 25}}) 
```

2. Mostrar lso documentos donde el precio sea 25
```json
db.libros.find({precio: {$eq : 25}})
```
3. Mostrar los documentos cuya cantidad sea menor a 5
```json
db.libros.find({cantidad: {$lt : 5}})
```
4. Mostrar todos los documentos que pertenecen a la editorial biblio o planeta
```json
db.libros.find(
    {
        editorial: {
            $in:['Planeta', 'Biblio']
        }
    }
)
```
5. Mostrar todos los documentos de libros que cuesten 20 o 25
```json
db.libros.find(
    {
        precio: {
            $in:[20, 25]
        }
    }
)
```
6. Recuperar todos los documentos que no custen 20 o 25
```json
db.libros.find(
    {
        precio: {
            $nin:[20, 25]
        }
    }
)
```
## Instruccion findOne

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condicion)
```json
db.libros.findOne(
    {
        precio: {
            $in:[20, 25]
        }
    }
)
```

## Operadores logicos

[Operadores Logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

## Operador AND

- Dos posibles opciones

1. La simple, mediante condiciones separadas por comas
db.libros.find(condicion1, condicion2, ...) -> Con esto asume que es una and
2. Usando el operador $and
    { $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }
    db.libros.find($and:[{condicion 1}, {condicion 2}])

1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 15

```json
db.libros.find({precio:{$gt:25}, 
                cantidad: {$lt:15}})

db.libros.find({$and:[{precio:{$gt:25}},
                {cantidad:{$lt:15}}]})
```

-----------------------------

### Operador or ($or)

- Mostrar todas aquellos libros que cuesten mas de 25 o cuya cantidad sea inferior a 15

```json
db.libros.find(
        {
            $or:[
                {
                    precio:{$gt:25}
                },
                {
                    cantidad:{$lt:15}
                }
                ]
         }
 )
 ```

### Ejemplo con AND y OR Conbinados 

- Mostrar los libros de la editorial Biblio con precio mayor a 30 o libros de la editorial Planeta con precio mayor a 20

```json
db.libros.find(
       {
        $and:[
            {$or: [{editorial: 'Biblio'}, {precio:{$gt:40}}]},
            { $or: [{editorial:{$eq:'Planeta'}}, {precio:{$gt:30}}]}
        ]
       }

)
```

### Proyeccion (Ver ciertas columnas)

*Sintaxis*
```json
db.coleccion.find(filtro, columnas)
```

1. Seleccionar todos los libros, solo mostrando el titulo 
json

```json
db.libros.find({},{titulo: 1})
db.libros.find({},{titulo: 1, _id:0})
```

```json
db.libros.find(
    {editorial: 'Planeta'},
    {_id:0, titulo:1, editorial: 1, precio:1 }
)
```

### Operador exists (Permite saber si un campo se encuentra o no en un documento)

[Operador exists](https://www.mongodb.com/docs/manual/reference/operator/query/exists/)
{ field: { $exists: <boolean> } }

```json
db.libros.find({editorial:{$exists:true}})
```

```json
db.libros.insertOne(
{
    _id:10,
    titulo: 'Mongo en Negocios Digitales',
    editorial: 'Terra',
    precio: 125
}
)
```

- Buscar todos los documentos que no tengan cantidad 

```json
db.libros.find({
    cantidad:{$exists: false}
})
```

## Operador Type (Permite solicitar a MongoDB si un campo corrsponde a un tipo)

[Operador type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)

- Mostrar todos los documentos donde le precio sea de tipo double o entero o cualquier otro tipo de dato

```json
    db.libros.find({
        precio:{$type:1}
    })
```

```json
    db.libros.find({
        precio:{$type:16}
    })
```

```json
    db.libros.find({
        precio:{$type:"int"}
    })
```

```json
db.libros.insertMany(
    [
        {
            _id:12,
            titulo:'IA',
            editorial:'Terra',
            precio: 125,
            cantidad:20
        },
        {
            _id:13,
            titulo:'Python para todos',
            editorial: 2001,
            precio:200,
            cantidad:30
        }
    ]
)
```

- Seleccionar todos los documentos de libros donde la editorial sea strings

```json
db.libros.find(
{
    editorial:{$type:'string'}
})
```

```json
db.libros.find(
{
    editorial:{$type:2}
});
```

```json
db.libros.find(
{
    editorial:{$type:16}
});
```

# Modificando Documentos
## Comandos Importantes
1. UpdateOne -> Modifica un solo documento
1. UpdateMany -> Modificar multiples documentas
1. replaceOne -> Sustituir el contenido completo de un documento

Tiene el siguiente formato

```json
db.collection.updateOne(
    {filtro},
    {operador:}
)
```
[Operador Update](https://www.mongodb.com/docs/manual/reference/operator/update/)

**Operador $set**

1. Modificar un documento
```json
    db.libros.updateOne({titulo: 'Python para todos'},{$set: {titulo: 'Java para todos'}})
```

db.libros.insertOne(
    {
        _id:10,
        titulo: 'Mon'
    }
)

- Modificar el documento con id 10, estableciendo el precio en 100 y la cantidad en 50
```json
db.libros.updateOne({_id: 10},{$set: {precio: 100}},{$set: {cantidad: 50}})

db.libros.updateOne(
    {
        _id: 10
    },
    {
        $set: {precio: 100, cantidad: 50}
    }
)
```
- Utilizando el updateMany, modificar todos los libros donde el precio sea mayor a 100 cambiarlo por 150
```json
db.libros.updateMany(
    {
        precio: {$gt: 100}
    },
    {
       $set: {precio: 150}
    }
)
```

## Operadores $inc y $mul

- Incrementar todos los precios de los  libros en 5
```json
db.libros.updateMany(
    {editorial: 'Terra'},
    {
        $inc: {precio:5}
    }
)
```

-  Multiplicar todos los libros donde la cantidad sea mayor a 20, en su cantidad x2
```json
db.libros.updateMany(
    {
        cantidad: {$gt: 20}
    },
    {
        $mul: {cantidad: 2}
    }
)

 db.libros.find({_id:{$in: [1,7,10,13]}}) // Solucion con in
```

- Actualizar todos los libros multiplicando por 2 la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20

```json
db.libros.updateMany({precio: {$gt: 20}},{$mul{cantidad: 2, precio: 2}})
```

## Reemplazar documentos (replaceOne)


- actualizar todo el documento del _id 2 por el titulo 'De la tierra a la luna', autor 'julio verne', editorial Terra, precio 100
```json
db.libros.replaceOne(
    {
        _id: 2
    },
    {
        titulo: 'De la tierra a la luna',
        autor: 'Julio Verne',
        editorial: 'Terra',
        precio: 100
    }
)


db.libros.replaceOne(
    {
        _id: 2
    },
    {
        titulo: 'La vida inutil de pito perez'
    }
)
```


## Borrar documentos

1. deleteOne -> Elimina un solo documento
2. deleteMany -> Elimina multiples documentos

- Elimina el documento con el id 2

```json
db.libros.deleteOne({_id: 2})
```

- eliminar todos los libros donde la cantidad es mayor a 150
```json
db.libros.deleteMany({cantidad: {$gt: 150}})
```

## Expresiones Regulares

- Seleccionar todos los libros que contengan en el titulo una t minuscula
```json
db.libros.find({titulo: /t/})
```

- Seleccionar todos los libros que en el titulo contenga la palabra JSON
```json
db.libros.find({titulo: /json/})

db.libros.find({titulo: /JSON/})
```
- Seleccionar todos los libros que en el titulo terminen con tos
```json
db.libros.find({titulo: /tos$/})
```
- Seleccionar todos los libros que en el titulo comiencen con J
```json
db.libros.find({titulo: /^J/})
```
## Operador $regex

[Operador Regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

- Seleccionar los libros que contengan la palabra "para" en el titulo
```json
db.libros.find({titulo: {$regex: 'para'}})


db.libros.find({titulo: {$regex: /para/}})

```

- Seleccionar todos los titulos que contengan la palabra JSON
```json
db.libros.find({titulo:{$regex: 'JSON'}})

db.libros.find({titulo:{$regex: /JSON/}})
```

- Distinguir entre mayusculas y minusculas
```json
db.libros.find({titulo:{$regex: /json/i}})

{ <field>: { $regex: /pattern/, $options: '<options>' } } // Sintaxis

db.libros.find({titulo:{$regex: /json/,  $options: 'i'}})
```
- Seleccionar todos los documentos de libros donde el titulo comience con j y no distinga entre mayusculas y minusculas
```json
db.libros.find({titulo:{$regex: /^j/,  $options: 'i'}})
```
- Seleccionar todos los documentos de libros donde el titulo termine con "es" y no distinga entre mayusculas y minusculas

```json
db.libros.find({titulo: {$regex: 'es$', $options: 'i'}})
```

## Metodo sort (Ordenar Documentos)

- Ordenar los libros de manera ascendente por el precio

```json
db.libros.find({},{_id: 0,titulo:1,precio:1}).sort({precio:1})
```

- Ordenar los libros de manera descendente por el precio

```json
db.libros.find({},{_id: 0,titulo:1,precio:1}).sort({precio:-1})
```
- Ordenar los libros de manera ascendente por la editorial y de manera descendente por el precio mostrando el titulo, el precio y la editorial 
```json
db.libros.find({}, {_id: 0 , titulo: 1, precio: 1, editorial: 1}).sort({editorial: 1, precio: -1})
```
## Otros Metodos skip, limit, size
```json
db.libros.find({}).size() // Mide cuantos libros tienes

db.libros.find({titulo:{$regex: /^j/,  $options: 'i'}}).size() // Cuantos libros tienes con la letra J
```
- Buscar todos los libros pero mostrando los 2 primeros
```json
db.libros.find({}).limit(2)
```
- Seleccionar todos los libros pero saltandose los dos primeros 
```json
db.libros.find({}).skip(2)
```
# Borrar colecciones y base de datos
```json
db.libros.drop()

db.dropDatabase()
```